import GrammarModels
import ObjcParser
import ObjcParserAntlr

/// Gets as inputs a series of intentions and outputs actual files and script
/// contents.
public class SwiftWriter {
    var intentions: IntentionCollection
    var output: WriterOutput
    let context = TypeContext()
    let typeMapper: TypeMapper
    var diagnostics: Diagnostics
    let knownTypes: KnownTypeStorage
    
    public var expressionPasses: [ExpressionPass] = []
    
    public init(intentions: IntentionCollection, knownTypes: KnownTypeStorage, diagnostics: Diagnostics, output: WriterOutput) {
        self.intentions = intentions
        self.knownTypes = knownTypes
        self.diagnostics = diagnostics
        self.output = output
        self.typeMapper = TypeMapper(context: context)
    }
    
    public func execute() {
        let fileIntents = intentions.fileIntentions()
        
        for file in fileIntents {
            outputFile(file)
        }
    }
    
    private func outputFile(_ fileIntent: FileGenerationIntention) {
        let file = output.createFile(path: fileIntent.filePath)
        let out = file.outputTarget()
        let classes = fileIntent.typeIntentions.compactMap { $0 as? ClassGenerationIntention }
        let classExtensions = fileIntent.typeIntentions.compactMap { $0 as? ClassExtensionGenerationIntention }
        let protocols = fileIntent.protocolIntentions
        var addSeparator = false
        
        outputPreprocessorDirectives(fileIntent.preprocessorDirectives, target: out)
        
        for typeali in fileIntent.typealiasIntentions {
            outputTypealias(typeali, target: out)
            addSeparator = true
        }
        
        if addSeparator {
            out.output(line: "")
        }
        
        for varDef in fileIntent.globalVariableIntentions {
            outputVariableDeclaration(varDef, target: out)
            addSeparator = true
        }
        
        if addSeparator {
            out.output(line: "")
            addSeparator = false
        }
        
        for prot in protocols {
            outputProtocol(prot, target: out)
            addSeparator = true
        }
        
        if addSeparator {
            out.output(line: "")
            addSeparator = false
        }
        
        for cls in classes {
            outputClass(cls, target: out)
        }
        
        for cls in classExtensions {
            outputClassExtension(cls, target: out)
        }
        
        out.onAfterOutput()
        
        file.close()
    }
    
    public func outputPreprocessorDirectives(_ preproc: [String], target: RewriterOutputTarget) {
        if preproc.count == 0 {
            return
        }
        
        target.output(line: "// Preprocessor directives found in file:", style: .comment)
        for pre in preproc {
            target.output(line: "// \(pre)", style: .comment)
        }
    }
    
    private func outputTypealias(_ typeali: TypealiasIntention, target: RewriterOutputTarget) {
        let ctx =
            TypeMapper.TypeMappingContext(explicitNullability: SwiftWriter._typeNullability(inType: typeali.fromType),
                                          inNonnull: typeali.inNonnullContext)
        let typeName = typeMapper.typeNameString(for: typeali.fromType, context: ctx)
        
        target.outputIdentation()
        target.outputInlineWithSpace("typealias", style: .keyword)
        target.outputInline(typeali.named, style: .keyword)
        target.outputInline(" = ")
        target.outputInline(typeName, style: .keyword)
    }
    
    private func outputVariableDeclaration(_ varDecl: GlobalVariableGenerationIntention, target: RewriterOutputTarget) {
        let name = varDecl.name
        let type = varDecl.type
        let initVal = varDecl.initialValueExpr
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: varDecl.accessLevel)
        let ownership = varDecl.ownership
        let varOrLet = varDecl.isConstant ? "let" : "var"
        let typeName = typeMapper.typeNameString(for: type)
        
        if !accessModifier.isEmpty {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        if ownership != .strong {
            // Check for non-pointers
            if let original = varDecl.variableSource?.type?.type, !original.isPointer {
                diagnostics.warning("""
                    Variable '\(name)' specified as '\(ownership.rawValue)' \
                    but original type '\(original)' is not a pointer type.
                    """, location: varDecl.variableSource?.location ?? .invalid)
            } else {
                target.outputInlineWithSpace(ownership.rawValue, style: .keyword)
            }
        }
        
        target.outputInlineWithSpace(varOrLet, style: .keyword)
        target.outputInline(name, style: .plain)
        target.outputInline(": ")
        target.outputInline(typeName, style: .typeName)
        
        if let expression = initVal?.expression {
            target.outputInline(" = ")
            
            let rewriter = SwiftStmtRewriter()
            rewriter.rewrite(expression: expression, into: target)
        }
        
        target.outputLineFeed()
    }
    
    private func outputClassExtension(_ cls: ClassExtensionGenerationIntention, target: RewriterOutputTarget) {
        if let categoryName = cls.categoryName, !categoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            target.output(line: "// MARK: - \(categoryName)", style: .comment)
        } else {
            target.output(line: "// MARK: -", style: .comment)
        }
        target.output(line: "@objc", style: .keyword)
        target.outputIdentation()
        target.outputInlineWithSpace("extension", style: .keyword)
        target.outputInline(cls.typeName, style: .typeName)
        
        outputClassBodyCommon(cls, target: target)
    }
    
    private func outputClass(_ cls: ClassGenerationIntention, target: RewriterOutputTarget) {
        target.output(line: "@objc", style: .keyword)
        target.outputIdentation()
        target.outputInlineWithSpace("class", style: .keyword)
        target.outputInline(cls.typeName, style: .typeName)
        
        outputClassBodyCommon(cls, target: target)
    }
    
    private func outputClassBodyCommon(_ cls: BaseClassIntention, target: RewriterOutputTarget) {
        // Figure out inheritance clauses
        var inheritances: [String] = []
        if let cls = cls as? ClassGenerationIntention {
            if let sup = cls.superclassName {
                inheritances.append(sup)
            } else {
                // Always inherit from NSObject, at least.
                inheritances.append("NSObject")
            }
        }
        inheritances.append(contentsOf: cls.protocols.map { p in p.protocolName })
        
        if inheritances.count > 0 {
            target.outputInline(": ")
            
            for (i, inheritance) in inheritances.enumerated() {
                if i > 0 {
                    target.outputInline(", ")
                }
                
                target.outputInline(inheritance, style: .typeName)
            }
        }
        
        // Start outputting class now
        target.outputInline(" ")
        target.outputInline("{")
        target.outputLineFeed()
        target.idented {
            for ivar in cls.instanceVariables {
                outputInstanceVar(ivar, target: target)
            }
            for prop in cls.properties {
                outputProperty(prop, target: target)
            }
            
            if (cls.instanceVariables.count > 0 || cls.properties.count > 0) && cls.methods.count > 0 {
                target.output(line: "")
            }
            
            for method in cls.methods {
                // Init and dealloc methods are treated differently
                // TODO: Create a separate GenerationIntention entirely for init
                // and dealloc methods and detect them during SwiftRewriter's
                // parsing with IntentionPass's instead of postponing to here.
                if method.signature.name == "init" {
                    outputInitMethod(method, target: target)
                } else if method.signature.name == "dealloc" && method.signature.parameters.count == 0 {
                    outputDeinit(method, target: target)
                } else {
                    outputMethod(method, target: target)
                }
            }
        }
        
        target.output(line: "}")
    }
    
    private func outputProtocol(_ prot: ProtocolGenerationIntention, target: RewriterOutputTarget) {
        target.output(line: "@objc", style: .keyword)
        target.outputIdentation()
        target.outputInlineWithSpace("protocol", style: .keyword)
        target.outputInlineWithSpace(prot.typeName, style: .typeName)
        target.outputInline("{")
        target.outputLineFeed()
        
        target.idented {
            for prop in prot.properties {
                outputProperty(prop, target: target)
            }
            
            if prot.properties.count > 0 && prot.methods.count > 0 {
                target.output(line: "")
            }
            
            for method in prot.methods {
                // Init methods are treated differently
                // TODO: Create a separate GenerationIntention entirely for init
                // methods and detect them during SwiftRewriter's parsing instead
                // of postponing to here.
                if method.signature.name == "init" {
                    outputInitMethod(method, target: target)
                } else if method.signature.name == "dealloc" && method.signature.parameters.count == 0 {
                    outputDeinit(method, target: target)
                } else {
                    outputMethod(method, target: target)
                }
            }
        }
        
        target.output(line: "}")
    }
    
    // TODO: See if we can reuse outputVariableDeclaration
    private func outputInstanceVar(_ ivar: InstanceVariableGenerationIntention, target: RewriterOutputTarget) {
        target.outputIdentation()
        
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: ivar.accessLevel)
        let varOrLet = ivar.isConstant ? "let" : "var"
        
        let typeName = typeMapper.typeNameString(for: ivar.type)
        
        if !accessModifier.isEmpty {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        if ivar.ownership != .strong {
            // Check for non-pointers
            if let original = ivar.typedSource?.type?.type, !original.isPointer {
                diagnostics.warning("""
                    Ivar '\(ivar.name)' specified as '\(ivar.ownership.rawValue)' \
                    but original type '\(original)' is not a pointer type.
                    """, location: ivar.typedSource?.location ?? .invalid)
            } else {
                target.outputInlineWithSpace(ivar.ownership.rawValue, style: .keyword)
            }
        }
        
        target.outputInlineWithSpace(varOrLet, style: .keyword)
        target.outputInline(ivar.name)
        target.outputInline(": ")
        target.outputInline(typeName, style: .typeName)
        target.outputLineFeed()
    }
    
    private func outputProperty(_ prop: PropertyGenerationIntention, target: RewriterOutputTarget) {
        target.outputIdentation()
        
        target.outputInlineWithSpace("@objc", style: .keyword)
        
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: prop.accessLevel)
        let typeName = typeMapper.typeNameString(for: prop.type)
        
        if !accessModifier.isEmpty {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        if prop.ownership != .strong {
            // Check for non-pointers
            if let original = prop.propertySource?.type?.type, !original.isPointer {
                diagnostics.warning("""
                    Property '\(prop.name)' specified as '\(prop.ownership.rawValue)' \
                    but original type '\(original)' is not a pointer type.
                    """, location: prop.propertySource?.location ?? .invalid)
            } else {
                target.outputInlineWithSpace(prop.ownership.rawValue, style: .keyword)
            }
        }
        
        target.outputInlineWithSpace("var", style: .keyword)
        target.outputInline(prop.name, style: .plain)
        target.outputInline(": ")
        
        target.outputInline(typeName, style: .typeName)
        
        switch prop.mode {
        case .asField:
            target.outputLineFeed()
            break
        case .computed(let body):
            outputMethodBody(body, target: target)
        case let .property(getter, setter):
            target.outputInline(" ")
            target.outputInline("{")
            target.outputLineFeed()
            
            target.idented {
                target.outputIdentation()
                target.outputInline("get", style: .keyword)
                outputMethodBody(getter, target: target)
                
                target.outputIdentation()
                target.outputInline("set", style: .keyword)
                
                // Avoid emitting setter's default new value identifier
                if setter.valueIdentifier != "newValue" {
                    target.outputInline("(\(setter.valueIdentifier))")
                }
                
                outputMethodBody(setter.body, target: target)
            }
            
            target.output(line: "}")
        }
    }
    
    private func outputInitMethod(_ initMethod: MethodGenerationIntention, target: RewriterOutputTarget) {
        target.output(line: "@objc", style: .keyword)
        target.outputIdentation()
        
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: initMethod.accessLevel)
        
        if !accessModifier.isEmpty && !(initMethod.parent is ProtocolGenerationIntention) {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        
        // Emit required "override" keyword
        if initMethod.parent is ClassGenerationIntention && initMethod.signature.parameters.count == 0 {
            target.outputInlineWithSpace("override", style: .keyword)
        }
        
        // Protocol 'optional' keyword
        if let protocolMethod = initMethod as? ProtocolMethodGenerationIntention, protocolMethod.isOptional {
            target.outputInlineWithSpace("optional", style: .keyword)
        }
        
        target.outputInline("init", style: .keyword)
        
        generateParameters(for: initMethod.signature,
                           into: target,
                           inNonnullContext: initMethod.inNonnullContext)
        
        if let body = initMethod.methodBody {
            outputMethodBody(body, target: target)
        } else if initMethod.parent is BaseClassIntention {
            // Class definitions _must_ have a method body, even if empty.
            target.outputInline(" {")
            target.outputLineFeed()
            target.output(line: "}")
        } else {
            target.outputLineFeed()
        }
    }
    
    private func outputDeinit(_ method: MethodGenerationIntention, target: RewriterOutputTarget) {
        target.output(line: "@objc", style: .keyword)
        target.outputIdentation()
        
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: method.accessLevel)
        
        if !accessModifier.isEmpty && !(method.parent is ProtocolGenerationIntention) {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        
        target.outputInline("deinit", style: .keyword)
        
        if let body = method.methodBody {
            outputMethodBody(body, target: target)
        } else if method.parent is BaseClassIntention {
            // Class definitions _must_ have a method body, even if empty.
            target.outputInline(" {")
            target.outputLineFeed()
            target.output(line: "}")
        } else {
            target.outputLineFeed()
        }
    }
    
    private func outputMethod(_ method: MethodGenerationIntention, target: RewriterOutputTarget) {
        target.output(line: "@objc", style: .keyword)
        
        target.outputIdentation()
        
        let accessModifier = SwiftWriter._accessModifierFor(accessLevel: method.accessLevel)
        
        if !accessModifier.isEmpty && !(method.parent is ProtocolGenerationIntention) {
            target.outputInlineWithSpace(accessModifier, style: .keyword)
        }
        if method.isStatic {
            target.outputInlineWithSpace("static", style: .keyword)
        }
        
        // Protocol 'optional' keyword
        if let protocolMethod = method as? ProtocolMethodGenerationIntention, protocolMethod.isOptional {
            target.outputInlineWithSpace("optional", style: .keyword)
        }
        
        target.outputInlineWithSpace("func", style: .keyword)
        
        let sign = method.signature
        
        target.outputInline(sign.name)
        
        generateParameters(for: method.signature,
                           into: target,
                           inNonnullContext: method.inNonnullContext)
        
        switch sign.returnType {
        case .void: // `-> Void` can be omitted for void functions.
            break
        default:
            target.outputInline(" -> ")
            let typeName = typeMapper.typeNameString(for: sign.returnType)
            
            target.outputInline(typeName, style: .typeName)
        }
        
        if let body = method.methodBody {
            outputMethodBody(body, target: target)
        } else if method.parent is BaseClassIntention {
            // Class definitions _must_ have a method body, even if empty.
            target.outputInline(" {")
            target.outputLineFeed()
            target.output(line: "}")
        } else {
            target.outputLineFeed()
        }
    }
    
    private func outputMethodBody(_ body: MethodBodyIntention, target: RewriterOutputTarget) {
        let rewriter = SwiftStmtRewriter()
        rewriter.rewrite(compoundStatement: body.body, into: target)
    }
    
    private func generateParameters(for signature: FunctionSignature,
                                    into target: RewriterOutputTarget,
                                    inNonnullContext: Bool = false) {
        
        target.outputInline("(")
        
        for (i, param) in signature.parameters.enumerated() {
            if i > 0 {
                target.outputInline(", ")
            }
            
            let typeName = typeMapper.typeNameString(for: param.type)
            
            if param.label != param.name {
                target.outputInlineWithSpace(param.label, style: .plain)
            }
            
            target.outputInline(param.name)
            target.outputInline(": ")
            target.outputInline(typeName, style: .typeName)
        }
        
        target.outputInline(")")
    }
    
    internal static func _isConstant(fromType type: ObjcType) -> Bool {
        switch type {
        case .qualified(_, let qualifiers),
             .specified(_, .qualified(_, let qualifiers)):
            if qualifiers.contains("const") {
                return true
            }
        case .specified(let specifiers, _):
            if specifiers.contains("const") {
                return true
            }
        default:
            break
        }
        
        return false
    }
    
    internal static func _typeNullability(inType type: ObjcType) -> TypeNullability? {
        switch type {
        case .specified(let specifiers, let type):
            // Struct types are never null.
            if case .struct = type {
                return .nonnull
            }
            
            if specifiers.last == "__weak" {
                return .nullable
            } else if specifiers.last == "__unsafe_unretained" {
                return .nonnull
            }
            
            return nil
        default:
            return nil
        }
    }
    
    internal static func _accessModifierFor(accessLevel: AccessLevel, omitInternal: Bool = true) -> String {
        // In Swift, omitting the access level specifier infers 'internal', so we
        // allow the user to decide whether to omit the keyword here
        if omitInternal && accessLevel == .internal {
            return ""
        }
        
        return accessLevel.rawValue
    }
}

internal func evaluateOwnershipPrefix(inType type: ObjcType,
                                      property: PropertyDefinition? = nil) -> Ownership {
    var ownership: Ownership = .strong
    if !type.isPointer {
        return .strong
    }
    
    switch type {
    case .specified(let specifiers, _):
        if specifiers.last == "__weak" {
            ownership = .weak
        } else if specifiers.last == "__unsafe_unretained" {
            ownership = .unownedUnsafe
        }
    default:
        break
    }
    
    // Search in property
    if let property = property {
        if let modifiers = property.attributesList?.keywordAttributes {
            if modifiers.contains("weak") {
                ownership = .weak
            } else if modifiers.contains("unsafe_unretained") {
                ownership = .unownedUnsafe
            } else if modifiers.contains("assign") {
                ownership = .unownedUnsafe
            }
        }
    }
    
    return ownership
}

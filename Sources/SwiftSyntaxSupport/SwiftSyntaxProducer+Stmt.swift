import SwiftSyntax
import Intentions
import SwiftAST

extension SwiftSyntaxProducer {
    /// Generates a code block for the given statement.
    /// This code block might have zero, one or more sub-statements, depending on
    /// the properties of the given statement, e.g. expression statements which
    /// feature zero elements in the expressions array result in an empty code block.
    ///
    /// This method is provided more as an inspection of generation of syntax
    /// elements for particular statements, and is not used internally by the
    /// syntax producer while generating whole files.
    ///
    /// - Returns: A code block containing the statements generated by the statement
    /// provided.
    public func generateStatement(_ statement: Statement) -> CodeBlockSyntax {
        if let statement = statement as? CompoundStatement {
            return generateCompound(statement)
        }
        
        return CodeBlockSyntax { builder in
            indent()
            defer {
                deindent()
            }
            
            let stmts = generateStatementBlockItems(statement)
            
            for (i, stmt) in stmts.enumerated() {
                if i > 0 {
                    addExtraLeading(.newlines(1))
                }
                
                builder.addStatement(stmt())
            }
        }
    }
    
    func generateCompound(_ compoundStmt: CompoundStatement) -> CodeBlockSyntax {
        CodeBlockSyntax { builder in
            builder.useLeftBrace(SyntaxFactory.makeLeftBraceToken().withLeadingSpace())
            
            indent()
            defer {
                deindent()
                builder.useRightBrace(SyntaxFactory.makeRightBraceToken().onNewline().addingLeadingTrivia(indentation()))
                extraLeading = nil
            }
            
            let stmts = _generateStatements(compoundStmt.statements)
            
            for stmt in stmts {
                builder.addStatement(stmt)
            }
        }
    }
    
    func _generateStatements(_ stmtList: [Statement]) -> [CodeBlockItemSyntax] {
        var items: [CodeBlockItemSyntax] = []
        
        for (i, stmt) in stmtList.enumerated() {
            let stmtSyntax = generateStatementBlockItems(stmt)
            
            for item in stmtSyntax {
                addExtraLeading(.newlines(1) + indentation())
                items.append(item())
            }
            
            if i < stmtList.count - 1 && _shouldEmitNewlineSpacing(between: stmt, stmt2: stmtList[i + 1]) {
                addExtraLeading(.newlines(1))
            }
        }
        
        return items
    }
    
    private func _shouldEmitNewlineSpacing(between stmt1: Statement, stmt2: Statement) -> Bool {
        switch (stmt1, stmt2) {
        case (is ExpressionsStatement, is ExpressionsStatement):
            return false
        case (is VariableDeclarationsStatement, is ExpressionsStatement),
             (is VariableDeclarationsStatement, is VariableDeclarationsStatement):
            return false
            
        default:
            return true
        }
    }
    
    func generateStatementBlockItems(_ stmt: Statement) -> [() -> CodeBlockItemSyntax] {
        if let label = stmt.label {
            addExtraLeading(.newlines(1) + indentation())
            addExtraLeading(.lineComment("// \(label):"))
        }
        
        switch stmt {
        case let stmt as ReturnStatement:
            return [{ self.generateReturn(stmt).inCodeBlock() }]
            
        case let stmt as ContinueStatement:
            return [{ self.generateContinue(stmt).inCodeBlock() }]
            
        case let stmt as BreakStatement:
            return [{ self.generateBreak(stmt).inCodeBlock() }]
            
        case let stmt as FallthroughStatement:
            return [{ self.generateFallthrough(stmt).inCodeBlock() }]
            
        case let stmt as ExpressionsStatement:
            return generateExpressions(stmt)
            
        case let stmt as VariableDeclarationsStatement:
            return generateVariableDeclarations(stmt)
            
        case let stmt as IfStatement:
            return [{ self.generateIfStmt(stmt).inCodeBlock() }]
            
        case let stmt as SwitchStatement:
            return [{ self.generateSwitchStmt(stmt).inCodeBlock() }]
            
        case let stmt as WhileStatement:
            return [{ self.generateWhileStmt(stmt).inCodeBlock() }]
            
        case let stmt as DoStatement:
            return [{ self.generateDo(stmt).inCodeBlock() }]
            
        case let stmt as DoWhileStatement:
            return [{ self.generateDoWhileStmt(stmt).inCodeBlock() }]
            
        case let stmt as ForStatement:
            return [{ self.generateForIn(stmt).inCodeBlock() }]
            
        case let stmt as DeferStatement:
            return [{ self.generateDefer(stmt).inCodeBlock() }]
            
        case let stmt as CompoundStatement:
            return stmt.statements.flatMap(generateStatementBlockItems)
            
        case let stmt as UnknownStatement:
            return [{ self.generateUnknown(stmt).inCodeBlock() }]
            
        default:
            return [{ SyntaxFactory.makeBlankExpressionStmt().inCodeBlock() }]
        }
    }
    
    func generateExpressions(_ stmt: ExpressionsStatement) -> [() -> CodeBlockItemSyntax] {
        stmt.expressions
            .map { exp -> () -> CodeBlockItemSyntax in
                return {
                    if self.settings.outputExpressionTypes {
                        self.addExtraLeading(Trivia.lineComment("// type: \(exp.resolvedType ?? "<nil>")"))
                        self.addExtraLeading(.newlines(1))
                        self.addExtraLeading(self.indentation())
                    }
                    
                    return SyntaxFactory.makeCodeBlockItem(item: self.generateExpression(exp), semicolon: nil, errorTokens: nil)
                }
            }
    }
    
    func generateVariableDeclarations(_ stmt: VariableDeclarationsStatement) -> [() -> CodeBlockItemSyntax] {
        if stmt.decl.isEmpty {
            return []
        }
        
        return varDeclGenerator
            .generateVariableDeclarations(stmt)
            .map { decl in
                return {
                    SyntaxFactory.makeCodeBlockItem(item: decl(), semicolon: nil, errorTokens: nil)
                }
            }
    }
    
    func generateReturn(_ stmt: ReturnStatement) -> ReturnStmtSyntax {
        ReturnStmtSyntax { builder in
            var returnToken = makeStartToken(SyntaxFactory.makeReturnKeyword)
            
            if let exp = stmt.exp {
                returnToken = returnToken.addingTrailingSpace()
                builder.useExpression(generateExpression(exp))
            }
            
            builder.useReturnKeyword(returnToken)
        }
    }
    
    func generateContinue(_ stmt: ContinueStatement) -> ContinueStmtSyntax {
        ContinueStmtSyntax { builder in
            builder.useContinueKeyword(makeStartToken(SyntaxFactory.makeContinueKeyword))
            
            if let label = stmt.targetLabel {
                builder.useLabel(makeIdentifier(label).withLeadingSpace())
            }
        }
    }
    
    func generateBreak(_ stmt: BreakStatement) -> BreakStmtSyntax {
        BreakStmtSyntax { builder in
            builder.useBreakKeyword(makeStartToken(SyntaxFactory.makeBreakKeyword))
            
            if let label = stmt.targetLabel {
                builder.useLabel(makeIdentifier(label).withLeadingSpace())
            }
        }
    }
    
    func generateFallthrough(_ stmt: FallthroughStatement) -> FallthroughStmtSyntax {
        FallthroughStmtSyntax { builder in
            builder.useFallthroughKeyword(makeStartToken(SyntaxFactory.makeFallthroughKeyword))
        }
    }
    
    func generateIfStmt(_ stmt: IfStatement) -> IfStmtSyntax {
        IfStmtSyntax { builder in
            builder.useIfKeyword(makeStartToken(SyntaxFactory.makeIfKeyword).withTrailingSpace())
            
            if let pattern = stmt.pattern {
                builder.addCondition(ConditionElementSyntax { builder in
                    builder.useCondition(OptionalBindingConditionSyntax { builder in
                        builder.useLetOrVarKeyword(SyntaxFactory.makeLetKeyword().withTrailingSpace())
                        
                        builder.usePattern(generatePattern(pattern))
                        
                        builder.useInitializer(InitializerClauseSyntax { builder in
                            builder.useEqual(SyntaxFactory.makeEqualToken().withTrailingSpace().withLeadingSpace())
                            builder.useValue(generateExpression(stmt.exp))
                        })
                    })
                })
            } else {
                builder.addCondition(ConditionElementSyntax { builder in
                    builder.useCondition(generateExpression(stmt.exp))
                })
            }
            
            builder.useBody(generateCompound(stmt.body))
            
            if let _else = stmt.elseBody {
                builder.useElseKeyword(makeStartToken(SyntaxFactory.makeElseKeyword).addingLeadingSpace())
                if _else.statements.count == 1, let elseIfStmt = _else.statements[0] as? IfStatement {
                    addExtraLeading(.spaces(1))
                    builder.useElseBody(generateIfStmt(elseIfStmt))
                } else {
                    builder.useElseBody(generateCompound(_else))
                }
            }
        }
    }
    
    func generateSwitchStmt(_ stmt: SwitchStatement) -> SwitchStmtSyntax {
        SwitchStmtSyntax { builder in
            builder.useSwitchKeyword(makeStartToken(SyntaxFactory.makeSwitchKeyword).withTrailingSpace())
            builder.useLeftBrace(SyntaxFactory.makeLeftBraceToken().withLeadingSpace())
            builder.useRightBrace(SyntaxFactory.makeRightBraceToken().withLeadingTrivia(.newlines(1) + indentation()))
            builder.useExpression(generateExpression(stmt.exp))
            
            var syntaxes: [Syntax] = []
            
            for _case in stmt.cases {
                addExtraLeading(.newlines(1) + indentation())
                
                let label = generateSwitchCaseLabel(_case)
                syntaxes.append(generateSwitchCase(label, statements: _case.statements))
            }
            
            if let _default = stmt.defaultCase {
                addExtraLeading(.newlines(1) + indentation())
                
                let label = SwitchDefaultLabelSyntax { builder in
                    builder.useDefaultKeyword(makeStartToken(SyntaxFactory.makeDefaultKeyword))
                    builder.useColon(SyntaxFactory.makeColonToken())
                }
                syntaxes.append(generateSwitchCase(label, statements: _default))
            }
            
            builder.addCase(SyntaxFactory.makeSwitchCaseList(syntaxes))
        }
    }
    
    func generateSwitchCase(_ caseLabel: Syntax, statements: [Statement]) -> SwitchCaseSyntax {
        SwitchCaseSyntax { builder in
            builder.useLabel(caseLabel)
            
            indent()
            defer {
                deindent()
            }
            
            let stmts = _generateStatements(statements)
            
            for stmt in stmts {
                builder.addStatement(stmt)
            }
        }
    }
    
    func generateSwitchCaseLabel(_ _case: SwitchCase) -> SwitchCaseLabelSyntax {
        SwitchCaseLabelSyntax { builder in
            builder.useCaseKeyword(makeStartToken(SyntaxFactory.makeCaseKeyword).withTrailingSpace())
            builder.useColon(SyntaxFactory.makeColonToken())
            
            iterateWithComma(_case.patterns) { (item, hasComma) in
                builder.addCaseItem(CaseItemSyntax { builder in
                    builder.usePattern(generatePattern(item))
                    
                    if hasComma {
                        builder.useTrailingComma(SyntaxFactory.makeCommaToken().withTrailingSpace())
                    }
                })
            }
        }
    }
    
    func generateWhileStmt(_ stmt: WhileStatement) -> WhileStmtSyntax {
        WhileStmtSyntax { builder in
            builder.useWhileKeyword(makeStartToken(SyntaxFactory.makeWhileKeyword).withTrailingSpace())
            
            builder.addCondition(ConditionElementSyntax { builder in
                builder.useCondition(generateExpression(stmt.exp))
            })
            
            builder.useBody(generateCompound(stmt.body))
        }
    }
    
    func generateDoWhileStmt(_ stmt: DoWhileStatement) -> RepeatWhileStmtSyntax {
        RepeatWhileStmtSyntax { builder in
            builder.useRepeatKeyword(makeStartToken(SyntaxFactory.makeRepeatKeyword))
            builder.useWhileKeyword(SyntaxFactory.makeWhileKeyword().addingSurroundingSpaces())
            
            builder.useBody(generateCompound(stmt.body))
            builder.useCondition(generateExpression(stmt.exp))
        }
    }
    
    func generateForIn(_ stmt: ForStatement) -> ForInStmtSyntax {
        ForInStmtSyntax { builder in
            builder.useForKeyword(makeStartToken(SyntaxFactory.makeForKeyword).withTrailingSpace())
            builder.useInKeyword(SyntaxFactory.makeInKeyword().addingSurroundingSpaces())
            builder.useBody(generateCompound(stmt.body))
            builder.usePattern(generatePattern(stmt.pattern))
            builder.useSequenceExpr(generateExpression(stmt.exp))
        }
    }
    
    func generateDo(_ stmt: DoStatement) -> DoStmtSyntax {
        DoStmtSyntax { builder in
            builder.useDoKeyword(makeStartToken(SyntaxFactory.makeDoKeyword))
            builder.useBody(generateCompound(stmt.body))
        }
    }
    
    func generateDefer(_ stmt: DeferStatement) -> DeferStmtSyntax {
        DeferStmtSyntax { builder in
            builder.useDeferKeyword(makeStartToken(SyntaxFactory.makeDeferKeyword))
            builder.useBody(generateCompound(stmt.body))
        }
    }
    
    func generateUnknown(_ unknown: UnknownStatement) -> ExprSyntax {
        var trivia = extraLeading ?? []
        let indent = indentationString()
        
        trivia = trivia + Trivia.blockComment("""
            /*
            \(indent)\(unknown.context.description)
            \(indent)*/
            """)
        
        return SyntaxFactory
            .makeBlankIdentifierExpr()
            .withIdentifier(makeIdentifier("").withLeadingTrivia(trivia))
    }
    
    func generatePattern(_ pattern: Pattern) -> PatternSyntax {
        switch pattern {
        case .identifier(let ident):
            return IdentifierPatternSyntax { $0.useIdentifier(makeIdentifier(ident)) }
            
        case .expression(let exp):
            return ExpressionPatternSyntax { $0.useExpression(generateExpression(exp)) }
            
        case .tuple(let items):
            return TuplePatternSyntax { builder in
                builder.useLeftParen(SyntaxFactory.makeLeftParenToken())
                builder.useRightParen(SyntaxFactory.makeRightParenToken())
                
                iterateWithComma(items) { (item, hasComma) in
                    builder.addElement(
                        TuplePatternElementSyntax { builder in
                            builder.usePattern(generatePattern(item))
                            
                            if hasComma {
                                builder.useTrailingComma(SyntaxFactory
                                    .makeCommaToken()
                                    .withTrailingSpace())
                            }
                        }
                    )
                }
            }
        }
    }
}

private extension ExprSyntax {
    func inCodeBlock() -> CodeBlockItemSyntax {
        CodeBlockItemSyntax { $0.useItem(self) }
    }
}

private extension StmtSyntax {
    func inCodeBlock() -> CodeBlockItemSyntax {
        CodeBlockItemSyntax { $0.useItem(self) }
    }
}

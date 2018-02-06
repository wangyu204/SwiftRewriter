import Antlr4
import ObjcParserAntlr

/// Main frontend class for performing Swift-conversion of Objective-C statements.
class SwiftStmtRewriter {
    public func rewrite(_ compound: ObjectiveCParser.CompoundStatementContext, into target: RewriterOutputTarget) {
        let listener = StmtRewriterListener(target: target)
        let walker = ParseTreeWalker()
        try? walker.walk(listener, compound)
    }
}

fileprivate class BaseRewriter<T> where T: ParserRuleContext {
    var target: RewriterOutputTarget
    
    init(target: RewriterOutputTarget) {
        self.target = target
    }
    
    func rewrite(_ node: T) {
        
    }
}

fileprivate class StmtRewriterListener: ObjectiveCParserBaseListener {
    var target: RewriterOutputTarget
    var onFirstStatement = true
    
    init(target: RewriterOutputTarget) {
        self.target = target
    }
    
    override func enterStatement(_ ctx: ObjectiveCParser.StatementContext) {
        if !onFirstStatement {
            target.outputLineFeed()
        }
        target.outputIdentation()
        
        onFirstStatement = true
    }
    
    override func exitStatement(_ ctx: ObjectiveCParser.StatementContext) {
        target.outputLineFeed()
    }
    
    override func exitReceiver(_ ctx: ObjectiveCParser.ReceiverContext) {
        // Period for method call
        target.outputInline(".")
    }
    
    override func enterKeywordArgument(_ ctx: ObjectiveCParser.KeywordArgumentContext) {
        guard let messageSelector = ctx.parent as? ObjectiveCParser.MessageSelectorContext else {
            return
        }
        
        // Second argument on, print comma before printing argument
        if ctx.indexOnParent() > 0 {
            target.outputInline(", ")
        }
    }
    
    override func exitSelector(_ ctx: ObjectiveCParser.SelectorContext) {
        if ctx.parent is ObjectiveCParser.MessageSelectorContext {
            target.outputInline("(")
        }
        if let messageSelector = ctx.parent?.parent as? ObjectiveCParser.MessageSelectorContext {
            if messageSelector.index(of: ctx.parent!) == 0 {
                target.outputInline("(")
            } else {
                target.outputInline(": ")
            }
        }
    }
    
    override func exitMessageExpression(_ ctx: ObjectiveCParser.MessageExpressionContext) {
        target.outputInline(")")
    }
    
    // MARK: Primitives
    override func enterIdentifier(_ ctx: ObjectiveCParser.IdentifierContext) {
        target.outputInline(ctx.getText())
    }
    
    override func enterConstant(_ ctx: ObjectiveCParser.ConstantContext) {
        target.outputInline(ctx.getText())
    }
}

private extension Tree {
    func indexOnParent() -> Int {
        return getParent()?.index(of: self) ?? -1
    }
    
    func index(of child: Tree) -> Int? {
        for i in 0..<getChildCount() {
            if getChild(i) === child {
                return i
            }
        }
        
        return nil
    }
}
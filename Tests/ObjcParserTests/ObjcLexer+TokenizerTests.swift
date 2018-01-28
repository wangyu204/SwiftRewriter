//
//  ObjcLexer+TokenizerTests.swift
//  ObjcParserTests
//
//  Created by Luiz Silva on 22/01/2018.
//

import XCTest
import GrammarModels
@testable import ObjcParser

class ObjcLexer_TokenizerTests: XCTestCase {
    var autoSkipComments = true
    
    override func setUp() {
        super.setUp()
        
        autoSkipComments = true
    }
    
    func testTokenizeLiterals() {
        expect("123", toTokenizeAs: .decimalLiteral)
        expect("123.4", toTokenizeAs: .floatLiteral)
        expect("123.4e+10", toTokenizeAs: .floatLiteral)
        expect("123.4e+10f", toTokenizeAs: .floatLiteral)
        expect("123E10f", toTokenizeAs: .floatLiteral)
        expect("123E-5F", toTokenizeAs: .floatLiteral)
        expect("0123", toTokenizeAs: .octalLiteral)
        expect("\"abc\"", toTokenizeAs: .stringLiteral)
        expect("@\"abc\"", toTokenizeAs: .stringLiteral)
        expect("L\"abc\"", toTokenizeAs: .stringLiteral)
    }
    
    func testTokenizeIdentifiers() {
        expect("AnIdentifier", toTokenizeAs: .identifier)
        expect("_AnIdentifier_", toTokenizeAs: .identifier)
    }
    
    func testTokenizeId() {
        expect("id", toTokenizeAs: .id)
    }
    
    func testTokenizeTypeQualifier() {
        expect("static", toTokenizeAs: .typeQualifier)
        expect("const", toTokenizeAs: .typeQualifier)
        expect("volatile", toTokenizeAs: .typeQualifier)
        expect("_Nonnull", toTokenizeAs: .typeQualifier)
        expect("_Nullable", toTokenizeAs: .typeQualifier)
        expect("__weak", toTokenizeAs: .typeQualifier)
        expect("__strong", toTokenizeAs: .typeQualifier)
        expect("__kindof", toTokenizeAs: .typeQualifier)
    }
    
    func testTokenizeKeywords() {
        expect("@interface", toTokenizeAs: .keyword(.atInterface))
        expect("@implementation", toTokenizeAs: .keyword(.atImplementation))
        expect("@protocol", toTokenizeAs: .keyword(.atProtocol))
        expect("@end", toTokenizeAs: .keyword(.atEnd))
        expect("@public", toTokenizeAs: .keyword(.atPublic))
        expect("@protected", toTokenizeAs: .keyword(.atProtected))
        expect("@private", toTokenizeAs: .keyword(.atPrivate))
        expect("@package", toTokenizeAs: .keyword(.atPackage))
        expect("@optional", toTokenizeAs: .keyword(.atOptional))
        expect("@required", toTokenizeAs: .keyword(.atRequired))
        expect("if", toTokenizeAs: .keyword(.if))
        expect("else", toTokenizeAs: .keyword(.else))
        expect("while", toTokenizeAs: .keyword(.while))
        expect("switch", toTokenizeAs: .keyword(.switch))
        expect("continue", toTokenizeAs: .keyword(.continue))
        expect("break", toTokenizeAs: .keyword(.break))
        expect("return", toTokenizeAs: .keyword(.return))
        expect("typedef", toTokenizeAs: .keyword(.typedef))
        expect("struct", toTokenizeAs: .keyword(.struct))
    }
    
    func testTokenizeSpecialChars() {
        expect("@", toTokenizeAs: .at)
        expect(":", toTokenizeAs: .colon)
        expect(";", toTokenizeAs: .semicolon)
        expect(",", toTokenizeAs: .comma)
        expect("(", toTokenizeAs: .openParens)
        expect(")", toTokenizeAs: .closeParens)
        expect("[", toTokenizeAs: .openSquareBracket)
        expect("]", toTokenizeAs: .closeSquareBracket)
        expect("{", toTokenizeAs: .openBrace)
        expect("}", toTokenizeAs: .closeBrace)
    }
    
    func testTokenizeOperators() {
        expect("+", toTokenizeAs: .operator(.add))
        expect("-", toTokenizeAs: .operator(.subtract))
        expect("*", toTokenizeAs: .operator(.multiply))
        expect("/", toTokenizeAs: .operator(.divide))
        
        expect("+=", toTokenizeAs: .operator(.addAssign))
        expect("-=", toTokenizeAs: .operator(.subtractAssign))
        expect("*=", toTokenizeAs: .operator(.multiplyAssign))
        expect("/=", toTokenizeAs: .operator(.divideAssign))
        
        expect("!", toTokenizeAs: .operator(.negate))
        expect("&&", toTokenizeAs: .operator(.and))
        expect("||", toTokenizeAs: .operator(.or))
        
        expect("&", toTokenizeAs: .operator(.bitwiseAnd))
        expect("|", toTokenizeAs: .operator(.bitwiseOr))
        expect("^", toTokenizeAs: .operator(.bitwiseXor))
        expect("~", toTokenizeAs: .operator(.bitwiseNot))
        expect("<<", toTokenizeAs: .operator(.bitwiseShiftLeft))
        expect(">>", toTokenizeAs: .operator(.bitwiseShiftRight))
        
        expect("&=", toTokenizeAs: .operator(.bitwiseAndAssign))
        expect("|=", toTokenizeAs: .operator(.bitwiseOrAssign))
        expect("^=", toTokenizeAs: .operator(.bitwiseXorAssign))
        expect("~=", toTokenizeAs: .operator(.bitwiseNotAssign))
        expect("<<=", toTokenizeAs: .operator(.bitwiseShiftLeftAssign))
        expect(">>=", toTokenizeAs: .operator(.bitwiseShiftRightAssign))
        
        expect("<", toTokenizeAs: .operator(.lessThan))
        expect("<=", toTokenizeAs: .operator(.lessThanOrEqual))
        expect(">", toTokenizeAs: .operator(.greaterThan))
        expect(">=", toTokenizeAs: .operator(.greaterThanOrEqual))
        
        expect("=", toTokenizeAs: .operator(.assign))
        expect("==", toTokenizeAs: .operator(.equals))
        expect("!=", toTokenizeAs: .operator(.unequals))
    }
    
    func testTokenizePreprocessorDirective() {
        expect("#include \"MyFile.h\"", toTokenizeAs: .preprocessorDirective)
        expect("#pragma my pragma", toTokenizeAs: .preprocessorDirective)
        expect("#import <MyFile.h>", toTokenizeAs: .preprocessorDirective)
        expect("#error an error pragma", toTokenizeAs: .preprocessorDirective)
        expect("#warning a warning pragma", toTokenizeAs: .preprocessorDirective)
    }
    
    func testSkipComments() {
        expect(sequence: "abc // test\n123", toTokenizeAs: [.identifier, .decimalLiteral])
        expect(sequence: """
            123
            /* test
             comment */
            abc
            """, toTokenizeAs: [.decimalLiteral, .identifier])
    }
    
    func testConsumeComments() {
        autoSkipComments = false
        
        expect(sequence: "abc // test\n123", toTokenizeAs: [.identifier, .singleLineComment, .decimalLiteral])
        expect(sequence: """
            123
            /* test
             comment */
            abc
            """, toTokenizeAs: [.decimalLiteral, .multiLineComment, .identifier])
    }
    
    func testTokenizeSequence() {
        let source = """
            >> << @@ >= <= identifier @interface @notkeyword 1234 0x0f1Ab,1,2.3F
            // A comment
            //
            
            #preprocessor line same preproc
            adef
            """
        
        expect(sequence: source, toTokenizeAs: [
            .operator(.bitwiseShiftRight), .operator(.bitwiseShiftLeft),
            .operator(.greaterThanOrEqual), .operator(.lessThanOrEqual),
            .at, .at, .identifier, .keyword(.atInterface), .at, .identifier,
            .decimalLiteral, .hexLiteral, .comma, .decimalLiteral, .comma,
            .floatLiteral, .preprocessorDirective, .identifier
            ])
    }
    
    private func expect(sequence string: String, toTokenizeAs expectedTypes: [TokenType], file: String = #file, line: Int = #line) {
        let lexer = makeLexer(string)
        
        for pair in zip(lexer.allTokens(), expectedTypes) {
            
            let actual = pair.0
            let expected = pair.1
            
            if actual.type != expected {
                recordFailure(withDescription: "Expected token type: \(expected) received token type: \(actual.type) at loc. \(actual.location)",
                    inFile: file, atLine: line, expected: false)
            }
        }
    }
    
    private func expect(_ string: String, toTokenizeAs expectedType: TokenType, _ expectedString: String? = nil, file: String = #file, line: Int = #line) {
        let expString = expectedString ?? string
        
        let token =
            Token(type: expectedType, string: expString,
                  location: fullRange(expString))
        
        tokenizeTest(string, token, file: file, line: line)
    }
    
    private func tokenizeTest(_ string: String, _ expected: Token, file: String = #file, line: Int = #line) {
        let lexer = makeLexer(string)
        
        if lexer.token() != expected {
            recordFailure(withDescription: "Expected token: \(expected) received token: \(lexer.token())",
                          inFile: file, atLine: line, expected: false)
        }
    }
    
    private func makeLexer(_ string: String) -> ObjcLexer {
        let lexer = ObjcLexer(source: StringCodeSource(source: string))
        lexer.autoSkipComments = autoSkipComments
        
        return lexer
    }
    
    private func fullRange(_ str: String) -> SourceLocation {
        let range: SourceRange = .range(str.startIndex..<str.endIndex)
        
        return SourceLocation(source: StringCodeSource(source: str), range: range)
    }
}
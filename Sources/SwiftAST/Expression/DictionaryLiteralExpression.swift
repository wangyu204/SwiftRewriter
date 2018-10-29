public class DictionaryLiteralExpression: Expression {
    private var _subExpressions: [Expression] = []
    
    public var pairs: [ExpressionDictionaryPair] {
        didSet {
            oldValue.forEach { $0.key.parent = nil; $0.value.parent = nil }
            pairs.forEach { $0.key.parent = self; $0.value.parent = self }
            
            _subExpressions = pairs.flatMap { [$0.key, $0.value] }
        }
    }
    
    public override var subExpressions: [Expression] {
        return _subExpressions
    }
    
    public override var description: String {
        if pairs.isEmpty {
            return "[:]"
        }
        
        return "[" + pairs.map { $0.description }.joined(separator: ", ") + "]"
    }
    
    public init(pairs: [ExpressionDictionaryPair]) {
        self.pairs = pairs
        
        super.init()
        
        pairs.forEach { $0.key.parent = self; $0.value.parent = self }
        _subExpressions = pairs.flatMap { [$0.key, $0.value] }
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        pairs = try container.decode([ExpressionDictionaryPair].self, forKey: .pairs)
        
        try super.init(from: container.superDecoder())
        
        pairs.forEach { $0.key.parent = self; $0.value.parent = self }
        _subExpressions = pairs.flatMap { [$0.key, $0.value] }
    }
    
    public override func copy() -> DictionaryLiteralExpression {
        return DictionaryLiteralExpression(pairs: pairs.map { $0.copy() }).copyTypeAndMetadata(from: self)
    }
    
    public override func accept<V: ExpressionVisitor>(_ visitor: V) -> V.ExprResult {
        return visitor.visitDictionary(self)
    }
    
    public override func isEqual(to other: Expression) -> Bool {
        switch other {
        case let rhs as DictionaryLiteralExpression:
            return self == rhs
        default:
            return false
        }
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(pairs, forKey: .pairs)
        
        try super.encode(to: container.superEncoder())
    }
    
    public static func == (lhs: DictionaryLiteralExpression, rhs: DictionaryLiteralExpression) -> Bool {
        return lhs.pairs == rhs.pairs
    }
    
    private enum CodingKeys: String, CodingKey {
        case pairs
    }
}
public extension Expression {
    public var asDictionary: DictionaryLiteralExpression? {
        return cast()
    }
}

public struct ExpressionDictionaryPair: Codable, Equatable {
    public var key: Expression
    public var value: Expression
    
    public init(key: Expression, value: Expression) {
        self.key = key
        self.value = value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.key = try container.decodeExpression(forKey: .key)
        self.value = try container.decodeExpression(forKey: .value)
    }
    
    public func copy() -> ExpressionDictionaryPair {
        return ExpressionDictionaryPair(key: key.copy(), value: value.copy())
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeExpression(key, forKey: .key)
        try container.encodeExpression(value, forKey: .value)
    }
    
    private enum CodingKeys: String, CodingKey {
        case key
        case value
    }
}

extension ExpressionDictionaryPair: CustomStringConvertible {
    public var description: String {
        return key.description + ": " + value.description
    }
}
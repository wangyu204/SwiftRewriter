import XCTest
import SwiftAST
import SwiftRewriterLib

class DefaultTypeSystemTests: XCTestCase {
    var sut: DefaultTypeSystem!
    
    override func setUp() {
        sut = DefaultTypeSystem()
    }
    
    func testIsTypeSubtypeOf() {
        let typeA = KnownTypeBuilder(typeName: "A").build()
        let typeB = KnownTypeBuilder(typeName: "B", supertype: typeA).build()
        let typeC = KnownTypeBuilder(typeName: "C", supertype: typeB).build()
        
        sut.addType(typeA)
        sut.addType(typeB)
        sut.addType(typeC)
        
        XCTAssertTrue(sut.isType("A", subtypeOf: "A"))
        XCTAssertTrue(sut.isType("B", subtypeOf: "A"))
        XCTAssertTrue(sut.isType("C", subtypeOf: "A"))
        XCTAssertFalse(sut.isType("A", subtypeOf: "B"))
        XCTAssertFalse(sut.isType("A", subtypeOf: "C"))
    }
    
    func testNSObjectDefinition() {
        guard let type = sut.knownTypeWithName("NSObject") else {
            XCTFail("Expected NSObject to be present")
            return
        }
        
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type),
                        "Missing NSObject's default parameterless constructor")
    }
    
    func testNSArrayDefinition() {
        guard let type = sut.knownTypeWithName("NSArray") else {
            XCTFail("Expected NSArray to be present")
            return
        }
        
        XCTAssertEqual(type.supertype?.asKnownType?.typeName, "NSObject")
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type),
                        "Missing NSArray's default parameterless constructor")
    }
    
    func testNSMutableArrayDefinition() {
        guard let type = sut.knownTypeWithName("NSMutableArray") else {
            XCTFail("Expected NSMutableArray to be present")
            return
        }
        
        XCTAssertEqual(type.supertype?.asKnownType?.typeName, "NSArray")
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type),
                        "Missing NSMutableArray's default parameterless constructor")
    }
    
    func testNSDictionaryDefinition() {
        guard let type = sut.knownTypeWithName("NSDictionary") else {
            XCTFail("Expected NSDictionary to be present")
            return
        }
        
        XCTAssertEqual(type.supertype?.asKnownType?.typeName, "NSObject")
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type),
                        "Missing NSDictionary's default parameterless constructor")
    }
    
    func testNSMutableDictionaryDefinition() {
        guard let type = sut.knownTypeWithName("NSMutableDictionary") else {
            XCTFail("Expected NSMutableDictionary to be present")
            return
        }
        
        XCTAssertEqual(type.supertype?.asKnownType?.typeName, "NSDictionary")
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type),
                        "Missing NSMutableDictionary's default parameterless constructor")
    }
    
    func testConstructorSearchesThroughSupertypes() {
        let type1 = KnownTypeBuilder(typeName: "A").addingConstructor().build()
        let type2 = KnownTypeBuilder(typeName: "B", supertype: type1).build()
        let type3 = KnownTypeBuilder(typeName: "C", supertype: type2).build()
        
        sut.addType(type1)
        sut.addType(type2)
        sut.addType(type3)
        
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type1))
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type2))
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type3))
    }
    
    func testConstructorSearchesTypeNamedSupertypes() {
        let type1 = KnownTypeBuilder(typeName: "A").addingConstructor().build()
        let type2 = KnownTypeBuilder(typeName: "B", supertype: type1).build()
        let type3 = KnownTypeBuilder(typeName: "C", supertype: "B").build()
        
        sut.addType(type1)
        sut.addType(type2)
        sut.addType(type3)
        
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type1))
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type2))
        XCTAssertNotNil(sut.constructor(withArgumentLabels: [], in: type3))
    }
}
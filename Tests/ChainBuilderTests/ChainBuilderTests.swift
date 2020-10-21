import XCTest
@testable import ChainBuilder

final class ChainBuilderTests: XCTestCase {

    static var allTests = [
        ("testDuctTape_dynamicMemberLookup", testChainBuilder_dynamicMemberLookup),
        ("testDuctTape_reinforce", testChainBuilder_reinforce)
    ]

    func testChainBuilder_dynamicMemberLookup() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Object()
            .chain
            .intValue(intValue)
            .stringValue(stringValue)
            .boolValue(boolValue)
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    func testChainBuilder_reinforce() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Object()
            .chain
            .reinforce {
                $0.intValue = intValue
                $0.stringValue = stringValue
                $0.boolValue = boolValue
            }
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    func testChainBuilder_without_protocol() {
        let intValue = Int(arc4random())
        let stringValue = String(arc4random())
        let boolValue = arc4random() % 2 == 0

        let object = Chain(ObjectBase())
            .reinforce {
                $0.intValue = intValue
                $0.stringValue = stringValue
                $0.boolValue = boolValue
            }
            .build()

        XCTAssertEqual(object.intValue, intValue)
        XCTAssertEqual(object.stringValue, stringValue)
        XCTAssertEqual(object.boolValue, boolValue)
    }

    private class ObjectBase {
        var intValue: Int?
        var stringValue: String?
        var boolValue: Bool?
    }

    private final class Object: ObjectBase, Chainable {}
}

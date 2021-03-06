import Foundation
import XCTest
import xcproj

final class PBXGroupSpec: XCTestCase {

    var subject: PBXGroup!

    override func setUp() {
        super.setUp()
        self.subject = PBXGroup(reference: "ref",
                                children: ["333"],
                                sourceTree: .group,
                                name: "name")
    }

    func test_init_initializesTheGroupWithTheRightProperties() {
        XCTAssertEqual(subject.reference, "ref")
        XCTAssertEqual(subject.children, ["333"])
        XCTAssertEqual(subject.sourceTree, .group)
        XCTAssertEqual(subject.name, "name")
        XCTAssertEqual(subject.usesTabs, nil)
    }

    func test_init_failsIfChildrenIsMissing() {
        var dictionary = testDictionary()
        dictionary.removeValue(forKey: "children")
        let data = try! JSONSerialization.data(withJSONObject: dictionary, options: [])
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode(PBXGroup.self, from: data)
            XCTAssertTrue(false, "Expected to throw an error but it didn't")
        } catch {}
    }

    func test_isa_returnsTheCorrectValue() {
        XCTAssertEqual(PBXGroup.isa, "PBXGroup")
    }

    func test_equals_returnsTheCorretValue() {
        let another = PBXGroup(reference: "ref",
                               children: ["333"],
                               sourceTree: .group,
                               name: "name")
        XCTAssertEqual(subject, another)

        let withUsesTabs = PBXGroup(reference: "ref",
                                    children: ["333"],
                                    sourceTree: .group,
                                    name: "name",
                                    usesTabs: 1)
        XCTAssertNotEqual(subject, withUsesTabs)
    }

    func test_hashValue_returnsTheReferenceHashValue() {
        XCTAssertEqual(subject.hashValue, subject.reference.hashValue)
    }

    private func testDictionary() -> [String: Any] {
        return [
            "children": ["child"],
            "name": "name",
            "sourceTree": "absolute",
            "reference": "reference"
        ]
    }
}

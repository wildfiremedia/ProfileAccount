import XCTest
@testable import WildfireMediaProfile

class WildfireMediaProfileTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(WildfireMediaProfile().text, "Hello, World!")
    }


    static var allTests : [(String, (WildfireMediaProfileTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}

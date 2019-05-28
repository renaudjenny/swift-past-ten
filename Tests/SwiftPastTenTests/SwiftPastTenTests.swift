import XCTest
@testable import SwiftPastTen

final class SwiftPastTenTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftPastTen().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

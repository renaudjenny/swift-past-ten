import XCTest
@testable import SwiftPastTen

class UtilitiesTests: XCTestCase {
    func testFormattedEpochDate() {
        let date = Date(timeIntervalSince1970: 0)
        var calendar = Calendar(identifier: .gregorian)
        guard  let timeZone = TimeZone(secondsFromGMT: 0) else {
            XCTFail("Cannot get TimeZome from secondsFromGMT: 0")
            return
        }
        calendar.timeZone = timeZone

        XCTAssertEqual(SwiftPastTen.formattedDate(date, calendar: calendar), "00:00")
    }

    func testFormattedAMDate() {
        let date = Date(timeIntervalSince1970: 4300)
        var calendar = Calendar(identifier: .gregorian)
        guard  let timeZone = TimeZone(secondsFromGMT: 0) else {
            XCTFail("Cannot get TimeZome from secondsFromGMT: 0")
            return
        }
        calendar.timeZone = timeZone

        XCTAssertEqual(SwiftPastTen.formattedDate(date, calendar: calendar), "01:11")
    }

    func testFormattedPMDate() {
        let date = Date(timeIntervalSince1970: 51600)
        var calendar = Calendar(identifier: .gregorian)
        guard  let timeZone = TimeZone(secondsFromGMT: 0) else {
            XCTFail("Cannot get TimeZome from secondsFromGMT: 0")
            return
        }
        calendar.timeZone = timeZone

        XCTAssertEqual(SwiftPastTen.formattedDate(date, calendar: calendar), "14:20")
    }

    static var allTests = [
        ("testFormattedEpochDate", testFormattedEpochDate),
        ("testFormattedAMDate", testFormattedAMDate),
        ("testFormattedPMDate", testFormattedPMDate)
    ]
}

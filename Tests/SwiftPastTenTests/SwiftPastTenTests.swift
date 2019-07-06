import XCTest
@testable import SwiftPastTen

final class SwiftPastTenTests: XCTestCase {
  func testWhenIAskForAllClockHoursThenIReadAllOClockHours() throws {
    let literalHours: [Int: String] = [
      1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six",
      7: "seven", 8: "eight", 9: "nine", 10: "ten", 11: "eleven", 12: "twelve"
    ]
    try literalHours.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: "\(numericalHour):00"), "It's \(literalHour) o'clock.")
    }
  }

  func testWhenIAskForXMinutesAfterYHourThenIReadXMinutesPastY() throws {
    let examples: [String: String] = [
      "7:05": "five past seven", "12:25": "twenty-five past twelve"
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour)")
    }
  }

  func testWhenIAskForXMinutesBeforYHourThenIReadXMinutesToYPlusOne() throws {
    let examples: [String: String] = [
      "7:55": "five to eight", "12:35": "twenty-five to one",
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour)")
    }
  }

  func testWhenIAskForThirtyMinutesThenIReadHalfPastXHour() throws {
    let examples: [String: String] = [
      "11:30": "half past eleven", "01:30": "half past one"
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour)")
    }
  }

  func testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour() throws {
    let examples: [String: String] = [
      "9:15": "quarter past nine", "8:15": "quarter past eight"
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour)")
    }
  }

  func testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour() throws {
    let examples: [String: String] = [
      "9:45": "quarter to ten", "8:45": "quarter to nine"
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour)")
    }
  }

  func testWhenIAskForZeroHourThenIReadMidnight() {
    XCTAssertEqual(try SwiftPastTen().tell(time: "00:00"), "It's midnight")
  }

  func testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid() {
    XCTAssertThrowsError(try SwiftPastTen().tell(time: "ABCD1234"), "No error is thrown when the time string is not valid") { error in
      XCTAssert(error is SwiftPastTen.FormatError, "Error type when the time string is not valid must be FormatError")
    }
  }

  static var allTests = [
      ("testWhenIAskForAllClockHoursThenIReadAllOClockHours", testWhenIAskForAllClockHoursThenIReadAllOClockHours),
      ("testWhenIAskForXMinutesAfterYHourThenIReadXMinutesPastY", testWhenIAskForXMinutesAfterYHourThenIReadXMinutesPastY),
      ("testWhenIAskForXMinutesBeforYHourThenIReadXMinutesToYPlusOne", testWhenIAskForXMinutesBeforYHourThenIReadXMinutesToYPlusOne),
      ("testWhenIAskForThirtyMinutesThenIReadHalfPastXHour", testWhenIAskForThirtyMinutesThenIReadHalfPastXHour),
      ("testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour", testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour),
      ("testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour", testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour),
      ("testWhenIAskForZeroHourThenIReadMidnight", testWhenIAskForZeroHourThenIReadMidnight),
      ("testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid", testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid)
  ]
}

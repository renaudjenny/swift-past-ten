import XCTest
@testable import SwiftPastTen

final class SwiftPastTenTests: XCTestCase {
  func testWhenIAskForXHoursZeroMinutesThenIReadXHoursOClock() throws {
    let literalHoursAM: [Int: String] = [
      1: "one", 2: "two", 3: "three", 4: "four", 5: "five", 6: "six",
      7: "seven", 8: "eight", 9: "nine", 10: "ten", 11: "eleven", 12: "twelve"
    ]
    try literalHoursAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: "\(numericalHour):00"), "It's \(literalHour) o'clock.")
    }

    let literalHoursPM: [Int: String] = [
      13: "one", 14: "two", 15: "three", 16: "four", 17: "five", 18: "six",
      19: "seven", 20: "eight", 21: "nine", 22: "ten", 23: "eleven"
    ]
    try literalHoursPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: "\(numericalHour):00"), "It's \(literalHour) o'clock in the afternoon.")
    }
  }

  func testWhenIAskForFivishYMinutesAfterXHourThenIReadYMinutesPastXHour() throws {
    let examplesAM: [String: String] = [
      "7:05": "five past seven AM", "8:10": "ten past eight AM",
      "9:20": "twenty past nine AM", "12:25": "twenty-five past twelve"
    ]

    try examplesAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }

    let examplesPM: [String: String] = [
      "19:05": "five past seven PM", "20:10": "ten past eight PM",
      "14:20": "twenty past two PM", "00:25": "twenty-five past midnight"
    ]

    try examplesPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForFivishYMinutesBeforeYHourThenIReadYMinutesToXPlusOneHour() throws {
    let examplesAM: [String: String] = [
      "7:35": "twenty-five to eight AM", "8:40": "twenty to nine AM",
      "9:50": "ten to ten AM", "11:50": "ten to twelve", //"12:55": "five to one PM"
    ]

    try examplesAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }

    let examplesPM: [String: String] = [
      "00:35": "twenty-five to one AM", "13:40": "twenty to two PM",
      "17:50": "ten to six PM", "19:55": "five to eight PM",
      "23:35": "twenty-five to midnight",
    ]

    try examplesPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForNonFivishYMinutesThenIReadXHourYMinutes() throws {
    let examples: [String: String] = [
      "1:01": "one, one AM", "2:02": "two, two AM",
      "19:19": "seven, nineteen PM", "23:59": "eleven, fifty-nine PM"
    ]

    try examples.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForThirtyMinutesThenIReadHalfPastXHour() throws {
    let examplesAM: [String: String] = [
      "11:30": "half past eleven AM", "01:30": "half past one AM"
    ]

    try examplesAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }

    let examplesPM: [String: String] = [
      "23:30": "half past eleven PM", "13:30": "half past one PM", "00:30": "half past midnight"
    ]

    try examplesPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour() throws {
    let examplesAM: [String: String] = [
      "9:15": "quarter past nine AM", "8:15": "quarter past eight AM"
    ]

    try examplesAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }

    let examplesPM: [String: String] = [
      "21:15": "quarter past nine PM", "20:15": "quarter past eight PM", "00:15": "quarter past midnight"
    ]

    try examplesPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour() throws {
    let examplesAM: [String: String] = [
      "9:45": "quarter to ten AM", "8:45": "quarter to nine AM"
    ]

    try examplesAM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }

    let examplesPM: [String: String] = [
      "21:45": "quarter to ten PM", "20:45": "quarter to nine PM", "23:45": "quarter to midnight"
    ]

    try examplesPM.forEach { numericalHour, literalHour in
      XCTAssertEqual(try SwiftPastTen().tell(time: numericalHour), "It's \(literalHour).")
    }
  }

  func testWhenIAskForZeroHourThenIReadMidnight() {
    XCTAssertEqual(try SwiftPastTen().tell(time: "00:00"), "It's midnight.")
  }

  func testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid() {
    XCTAssertThrowsError(try SwiftPastTen().tell(time: "ABCD1234"), "No error is thrown when the time string is not valid") { error in
      XCTAssert(error is SwiftPastTen.FormatError, "Error type when the time string is not valid must be FormatError")
    }

    XCTAssertThrowsError(try SwiftPastTen().tell(time: "24:52"), "No error is thrown when the time string is not valid") { error in
      XCTAssert(error is SwiftPastTen.FormatError, "Error type when the time string is not valid must be FormatError")
    }

    XCTAssertThrowsError(try SwiftPastTen().tell(time: "23:60"), "No error is thrown when the time string is not valid") { error in
      XCTAssert(error is SwiftPastTen.FormatError, "Error type when the time string is not valid must be FormatError")
    }

  }

  static var allTests = [
      ("testWhenIAskForXHoursZeroMinutesThenIReadXHoursOClock", testWhenIAskForXHoursZeroMinutesThenIReadXHoursOClock),
      ("testWhenIAskForFivishYMinutesAfterXHourThenIReadYMinutesPastXHour", testWhenIAskForFivishYMinutesAfterXHourThenIReadYMinutesPastXHour),
      ("testWhenIAskForFivishYMinutesBeforeYHourThenIReadYMinutesToXPlusOneHour", testWhenIAskForFivishYMinutesBeforeYHourThenIReadYMinutesToXPlusOneHour),
      ("testWhenIAskForNonFivishYMinutesThenIReadXHourYMinutes", testWhenIAskForNonFivishYMinutesThenIReadXHourYMinutes),
      ("testWhenIAskForThirtyMinutesThenIReadHalfPastXHour", testWhenIAskForThirtyMinutesThenIReadHalfPastXHour),
      ("testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour", testWhenIAskForFifteenMinutesThenIReadQuarterPastXHour),
      ("testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour", testWhenIAskForFortyFiveMinutesThenIReadQuarterToXPlusOneHour),
      ("testWhenIAskForZeroHourThenIReadMidnight", testWhenIAskForZeroHourThenIReadMidnight),
      ("testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid", testWhenIAskForANonWellFormattedTimeThenIReadAnErrorThatMyTimeIsNotValid)
  ]
}

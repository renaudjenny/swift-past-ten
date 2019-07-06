import Foundation

public struct SwiftPastTen {
  private var numberFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter
  }

  public func tell(time: String) throws -> String {
    let splittedTime = time.split(separator: ":")
    guard splittedTime.count == 2 else {
      throw FormatError.wrongFormat
    }
    let hourAsString = String(splittedTime[0])
    guard let hour = Int(hourAsString) else {
      throw FormatError.wrongFormat
    }
    let minutesAsString = String(splittedTime[1])
    guard let minutes = Int(minutesAsString) else {
      throw FormatError.wrongFormat
    }

    if hour == 0 && minutes == 0 {
      return "It's midnight"
    }

    switch minutes {
    case 0:
      let literalHour = self.literalHour(hour: hour)
      return "It's \(literalHour) o'clock."
    case 15:
      let literalHour = self.literalHour(hour: hour)
      return "It's quarter past \(literalHour)"
    case 30:
      let literalHour = self.literalHour(hour: hour)
      return "It's half past \(literalHour)"
    case 45:
      let literalHour = self.literalHourPlusOne(hour: hour)
      return "It's quarter to \(literalHour)"
    case 31...44, 46...59:
      return "It's \(self.literalHourAndThirtyLastMinutes(hour: hour, minutes: minutes))"
    default:
      return "It's \(self.literalHourAndThirtyFirstMinutes(hour: hour, minutes: minutes))"
    }
  }

  private func literalHour(hour: Int) -> String {
    return self.numberFormatter.string(from: NSNumber(value: hour))!
  }

  private func literalHourAndThirtyFirstMinutes(hour: Int, minutes: Int) -> String {
    let hour = self.literalHour(hour: hour)
    let minutes = self.numberFormatter.string(from: NSNumber(value: minutes))!
    return "\(minutes) past \(hour)"
  }

  private func literalHourAndThirtyLastMinutes(hour: Int, minutes: Int) -> String {
    let hourPlusOne = self.literalHourPlusOne(hour: hour)
    let minutesToNextHour = -(minutes - 60)
    let minutes = self.numberFormatter.string(from: NSNumber(value: minutesToNextHour))!
    return "\(minutes) to \(hourPlusOne)"
  }

  private func literalHourPlusOne(hour: Int) -> String {
    if hour >= 12 {
      return self.literalHour(hour: 1)
    } else {
      return self.literalHour(hour: hour + 1)
    }
  }
}

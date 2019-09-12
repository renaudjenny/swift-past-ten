import Foundation

public struct SwiftPastTen {
  private var numberFormatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    return formatter
  }

  public init() { }

  public func tell(time: String) throws -> String {
    let splittedTime = time.split(separator: ":")
    guard splittedTime.count == 2 else {
      throw FormatError.wrongFormat
    }
    let hourAsString = String(splittedTime[0])
    guard let hour = Int(hourAsString), hour < 24 else {
      throw FormatError.wrongFormat
    }
    let minutesAsString = String(splittedTime[1])
    guard let minutes = Int(minutesAsString), minutes < 60 else {
      throw FormatError.wrongFormat
    }

    if hour == 0 && minutes == 0 {
      return "It's midnight"
    }

    if (hour <= 12) {
      return literalTime(hour: hour, minutes: minutes, period: "AM")
    } else {
      return literalTime(hour: hour - 12, minutes: minutes, period: "PM")
    }
  }

  private func literalTime(hour: Int, minutes: Int, period: String) -> String {
    switch minutes {
    case 0:
      let literalHour = self.literalHour(hour: hour)
      return "It's \(literalHour) o'clock \(period)."
    case 15:
      let literalHour = self.literalHour(hour: hour, period: period)
      return "It's quarter past \(literalHour)"
    case 30:
      let literalHour = self.literalHour(hour: hour, period: period)
      return "It's half past \(literalHour)"
    case 45:
      let literalHour = self.literalHourPlusOne(hour: hour, period: period)
      return "It's quarter to \(literalHour)"
    case 31...44, 46...59:
      return "It's \(self.literalHourAndThirtyLastMinutes(hour: hour, minutes: minutes, period: period))"
    default:
      return "It's \(self.literalHourAndThirtyFirstMinutes(hour: hour, minutes: minutes, period: period))"
    }
  }

  private func literalHour(hour: Int, period: String? = nil) -> String {
    guard hour != 0 else { return "midnight" }

    let literalHour = self.numberFormatter.string(from: NSNumber(value: hour))!

    guard let period = period else { return literalHour }

    return "\(literalHour) \(period)"
  }

  private func literalHourAndThirtyFirstMinutes(hour: Int, minutes: Int, period: String) -> String {
    let hour = self.literalHour(hour: hour, period: period)
    let minutes = self.numberFormatter.string(from: NSNumber(value: minutes))!
    return "\(minutes) past \(hour)"
  }

  private func literalHourAndThirtyLastMinutes(hour: Int, minutes: Int, period: String) -> String {
    let hourPlusOne = self.literalHourPlusOne(hour: hour, period: period)
    let minutesToNextHour = -(minutes - 60)
    let minutes = self.numberFormatter.string(from: NSNumber(value: minutesToNextHour))!
    return "\(minutes) to \(hourPlusOne)"
  }

  private func literalHourPlusOne(hour: Int, period: String) -> String {
    if hour >= 12 {
      return self.literalHour(hour: 1, period: period)
    } else {
      return self.literalHour(hour: hour + 1, period: period)
    }
  }
}

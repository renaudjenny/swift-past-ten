import Foundation

public struct SwiftPastTen {
    public var tellTime: (String) throws -> String

    public init(tellTime: @escaping (String) throws -> String) {
        self.tellTime = tellTime
    }

    public func callAsFunction(time: String) throws -> String {
        try tellTime(time)
    }
}

extension SwiftPastTen {
    public static let live = Self(tellTime: { try TellTime().tell(time: $0) })
}

struct TellTime {
    enum Period: String {
        case AM, PM
    }

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }

    func tell(time: String) throws -> String {
        let splitTime = time.split(separator: ":")
        guard splitTime.count == 2 else {
            throw PastTenFormatError.wrongFormat
        }
        let hourAsString = String(splitTime[0])
        guard let hour = Int(hourAsString), hour < 24 else {
            throw PastTenFormatError.wrongFormat
        }
        let minuteAsString = String(splitTime[1])
        guard let minute = Int(minuteAsString), minute < 60 else {
            throw PastTenFormatError.wrongFormat
        }

        if hour == 0 && minute == 0 {
            return "It's midnight."
        }

        if hour <= 12 {
            return try literalTime(hour: hour, minute: minute, period: .AM)
        } else {
            return try literalTime(hour: hour - 12, minute: minute, period: .PM)
        }
    }

    private func literalTime(hour: Int, minute: Int, period: Period) throws -> String {
        switch minute {
        case 0:
            return try exactHourTime(hour: hour, period: period)
        case 15:
            let literalHour = try self.literalHour(hour: hour, period: period)
            return "It's quarter past \(literalHour)."
        case 30:
            let literalHour = try self.literalHour(hour: hour, period: period)
            return "It's half past \(literalHour)."
        case 45:
            let literalHour = try self.literalHourPlusOne(hour: hour, period: period)
            return "It's quarter to \(literalHour)."
        case let x where x % 5 == 0:
            return try fiveMinuteTime(hour: hour, minute: x, period: period)
        default:
            return try fallbackTime(hour: hour, minute: minute, period: period)
        }
    }

    private func exactHourTime(hour: Int, period: Period) throws -> String {
        let literalHour = try self.literalHour(hour: hour)
        switch period {
        case .AM: return "It's \(literalHour) o'clock."
        case .PM: return "It's \(literalHour) o'clock in the afternoon."
        }
    }

    private func fiveMinuteTime(hour: Int, minute: Int, period: Period) throws -> String {
        switch minute {
        case 0...30:
            let time = try self.literalHourAndThirtyFirstMinute(hour: hour, minute: minute, period: period)
            return "It's \(time)."
        default:
            let time = try self.literalHourAndThirtyLastMinute(hour: hour, minute: minute, period: period)
            return "It's \(time)."
        }
    }

    private func fallbackTime(hour: Int, minute: Int, period: Period) throws -> String {
        guard let literalMinute = self.numberFormatter.string(from: NSNumber(value: minute)) else {
            throw PastTenFormatError.cannotParseNumber
        }
        let literalMinuteWithPotentialPrefix = minute < 10 ? "O \(literalMinute)" : literalMinute
        if hour == 0 || hour == 12 {
            return "It's \(try self.literalHour(hour: hour)) \(literalMinuteWithPotentialPrefix)."
        }
        return "It's \(try self.literalHour(hour: hour)) \(literalMinuteWithPotentialPrefix) \(period)."
    }

    private func literalHour(hour: Int, period: Period? = nil) throws -> String {
        guard hour != 0 else { return "midnight" }

        guard let literalHour = self.numberFormatter.string(from: NSNumber(value: hour)) else {
            throw PastTenFormatError.cannotParseNumber
        }
        guard hour != 12 else { return literalHour }

        guard let period = period else { return literalHour }

        return "\(literalHour) \(period)"
    }

    private func literalHourAndThirtyFirstMinute(hour: Int, minute: Int, period: Period) throws -> String {
        let hour = try self.literalHour(hour: hour, period: period)
        guard let minute = self.numberFormatter.string(from: NSNumber(value: minute)) else {
            throw PastTenFormatError.cannotParseNumber
        }
        return "\(minute) past \(hour)"
    }

    private func literalHourAndThirtyLastMinute(hour: Int, minute: Int, period: Period) throws -> String {
        let hourPlusOne = try self.literalHourPlusOne(hour: hour, period: period)
        let minutesToNextHour = -(minute - 60)
        guard let minute = self.numberFormatter.string(from: NSNumber(value: minutesToNextHour)) else {
            throw PastTenFormatError.cannotParseNumber
        }
        return "\(minute) to \(hourPlusOne)"
    }

    private func literalHourPlusOne(hour: Int, period: Period) throws -> String {
        let hourPlusOne = hour + 1
        switch hourPlusOne {
        case 1..<12:
            return try self.literalHour(hour: hourPlusOne, period: period)
        case 12:
            switch period {
            case .AM: return try self.literalHour(hour: 12)
            case .PM: return try self.literalHour(hour: 0)
            }
        default:
            return try self.literalHour(hour: 1, period: .PM)
        }
    }
}

import Foundation

extension SwiftPastTen {
    public static func formattedDate(_ date: Date, calendar: Calendar) -> String {
        let minute = calendar.component(.minute, from: date)
        let hour = calendar.component(.hour, from: date)
        return fromHour(hour, minute: minute)
    }

    private static func fromHour(_ hour: Int, minute: Int) -> String {
        let minute = minute > 9 ? "\(minute)" : "0\(minute)"
        let hour = hour > 9 ? "\(hour)" : "0\(hour)"
        return "\(hour):\(minute)"
    }
}

# SwiftPastTen

![Swift Unit Tests](https://github.com/renaudjenny/SwiftPastTen/workflows/Swift/badge.svg)

⏰🇬🇧 Telling the time in a British English way

## Usage

```swift
import SwiftPastTen

var britishTime: String?

// O'clock hours
britishTime = try? SwiftPastTen().tell(time: "7:00")
print(britishTime) // Optional("It's seven o'clock.")

// O'clock in the afternoon
britishTime = try? SwiftPastTen().tell(time: "14:00")
print(britishTime) // Optional("It's two o'clock in the afternoon.")

// To/Past Fivish minutes like Five, Ten, Twenty and Twenty-five minutes
britishTime = try? SwiftPastTen().tell(time: "6:40")
print(britishTime) // Optional("It's twenty to seven AM.")

// Non fivish minutes is read X (hours) Y (minutes) AM/PM
britishTime = try? SwiftPastTen().tell(time: "19:19")
print(britishTime) // Optional("It's seven nineteen PM.")

// To/Past Quarter and Half
britishTime = try? SwiftPastTen().tell(time: "9:15")
print(britishTime) // Optional("It's quarter past nine AM.")

// Midnight
britishTime = try? SwiftPastTen().tell(time: "00:00")
print(britishTime) // Optional("It's midnight.")
britishTime = try? SwiftPastTen().tell(time: "23:45")
print(britishTime) // Optional("It's quarter to midnight.")
```

You can easily convert a `Date` to a formatted time that could be converted with `formattedDate`

```swift
import Foundation
import SwiftPastTen

// 01:11
let date = Date(timeIntervalSince1970: 4300)
var calendar = Calendar(identifier: .gregorian)
calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone

let time = SwiftPastTen.formattedDate(date, calendar: calendar)
let tellTime = try? SwiftPastTen().tell(time: time)
print(tellTime) // Optional("It's one eleven")
```

## Installation

### Xcode

You can add SwiftPastTen to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency...**
2. Enter "https://github.com/renaudjenny/SwiftPastTen" into the package repository URL test field

### As package dependency

Edit your `Package.swift` to add this library.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/renaudjenny/SwiftPastTen", from: "1.0.1"),
        ...
    ],
    targets: [
        .target(
            name: "<Your project name>",
            dependencies: ["SwiftPastTen"]),
        ...
    ]
)
```

## App using this library

* [📲 Tell Time UK](https://apps.apple.com/gb/app/tell-time-uk/id1496541173): https://github.com/renaudjenny/telltime

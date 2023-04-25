# SwiftPastTen

![Swift Unit Tests](https://github.com/renaudjenny/SwiftPastTen/workflows/Swift/badge.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frenaudjenny%2Fswift-past-ten%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/renaudjenny/swift-past-ten)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frenaudjenny%2Fswift-past-ten%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/renaudjenny/swift-past-ten)

⏰🇬🇧 Telling the time in a British English way

This package contains two libraries that converts a clock time like `"7:00"` to its spoken British version, like `"It's sevent o'clock."`.

* `SwiftPastTen` The main library and has a static function with this signature: `live(time: String) throws -> String` where you simply providing a time like in the example above, see examples below
* `SwiftPastTenDependency` A wrapper around the library above facilitating the integration with [Point-Free Dependencies](https://github.com/pointfreeco/swift-dependencies) library or a project made with The Composable Architecture (TCA).

## Usage

```swift
import SwiftPastTen

var britishTime: String?

// O'clock hours
britishTime = try? SwiftPastTen.live(time: "7:00")
print(britishTime) // Optional("It's seven o'clock.")

// O'clock in the afternoon
britishTime = try? SwiftPastTen.live(time: "14:00")
print(britishTime) // Optional("It's two o'clock in the afternoon.")

// To/Past Fivish minutes like Five, Ten, Twenty and Twenty-five minutes
britishTime = try? SwiftPastTen.live(time: "6:40")
print(britishTime) // Optional("It's twenty to seven AM.")

// Non fivish minutes is read X (hours) Y (minutes) AM/PM
britishTime = try? SwiftPastTen.live(time: "19:19")
print(britishTime) // Optional("It's seven nineteen PM.")

// To/Past Quarter and Half
britishTime = try? SwiftPastTen.live(time: "9:15")
print(britishTime) // Optional("It's quarter past nine AM.")

// Midnight
britishTime = try? SwiftPastTen.live(time: "00:00")
print(britishTime) // Optional("It's midnight.")
britishTime = try? SwiftPastTen.live(time: "23:45")
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
let tellTime = try? SwiftPastTen.live(time: time)
print(tellTime) // Optional("It's one eleven")
```

## [Point-Free Dependencies](https://github.com/pointfreeco/swift-dependencies) usage

Add `@Dependency(\.tellTime) var tellTime` in your `Reducer`, you will have access to all functions mentioned above.

### Example

```swift
import ComposableArchitecture
import Foundation
import SwiftPastTenDependency

public struct BritishTime: ReducerProtocol {
    public struct State: Equatable {
        public var tellTime = ""
        
        public init(tellTime: String = "") {
            self.tellTime = tellTime
        }
    }

    public enum Action: Equatable {
        case tellTime(Date)
    }

    @Dependency(\.calendar) var calendar
    @Dependency(\.tellTime) var tellTime

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .tellTime(date):
                let time = SwiftPastTen.formattedDate(date, calendar: calendar)
                state.tellTime = (try? tellTime(time: time)) ?? ""
                return .none
        }
    }
}

```

## Installation

### Xcode

You can add SwiftPastTen to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency...**
2. Enter "https://github.com/renaudjenny/swift-past-ten" into the package repository URL test field
3. Select one of the library that you are interested in. See [above](#swiftpastten)

### As package dependency

Edit your `Package.swift` to add one of the library you want among the two available.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/renaudjenny/swift-past-ten", from: "1.1.0"),
        ...
    ],
    targets: [
        .target(
            name: "<Your project name>",
            dependencies: [
                .product(name: "SwiftPastTen", package: "swift-past-ten"), // <-- Basic version
                .product(name: "SwiftPastTenDependency", package: "swift-past-ten"), // <-- Point-Free Dependencies library wrapper
            ]),
        ...
    ]
)
```

## App using this library

* [📲 Tell Time UK](https://apps.apple.com/gb/app/tell-time-uk/id1496541173): https://github.com/renaudjenny/telltime

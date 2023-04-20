// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-past-ten",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(name: "SwiftPastTen", targets: ["SwiftPastTen"]),
        .library(name: "SwiftPastTenDependency", targets: ["SwiftPastTenDependency"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.4.1"),
    ],
    targets: [
        .target(name: "SwiftPastTen", dependencies: []),
        .testTarget(name: "SwiftPastTenTests", dependencies: ["SwiftPastTen"]),
        .target(
            name: "SwiftPastTenDependency",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "SwiftPastTen",
            ]
        ),
    ]
)

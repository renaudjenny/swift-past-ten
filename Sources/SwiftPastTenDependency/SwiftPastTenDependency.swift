import Dependencies
@_exported import SwiftPastTen
import XCTestDynamicOverlay

extension SwiftPastTen {
    static let preview = SwiftPastTen.live
    static let test = Self(tellTime: unimplemented("SwiftPastTen.tellTime"))
}

private enum SwiftPastTenDependencyKey: DependencyKey {
    static let liveValue = SwiftPastTen.live
    static let previewValue = SwiftPastTen.preview
    static let testValue = SwiftPastTen.test
}

public extension DependencyValues {
    var tellTime: SwiftPastTen {
        get { self[SwiftPastTenDependencyKey.self] }
        set { self[SwiftPastTenDependencyKey.self] = newValue }
    }
}

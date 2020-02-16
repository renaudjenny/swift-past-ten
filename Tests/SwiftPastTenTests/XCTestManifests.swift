import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftPastTenTests.allTests),
        testCase(Utilities.allTests),
    ]
}
#endif

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [
        testCase(SwiftPastTenTests.allTests),
        testCase(Utilities.allTests)
    ]
}
#endif

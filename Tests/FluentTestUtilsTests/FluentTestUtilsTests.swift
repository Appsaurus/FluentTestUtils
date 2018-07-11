import XCTest
@testable import FluentTestUtils
import SwiftTestUtils

final class FluentTestUtilsTests: BaseTestCase {

	static var allTests = [
		("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),
        ("testExample", testExample)
    ]
	func testLinuxTestSuiteIncludesAllTests(){
		assertLinuxTestCoverage(tests: type(of: self).allTests)
	}
	func testExample() {

	}
}

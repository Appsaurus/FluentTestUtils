# FluentTestUtils
![Swift](http://img.shields.io/badge/swift-4.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
![License](http://img.shields.io/badge/license-MIT-CCCCCC.svg)

FluentTestUtils makes it easier to quickly setup a Fluent-based Vapor app for library testing purposes. If you have an existing Vapor app that you want to test, see [VaporTestUtils] (https://github.com/Appsaurus/VaporTestUtils).

## Installation

**FluentTestUtils** is available through [Swift Package Manager](https://swift.org/package-manager/). To install, add the following to your Package.swift file.

```swift
let package = Package(
    name: "YourProject",
    dependencies: [
        ...
        .package(url: "https://github.com/Appsaurus/FluentTestUtils", from: "0.1.0"),
    ],
    targets: [
      .testTarget(name: "YourApp", dependencies: ["FluentTestUtils", ... ])
    ]
)
        
```
## Usage

**1. Import the library**

```swift
import FluentTestUtils
```

**2. Setup your test case**

Create a test case inheriting from `FluentTestCase`. 

Registering and configuration of services, databases, and migrations can be done via overriding `register(services:)`, `configure(databases:)` and `configure(migrations:)` respectively.

```swift
open class ExampleAppTestCase: FluentTestCase{
	static var allTests = [
		("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),		
		("testExample", testExample) //Reference your tests here for Linux check
	]

	func testLinuxTestSuiteIncludesAllTests(){
		assertLinuxTestCoverage(tests: type(of: self).allTests)
	}
	
	let sqlite: SQLiteDatabase = try! SQLiteDatabase(storage: .memory)
	
	open override func register(_ services: inout Services) throws {
		try super.register(&services)
		try services.register(FluentSQLiteProvider())
		services.register(sqlite)
	}
	
	open override func configure(databases: inout DatabasesConfig) throws{
		try super.configure(databases: &databases)
		databases.add(database: sqlite, as: .sqlite)
	}

	open override func configure(migrations: inout MigrationConfig){
		super.configure(migrations: &migrations)
		migrations.add(model: ExampleModel.self, database: .sqlite)
		migrations.add(model: ExampleSiblingModel.self, database: .sqlite)
		migrations.add(model: ExampleChildModel.self, database: .sqlite)
		migrations.add(model: ExampleModelSiblingPivot.self, database: .sqlite)
	}
	
	func testExample() {
		//Implement your test
	}
}
```

For futher documentation, see [VaporTestUtils] (https://github.com/Appsaurus/VaporTestUtils) as `FluentTestCase` inherits from that package's `VaporTestCase`.
## Contributing

We would love you to contribute to **FluentTestUtils**, check the [CONTRIBUTING](https://github.com/Appsaurus/FluentTestUtils/blob/master/CONTRIBUTING.md) file for more info.

## License

**FluentTestUtils** is available under the MIT license. See the [LICENSE](https://github.com/Appsaurus/FluentTestUtils/blob/master/LICENSE.md) file for more info.

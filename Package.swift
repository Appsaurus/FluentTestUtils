// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FluentTestUtils",
    products: [
        .library(name: "FluentTestUtils",targets: ["FluentTestUtils"]),
    ],
    dependencies: [
		//Appsaurus Packages
		.package(url: "https://github.com/Appsaurus/VaporTestUtils", .upToNextMajor(from: "0.1.0")),
		.package(url: "https://github.com/Appsaurus/CodableExtensions", .upToNextMajor(from: "1.0.0")),

		//Vapor Packages
		.package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
		.package(url: "https://github.com/vapor/fluent.git", .upToNextMajor(from:"3.0.0")),
    ],
    targets: [
        .target(name: "FluentTestUtils", dependencies: ["Vapor", "Fluent", "VaporTestUtils", "CodableExtensions"]),
        .testTarget(name: "FluentTestUtilsTests",dependencies: ["FluentTestUtils"]),
    ]
)

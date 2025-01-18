// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FluentTestUtils",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(name: "FluentTestUtils",targets: ["FluentTestUtils"]),
    ],
    dependencies: [
		//Appsaurus Packages
		.package(url: "https://github.com/Appsaurus/VaporTestUtils", from: "0.2.0"),
		.package(url: "https://github.com/Appsaurus/CodableExtensions", from: "1.0.0"),

		//Vapor Packages
		.package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
		.package(url: "https://github.com/vapor/fluent.git", from:"4.0.0"),
    ],
    targets: [
        .target(
            name: "FluentTestUtils",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "CodableExtensions", package: "CodableExtensions"),
                .product(name: "XCTVaporExtensions", package: "VaporTestUtils")
            ]),
        .testTarget(name: "FluentTestUtilsTests", dependencies: [
            .target(name: "FluentTestUtils")
        ])
    ]
)

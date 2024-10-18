// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SCComponents",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SCComponents",
            targets: ["SCComponents"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/GetSchooly/SCTokens", .upToNextMajor(from: Version("1.0.0")))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SCComponents",
            dependencies: ["SCTokens"],
            path: "Sources/SDComponents",
            exclude: []),
        .testTarget(
            name: "SCComponents Tests",
            dependencies: ["SCComponents"]),
    ]
)

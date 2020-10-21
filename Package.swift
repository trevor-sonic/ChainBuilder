// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChainBuilder",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v10), .watchOS(.v3)
    ],
    products: [
        .library(
            name: "ChainBuilder",
            targets: ["ChainBuilder"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ChainBuilder",
            dependencies: []),
        .testTarget(
            name: "ChainBuilderTests",
            dependencies: ["ChainBuilder"]),
    ]
)

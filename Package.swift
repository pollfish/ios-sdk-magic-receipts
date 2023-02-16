// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MagicReceipts",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MagicReceipts",
            targets: ["MagicReceipts"])
    ],
    targets: [
        .binaryTarget(
            name: "MagicReceipts",
            path: "MagicReceipts.xcframework")
    ],
    swiftLanguageVersions: [.v5]
)

// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Multibase",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Multibase",
            targets: ["Multibase"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/attaswift/BigInt.git", from: "3.0.0"),
        .package(url: "https://github.com/norio-nomura/Base32.git", from: "0.5.4")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Multibase",
            dependencies: ["BigInt", "Base32"]),
        .testTarget(
            name: "MultibaseTests",
            dependencies: ["Multibase"]),
    ]
)
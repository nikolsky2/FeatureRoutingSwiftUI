// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIExtensionsKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UIExtensionsKit",
            targets: ["UIExtensionsKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/johnpatrickmorgan/NavigationBackport", from: "0.2.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UIExtensionsKit",
            dependencies: ["NavigationBackport"]),
        .testTarget(
            name: "UIExtensionsKitTests",
            dependencies: ["UIExtensionsKit"]),
    ]
)

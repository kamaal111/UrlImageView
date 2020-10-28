// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UrlImageView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "UrlImageView", targets: ["UrlImageView"]),
    ],
    dependencies: [
         .package(url: "https://github.com/kamaal111/XiphiasNet", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "UrlImageView",
            dependencies: ["XiphiasNet"]),
        .testTarget(
            name: "UrlImageViewTests",
            dependencies: ["UrlImageView"]),
    ]
)

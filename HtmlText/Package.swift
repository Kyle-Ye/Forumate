// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

let isXcodeEnv = ProcessInfo.processInfo.environment["__CFBundleIdentifier"] == "com.apple.dt.Xcode"
// Xcode use clang as linker which supports "-iframework" while SwiftPM use swiftc as linker which supports "-Fsystem"
let systemFrameworkSearchFlag = isXcodeEnv ? "-iframework" : "-Fsystem"

let package = Package(
    name: "HtmlText",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8)],
    products: [
        .library(name: "HtmlText", targets: ["HtmlText"]),
    ],
    targets: [
        .target(name: "WebKit"),
        .target(
            name: "HtmlText",
            dependencies: [.target(name: "WebKit", condition: .when(platforms: [.watchOS, .tvOS]))],
            linkerSettings: [
                .unsafeFlags([systemFrameworkSearchFlag, "/System/Library/Frameworks/"], .when(platforms: [.watchOS, .tvOS])),
                .linkedFramework("Sharing", .when(platforms: [.watchOS, .tvOS])),
            ]
        ),
    ]
)

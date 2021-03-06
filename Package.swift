// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "SwiduxTasksExample",
    products: [
        .library(
            name: "SwiduxTasksExample",
            targets: ["SwiduxTasksExample"]),
    ],
    dependencies: [
        .package(url: "https://github.com/clmntcrl/swidux.git", from: "1.0.0"),
        .package(url: "https://github.com/clmntcrl/swidux-echo.git", from: "0.2.0"),
        .package(url: "https://github.com/clmntcrl/swidux-router.git", from: "0.2.0"),
    ],
    targets: [
        .target(
            name: "SwiduxTasksExample",
            dependencies: ["Swidux", "SwiduxEcho", "SwiduxRouter"]),
        .testTarget(
            name: "SwiduxTasksExampleTests",
            dependencies: ["SwiduxTasksExample"]),
    ]
)

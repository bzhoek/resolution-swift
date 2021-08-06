// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Resolute",
  platforms: [
    .macOS(.v10_15)
  ],
  products: [
    .library(name: "Resolute", targets: ["Resolute"]),
    .executable(name: "resolute", targets: ["ResoluteCli"])
  ],
  dependencies: [],
  targets: [
    .target(name: "Resolute", dependencies: []),
    .target(name: "ResoluteCli", dependencies: ["Resolute"]),
    .testTarget(name: "ResoluteTests", dependencies: ["Resolute"]),
  ]
)

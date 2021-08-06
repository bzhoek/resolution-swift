// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Resolute",
  products: [
    .library(name: "Resolute", targets: ["Resolute"]),
    .executable(name: "resolute", targets: ["Resolute"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Resolute",
      dependencies: []),
    .testTarget(
      name: "ResoluteTests",
      dependencies: ["Resolute"]),
  ]
)

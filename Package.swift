// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Resolute",
  products: [
    .library(name: "Resolute", targets: ["ResoluteLib"]),
    .executable(name: "resolute", targets: ["ResoluteCli"])
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ResoluteLib",
      dependencies: []),
    .target(
      name: "ResoluteCli",
      dependencies: ["ResoluteLib"]),
    .testTarget(
      name: "ResoluteTests",
      dependencies: ["ResoluteLib"]),
  ]
)

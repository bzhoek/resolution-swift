# resolution-swift

Helpers for dealing with setting macOS resolution and scaling from code and command-line. 

See the [NSPrincipal sample](Sources/Resolute/test_helper.swift). It runs once [before and after](https://medium.com/quality-engineering-university/xcuitests-test-listeners-f09cdb35164b) *all* tests when you point a `NSPrincipalClass` entry in the test target `Info.plist` to it. BTW: the target name [cannot contain a hyphen](https://stackoverflow.com/a/67023389/10326604). 

## Package Manager
* [Swift Package Manager](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md)
* [SwiftDev Tutorial](https://theswiftdev.com/swift-package-manager-tutorial/)
* [SwiftDev Manifest](https://theswiftdev.com/the-swift-package-manifest-file/)
* [Wenderlich Tutorial](https://www.raywenderlich.com/1993018-an-introduction-to-swift-package-manager)

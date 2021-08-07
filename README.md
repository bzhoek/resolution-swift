# resolution-swift

Helpers for dealing with setting macOS resolution and scaling from code and command-line. 

## Unscale
Add a `NSPrincipal` key to `Info.plist` for the test target, like below. Then add a `resolute` environment variable with the value `unscale` to the Test action of the scheme.
```
<key>NSPrincipalClass</key>
<string>Resolute.TestObserver</string>
```

The [XCTestObservation implementation](Sources/Resolute/test_helper.swift) runs once [before and after](https://medium.com/quality-engineering-university/xcuitests-test-listeners-f09cdb35164b) *all* tests.

## Package Manager
* [Swift Package Manager](https://github.com/apple/swift-package-manager/blob/main/Documentation/Usage.md)
* [SwiftDev Tutorial](https://theswiftdev.com/swift-package-manager-tutorial/)
* [SwiftDev Manifest](https://theswiftdev.com/the-swift-package-manifest-file/)
* [Wenderlich Tutorial](https://www.raywenderlich.com/1993018-an-introduction-to-swift-package-manager)

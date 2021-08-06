import XCTest

public class TestObserver: NSObject, XCTestObservation {
  let screens = Screens()

  override init() {
    super.init()
    XCTestObservationCenter.shared.addTestObserver(self)
  }

  public func testBundleWillStart(_ testBundle: Bundle) {
    if ProcessInfo().environment["resolute"] == "unscale" {
      screens.saveCurrentMode()
      screens.setScale(1)
    }
  }

  public func testBundleDidFinish(_ testBundle: Bundle) {
    if ProcessInfo().environment["resolute"] == "unscale" {
      screens.restoreSavedMode()
    }
    XCTestObservationCenter.shared.removeTestObserver(self)
  }
}

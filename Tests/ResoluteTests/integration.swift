import XCTest
@testable import Resolute

class ScreenResolutionTest: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  func testListResolutions() {
    XCTAssertEqual(Screens().listDisplays(), ["  0  1536 x  960 @ 2x @ 59Hz"])
  }

  func testUnscaled() {
    let screens = Screens()
    screens.saveCurrentMode()
    XCTAssertEqual([0], screens.savedModes)
  }

}

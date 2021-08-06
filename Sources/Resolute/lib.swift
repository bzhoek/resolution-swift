import Cocoa

class Screens {
  static let MAX_DISPLAYS = 8
  let maxDisplays = MAX_DISPLAYS
  let displays: [Display]

  init() {
    var displayCount: UInt32 = 0
    var displayIDs = [CGDirectDisplayID](repeating: 0, count: maxDisplays)

    guard CGGetOnlineDisplayList(UInt32(maxDisplays), &displayIDs, &displayCount) == .success else {
      print("Error on getting online display List.")
      displays = [Display]()
      return
    }
    displays = displayIDs[0...Int(displayCount - 1)].map { Display($0) }
  }

  func setScale(_ scale: Int) {
    displays.forEach { display in display.setScale(scale) }
  }

  var savedModes = [Int]()

  func saveCurrentMode() {
    savedModes = displays.map { display in display.modeIndex }
  }

  func restoreSavedMode() {
    for (display, mode) in zip(displays, savedModes) {
      display.setMode(with: mode)
    }
  }

  func listDisplays() -> [String] {
    displays.enumerated().map { "\($1.displayString("\($0)"))" }
  }

  func listModes(_ displayIndex: Int) {
    displays[displayIndex].printFormatForAllModes()
  }

}

class Display {
  let displayID: CGDirectDisplayID,
    displayInfo: [DisplayInfo],
    modes: [CGDisplayMode]
  var modeIndex: Int

  init(_ _displayID: CGDirectDisplayID) {
    displayID = _displayID
    var modesArray: [CGDisplayMode]?

    if let modeList = CGDisplayCopyAllDisplayModes(displayID, [kCGDisplayShowDuplicateLowResolutionModes: kCFBooleanTrue] as CFDictionary) {
      modesArray = (modeList as! Array).filter { ($0 as CGDisplayMode).isUsableForDesktopGUI() }
    } else {
      print("Unable to get display modes")
    }
    modes = modesArray!
    displayInfo = modes.map { DisplayInfo(displayID: _displayID, mode: $0) }

    let mode = CGDisplayCopyDisplayMode(displayID)!

    modeIndex = modes.firstIndex(of: mode)!
  }

  func _format(_ di: DisplayInfo, leadingString: String, trailingString: String) -> String {
    String(
      format: "  %@ %5d x %4d @ %dx @ %dHz%@",
      leadingString,
      di.width, di.height,
      di.scale, di.frequency,
      trailingString
    )
  }

  func setScale(_ scale: Int) {
    let current = displayInfo[modeIndex]
    let match = displayInfo.enumerated()
      .filter { (index, info) in
        info.scale == scale
          && info.height == current.height
          && info.width == current.width
          && info.frequency == current.frequency
      }.first

    if let (index, _) = match {
      setMode(with: index)
    }
  }

  func displayString(_ leadingString: String) -> String {
    _format(displayInfo[modeIndex], leadingString: leadingString, trailingString: "")
  }

  func printFormatForAllModes() {
    for (i, di) in displayInfo.enumerated() {
      let bool = i == modeIndex
      print(i, _format(di, leadingString: bool ? "\u{001B}[0;33m⮕" : " ", trailingString: bool ? "\u{001B}[0;49m" : ""))
    }
  }

  private func _set(_ mi: Int) {
    let mode: CGDisplayMode = modes[mi]

    print("Setting display mode")

    var config: CGDisplayConfigRef?

    let error: CGError = CGBeginDisplayConfiguration(&config)
    if error == .success {
      CGConfigureDisplayWithDisplayMode(config, displayID, mode, nil)

      let afterCheck = CGCompleteDisplayConfiguration(config, CGConfigureOption.permanently)
      if afterCheck != .success { CGCancelDisplayConfiguration(config) }
    }
  }

  func setMode(with index: Int) {
    if index != modeIndex { _set(index) }
    modeIndex = index
  }

}

struct DisplayInfo {
  static let MAX_SCALE = 10
  var width, height, scale, frequency: Int

  init(displayID: CGDirectDisplayID, mode: CGDisplayMode) {
    width = mode.width
    height = mode.height
    scale = mode.pixelWidth / mode.width;

    frequency = Int(mode.refreshRate)
    if frequency == 0 {
      var link: CVDisplayLink?
      CVDisplayLinkCreateWithCGDisplay(displayID, &link)

      let time = CVDisplayLinkGetNominalOutputVideoRefreshPeriod(link!)
      let timeScale = Int64(time.timeScale) + time.timeValue / 2

      frequency = Int(timeScale / time.timeValue)
    }
  }
}
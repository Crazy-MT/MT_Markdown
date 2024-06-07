import Cocoa
import FlutterMacOS
import bitsdojo_window_macos // Add this line

class MainFlutterWindow: NSWindow {
    
    override init(
            contentRect: NSRect,
            styleMask style: NSWindow.StyleMask,
            backing bufferingType: NSWindow.BackingStoreType,
            defer flag: Bool) {
            super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
            self.titleVisibility = .hidden
            self.titlebarAppearsTransparent = true
            self.styleMask.insert(.fullSizeContentView)
        }
    
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
    /* override func bitsdojo_window_configure() -> UInt {
      return BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP
    } */
}

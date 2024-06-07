import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {

    override func application(_ sender: NSApplication, open urls: [URL]) {
        for url in urls {
            print("收到文件地址: \(url.path)")
        }
        let filePaths = urls.map { $0.path }
        if let flutterViewController = mainFlutterWindow?.contentViewController as? FlutterViewController {
            let channel = FlutterMethodChannel(name: "com.example.myapp/openFile", binaryMessenger: flutterViewController.engine.binaryMessenger)
            channel.invokeMethod("openFile", arguments: filePaths)
        }
        sender.reply(toOpenOrPrint: .success)
    }
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.backgroundColor = NSColor.white
             // 将窗口大小设置为800x600
            window.setContentSize(NSMakeSize(1280, 700))
            // 获取屏幕的边框
            let screenFrame = window.screen?.frame ?? NSRect.zero
            //计算屏幕的中心点
            let centerX = (screenFrame.width - window.frame.width) / 2
            let centerY = (screenFrame.height - window.frame.height) / 2
            //将窗口的原点设置为中心点
            window.setFrameOrigin(NSPoint(x: centerX, y: centerY))
        }
    }
}

import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {

    override func application(
            _ sender: NSApplication,
            open urls: [URL]
        ) {
       for url in urls {
                   // 处理文件URL，例如打开文件或读取内容
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
}

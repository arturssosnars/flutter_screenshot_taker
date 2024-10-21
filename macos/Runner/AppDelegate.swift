import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApplication.shared.setActivationPolicy(.prohibited)
        
        let flutterProject = FlutterDartProject()
        let flutterEngine = FlutterEngine(name: "unique_engine_name925", project: flutterProject)
        flutterEngine.run(withEntrypoint: nil)
        
        RegisterGeneratedPlugins(registry: flutterEngine)

        let methodChannel = FlutterMethodChannel(
            name: "com.example.flutterMacosScreenshotTaker/screenshotTaker",
            binaryMessenger: flutterEngine.binaryMessenger)

        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "takeScreenshot" {
                ScreenshotManager.shared.screen_capturer()
                result("Success")
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        NSApplication.shared.windows.forEach { $0.close() }
        
        super.applicationDidFinishLaunching(aNotification)
    }

    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return false
    }
}

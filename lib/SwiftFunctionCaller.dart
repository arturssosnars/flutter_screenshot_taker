import 'package:flutter/services.dart';

class SwiftFunctionCaller {
  static const platform = MethodChannel('com.example.flutterMacosScreenshotTaker/screenshotTaker');

  Future<void> takeScreenshot() async {
    try {
      await platform.invokeMethod('takeScreenshot');
    } on PlatformException catch (e) {
      
      print("Failed to call Swift function: '${e.message}'.");
    }
  }
}
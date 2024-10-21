import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'dart:async';
import 'AppTrayListener.dart';
import 'SwiftFunctionCaller.dart';

Timer? _timer;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  doWhenWindowReady(() {
    appWindow.hide();
  });
  setupTray();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink(); // No UI needed
  }
}

void setupTray() {
  trayManager.setIcon('assets/tray_icon.png', isTemplate: true);

  Menu menu = Menu(
    items: [
      MenuItem(key: 'start', label: 'Start'),
      MenuItem(key: 'stop', label: 'Stop'),
      MenuItem.separator(),
      MenuItem(key: 'exit', label: 'Exit'),
    ],
  );

  trayManager.setContextMenu(menu);

  trayManager.addListener(AppTrayListener());
}

void startFunction() {
  _timer = Timer.periodic(Duration(minutes: 15), (Timer timer) {
    SwiftFunctionCaller().takeScreenshot();
  });
}

void stopFunction() {
  if (_timer != null) {
    _timer!.cancel();
    _timer = null;
  }
}
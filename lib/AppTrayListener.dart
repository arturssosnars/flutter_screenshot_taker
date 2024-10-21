import 'dart:io';
import 'package:tray_manager/tray_manager.dart';
import 'main.dart';

class AppTrayListener with TrayListener {
  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'start':
        startFunction();
      case 'stop':
        stopFunction();
      case 'exit':
        exit(0);
    }
  }
}
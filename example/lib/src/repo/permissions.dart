import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  // check bluetooth và vị trí
  Future<void> checkAndAskPermissions() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 31) {
        // location
        await Permission.locationWhenInUse.request();
        await Permission.locationAlways.request();
        // bluetooth
        await Permission.bluetooth.request();
      } else {
        // bluetooth for Android 12 and up
        await Permission.bluetoothScan.request();
        await Permission.bluetoothConnect.request();
      }
    } else {
      // bluetooth for iOS 13 and up
      await Permission.bluetooth.request();
    }
  }
}

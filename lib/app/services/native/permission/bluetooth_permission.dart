import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import 'native_permission_service.dart';

class BluetoothPermissionService extends PermissionService {
  @override
  Future<bool> isPermissionGranted() {
    return Permission.bluetooth.isGranted;
  }

  @override
  Future<bool> requestPermission() async {
    final status = await Permission.bluetooth.request();
    if (status.isGranted) {
      log("Bluetooth permission granted.");
      return true;
    } else {
      log("Bluetooth permission denied.");
      return false;
    }
  }

  @override
  Future<bool> checkAndRequestPermission() async {
    if (await Permission.bluetooth.isGranted) {
      log("Bluetooth permission already granted.");
      return true;
    }
    return await requestPermission();
  }
}

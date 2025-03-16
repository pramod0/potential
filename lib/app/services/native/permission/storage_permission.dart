import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

import '../../../utils//constants/strings.dart';
import 'native_permission_service.dart';

class FileStoragePermissionService extends PermissionService {
  @override
  Future<bool> isPermissionGranted() async {
    // Check if storage permission is granted on Android, or assume granted for iOS app-specific directories
    return await Permission.storage.isGranted;
  }

  @override
  Future<bool> requestPermission() async {
    // Request storage permission on Android
    final status = await Permission.storage.request();
    if (status.isGranted) {
      log(AppStrings.storagePermissionGranted);
      return true;
    } else {
      log(AppStrings.storagePermissionNotGranted);
      return false;
    }
  }

  @override
  Future<bool> checkAndRequestPermission() async {
    if (await Permission.storage.isGranted) {
      log("Storage permission already granted.");
      return true;
    }
    return await requestPermission();
  }
}

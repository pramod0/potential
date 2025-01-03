import 'dart:io';

import 'package:flutter/foundation.dart';

class NetWorkUtil {
  NetWorkUtil._sharedInstance();

  static final NetWorkUtil _shared = NetWorkUtil._sharedInstance();

  factory NetWorkUtil() => _shared;

  Future<bool> checkInternetConnection() async {
    bool internetConnection = false;
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty) {
        internetConnection = true;
      }
    } on SocketException catch (err) {
      if (kDebugMode) {
        // print(err);
      }
      internetConnection = false;
    }
    return internetConnection;
  }
}

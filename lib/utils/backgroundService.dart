import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

///
///
///
class BackgroundService {
  ///
  ///
  ///
  Future<void> initializeService() async {
    FlutterBackgroundService service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    await service.startService();
    service.on("stopService");
  }

  // to ensure this is executed
  // run app from xcode, then from xcode menu, select Simulate Background Fetch
  bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();
    print('FLUTTER BACKGROUND FETCH');

    return true;
  }

  ///
  ///
  ///
  static Future<void> onStart(ServiceInstance service) async {
    print('onStart is running');
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((Map<String, dynamic>? event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((Map<String, dynamic>? event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((Map<String, dynamic>? event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 60), (Timer timer) async {
      if (service is AndroidServiceInstance) {
        await service.setForegroundNotificationInfo(
          title: 'Potential Background Service',
          content: 'Updated at ${DateTime.now()}',
        );
      }

      /// you can see this log in logcat
      print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    });
  }
}

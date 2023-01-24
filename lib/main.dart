import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/screens/splash.dart';
import 'package:potential/utils/backgroundservice.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase
//       .initializeApp(); // options: DefaultFirebaseConfig.platformOptions
//   print('Handling a background message ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BackgroundService().initializeService();
  await Firebase.initializeApp();
  final User? user = FirebaseAuth.instance.currentUser;

  print(user?.uid);

  final fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    print(fcmToken);
  }).onError((err) {
    // Error getting token.
  });
  print(fcmToken);
  print(FirebaseAuth.instance.currentUser?.email);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      builder: EasyLoading.init(),
    );
  }
}

// #TODO Gitesh why was this added please comment
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

import 'dart:io';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
//import 'package:potential/screens/CheckConsent/NoConsent.dart';
//import 'package:potential/screens/CheckConsent/checkCanNO.dart';
import 'package:potential/screens/splash.dart';
import 'package:potential/utils/appTools.dart';

void main() async {
  await configLoading();
  runApp(const MyApp());
}

configLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..dismissOnTap = false
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: hexToColor(AppColors.loginBtnColor)),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
    );
  }
}

// Gitesh why was this added please comment
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

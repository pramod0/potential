import 'dart:io';

//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/screens/graph_page.dart';
import 'package:potential/screens/splash.dart';
import 'package:potential/utils/appTools.dart';
import 'package:provider/provider.dart';

void main() async {
  await configLoading();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => InvestmentDataProvider()),
  ], child: const MyApp()));
}

configLoading() async {
  // EasyLoading.init(builder: (context, child) {
  //   return const CircularProgressIndicator();
  // });
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.chasingDots
    ..indicatorSize = 20
    // ..progressWidth = 1
    ..loadingStyle = EasyLoadingStyle.light
    ..backgroundColor = hexToColor(AppColors.appThemeColor).withOpacity(0.10)
    ..indicatorColor = Colors.black87
    ..textColor = Colors.black54
    // ..progressColor = Colors.blue.withOpacity(0.5)
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..dismissOnTap = false
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(), //Splash
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

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:potential/app/utils/themes/input_decorations.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/screens/splash.dart';

import 'components/themes/text_themes.dart';

void main() async {
  await configLoading();

  runApp(const MyApp());
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
    ..backgroundColor = AppColors.appThemeColor.withOpacity(0.10)
    ..indicatorColor = Colors.black87
    ..textColor = Colors.black54
    // ..progressColor = Colors.blue.withOpacity(0.5)
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..dismissOnTap = false
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      ensureScreenSize: true,
      enableScaleText: () {
        return true;
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Splash(), //Splash
        theme: _buildMaterialTheme(),
        builder: EasyLoading.init(),
      ),
    );
  }

  // Build customizable Material theme
  ThemeData _buildMaterialTheme() {
    return ThemeData(
      primaryTextTheme: textTheme as TextTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.loginBtnColor,
        primary: AppColors.loginBtnColor,
        // secondary: secondaryColor,
        // background: AppColors.homeBG,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        // onBackground: AppColors.blackTextColor,
        onSurface: AppColors.blackTextColor,
        brightness: Brightness.light,
      ),
      inputDecorationTheme: inputDecorationTheme,
      useMaterial3: true, // Opt into Material 3 design if desired
    );
  }

// Build customizable Cupertino theme
  CupertinoThemeData _buildCupertinoTheme() {
    return CupertinoThemeData(
      textTheme: textTheme as CupertinoTextThemeData,
      brightness: Brightness.light,
      primaryColor: AppColors.loginBtnColor,
      primaryContrastingColor: AppColors.fieldColor,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemGrey6,
      // Customizable bar color
      applyThemeToAll: true,
    );
  }
}

// Gitesh why was this added please comment
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

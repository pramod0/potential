import 'dart:io';

import 'package:flutter/material.dart';
import 'package:potential/screens/dashboard.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
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

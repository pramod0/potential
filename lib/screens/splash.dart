import 'dart:async';
import 'package:potential/screens/CANcreationform/preRegistration.dart';

import '../app_assets_constants/AppColors.dart';
import '../app_assets_constants/AppImages.dart';
import '../app_assets_constants/AppStrings.dart';
import '../screens/login.dart';
import '../screens/CANcreationform/preLogin.dart';
import '../screens/CANcreationform/createAccount.dart';
import '../utils/appTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    Timer(const Duration(seconds: 2),
        () => Navigator.of(context).push(_createRoute()));
  }

  @override
  Widget build(BuildContext context) {
    // given transparent color to status bar

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      body: Container(
        color: hexToColor("#121212"),
        child: Stack(
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Image.asset(
            //     AppImages.splashTopDesign,
            //     width: MediaQuery.of(context).size.width,
            //     height: 150,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Image.asset(AppImages.agrawalNextLogo,
            //       width: 150, height: 150),
            // ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Image.asset(
            //     AppImages.splashBottomDesign,
            //     width: MediaQuery.of(context).size.width,
            //     height: 150,
            //     fit: BoxFit.cover,
            //   ),
            //),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.import_contacts_rounded,
                color: hexToColor("#237463"), //#237463
                size: 100,
                // width: MediaQuery.of(context).size.width,
                // height: 150,
                // fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const PreRegistrationPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}

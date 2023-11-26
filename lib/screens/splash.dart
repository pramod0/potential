import 'dart:async';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/screens/login.dart';
import 'package:potential/utils/styleConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/token.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:linear_timer/linear_timer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  //  final prefs = SharedPreferences.getInstance(); // stores user data and invested data
  late AnimationController controller;
  late Animation<double> animation;
  AllData allData = AllData();
  bool LoggedIn = false;

  isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null) {
      var expired = JwtDecoder.decode(token);
      if (expired.isNotEmpty) {
        String? token = pref.getString('token');
        Token(token!); // initialize token
        LoggedIn = true;
      } else {}
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    isLoggedIn();
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

    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // ));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
      body: Container(
        color: hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
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
              // child: Icon(
              //   Icons.import_contacts_rounded,
              //   color: hexToColor("#237463"), //#237463
              //   size: 100,
              //   // width: MediaQuery.of(context).size.width,
              //   // height: 150,
              //   // fit: BoxFit.cover,
              // ),
              child: Text(
                "14 takka",
                style: kGoogleStyleTexts.copyWith(
                    color: hexToColor(AppColors.loginBtnColor),
                    fontWeight: FontWeight.w800,
                    // textBaseline: TextBaseline.alphabetic,
                    fontSize: 35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   timerController1.dispose();
  //   timerController2.dispose();
  // }
}

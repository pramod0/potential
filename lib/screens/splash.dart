import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/models/biometric_auth_state.dart';
import 'package:potential/models/investments.dart';
import 'package:potential/screens/CheckConsent/check_can_no.dart';
import 'package:potential/screens/biometric/authPage.dart';
import 'package:potential/screens/dashboard.dart';
// import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/screens/login.dart';
import 'package:potential/utils/styleConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/investor.dart';
import '../models/token.dart';
import '../utils/AllData.dart';
import '../utils/networkUtil.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  //  final prefs = SharedPreferences.getInstance(); // stores user data and invested data
  late AnimationController controller;
  late Animation<double> animation;

  // AllData allData = AllData();
  bool LoggedIn = false;

  bool isVisible = false;

  showSnackBar(String text, Color color) async {
    var snackBar = SnackBar(
        content: Text(
      text,
      style: kGoogleStyleTexts.copyWith(color: color, fontSize: 15),
    ));
    // var banner = MaterialBanner(
    //     content: Text(
    //       "Error",
    //       style: kGoogleStyleTexts.copyWith(color: color, fontSize: 15),
    //     ),
    //     actions: [
    //       Text(
    //         text,
    //         style: kGoogleStyleTexts.copyWith(color: color, fontSize: 15),
    //       ),
    //     ]);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // ScaffoldMessenger.of(context).showMaterialBanner(banner);
  }

  Future<void> isLoggedIn() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      setState(() {
        isVisible = true;
      });
      // await showSnackBar("No Internet Connection", Colors.red);
      await Future.delayed(const Duration(seconds: 3))
          .whenComplete(() => SystemNavigator.pop(animated: true));
      setState(() {
        isVisible = false;
      });
      return;
    }
    EasyLoading.show(status: 'loading...');

    var t1 = DateTime.now();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token != null || token != "") {
      Map<String, dynamic> expired = {};
      try {
        expired = JwtDecoder.decode(token!);
      } catch (e) {
        await EasyLoading.dismiss();
        var t2 = DateTime.now();
        if (kDebugMode) {
          // print("T2-t1: ${t2.difference(t1)}");
        }
        Navigator.of(context).pushReplacement(_createRoute());
        return;
      }
      if (expired.isNotEmpty) {
        int h = DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(
                expired['exp'] * 1000,
                isUtc: true))
            .inHours;

        if (kDebugMode) {
          // print("Expiry TimeStamp ********* ${expired['exp']}, h: $h");
        }
        // var response;
        if (h < 0) {
          Token(token); // initialize token
          LoggedIn = true;
          await AllData.setInvestorData(
              User.fromJson(await jsonDecode(pref.getString('investorData')!)));
          // await EasyLoading.dismiss();
          await AllData.setInvestmentData(InvestedData.fromJson(
              await jsonDecode(pref.getString('investedData')!)));
        }
      }
    }
    // For checking time difference in preprocessing from api
    // var t2 = DateTime.now();
    // if (kDebugMode) {
    //   print("T2-t1: ${t2.difference(t1)}");
    // }
    // await BiometricDetails().loadSettings().then((val) {
    //   Navigator.of(context).pushReplacement(_createRoute());
    // });
    Navigator.of(context).pushReplacement(_createRoute());
    await EasyLoading.dismiss();
    return;
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    isLoggedIn();
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    // Timer(const Duration(seconds: 2),
    //     () => Navigator.of(context).pushReplacement(_createRoute()));
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
        color: AppColors.appThemeColor, //const Color("#121212"),
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
              //   color: const Color("#237463"), //#237463
              //   size: 100,
              //   // width: MediaQuery.of(context).size.width,
              //   // height: 150,
              //   // fit: BoxFit.cover,
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.volunteer_activism,
                  //   color: AppColors.loginBtnColor), //#237463
                  //   size: 100,
                  //   // width: MediaQuery.of(context).size.width,
                  //   // height: 150,
                  //   // fit: BoxFit.cover,
                  // ),
                  Image.asset(
                    AppImages.logo,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Text(
                    "14 takka",
                    style: kGoogleStyleTexts.copyWith(
                        color: AppColors.loginBtnColor,
                        fontWeight: FontWeight.w800,
                        // textBaseline: TextBaseline.alphabetic,
                        fontSize: 35),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              bottom: MediaQuery.of(context).size.height * 0.12,
              // left: MediaQuery.of(context).size.height * 0.061,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: isVisible ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    // height: 100,
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.blackTextColor.withOpacity(0.8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width * 20 / 896,
                        vertical: MediaQuery.of(context).size.height * 20 / 896,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppImages.noInternet,
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            "No Internet Connection\nTry Again after some time.",
                            textAlign: TextAlign.left,
                            style: kGoogleStyleTexts.copyWith(
                              fontFamily: "inter",
                              color: AppColors.whiteTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0 *
                                  (MediaQuery.of(context).size.width / 414),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => !LoggedIn
            ? const LoginPage()
            : (AllData.investedData.fundData.isEmpty
                ? const CheckCANNO()
                : BiometricDetails().biometricOn &&
                        (BiometricDetails().userConsentToBioMetric)
                    ? AuthPage()
                    : const Dashboard()),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

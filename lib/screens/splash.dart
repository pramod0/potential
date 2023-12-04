import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:potential/ApiService.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/models/investments.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:potential/screens/homeScreen.dart';

// import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/screens/login.dart';
import 'package:potential/utils/styleConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/investor.dart';
import '../models/token.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/networkUtil.dart';
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
  // AllData allData = AllData();
  bool LoggedIn = false;

  showSnackBar(String text, Color color) {
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
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }

    var t1 = DateTime.now();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    // if (kDebugMode) {
    //   print(token);
    // }
    if (token != null) {
      var expired = JwtDecoder.decode(token);
      // if (kDebugMode) {
      //   log("Expiry TimeStamp ********* ${expired['exp']}");
      // }
      if (expired.isNotEmpty) {
        int h = DateTime.now()
            .difference(DateTime.fromMillisecondsSinceEpoch(
                expired['exp'] * 1000,
                isUtc: true))
            .inHours;

        if (kDebugMode) {
          print("Expiry TimeStamp ********* ${expired['exp']}, h: $h");
        }
        // var response;
        if (h < 0) {
          Token(token); // initialize token
          LoggedIn = true;

          // try {
          //   response =
          //       await jsonDecode(await ApiService().dashboardAPI(token, 0, 0));
          // } catch (e) {
          //   await EasyLoading.dismiss();
          //   showSnackBar(e.toString(), Colors.red);
          // }
          AllData.setInvestorData(
              User.fromJson(await jsonDecode(pref.getString('investorData')!)));
          AllData.setInvestmentData(InvestedData.fromJson(
              await jsonDecode(pref.getString('investedData')!)));
          // if (response!['success']) {
          //   await EasyLoading.dismiss();
          //   LoggedIn = true;
          //   // if (kDebugMode) {
          //   //   // print("Ready${jsonDecode(pref.getString('investorData')!)}"); //
          //   // }
          //   InvestedData investedData = InvestedData.fromJson(response['data']);
          //   // await EasyLoading.dismiss();
          //   // if (kDebugMode) {
          //   //   print("responseBody.toString()");
          //   // }
          //   // if (kDebugMode) {
          //   //   print(investedData.toString());
          //   // }
          //
          //   pref.setString('investedData', jsonEncode(response['data']));
          //   // if (kDebugMode) {
          //   //   print(pref.get('investedData'));
          //   // }
          //   AllData.setInvestmentData(investedData);
          // AllData.schemeMap.clear();
          // AllData.printAll();
          await EasyLoading.dismiss();
        }
        await EasyLoading.dismiss();
      }
      await EasyLoading.dismiss();
    }
    await EasyLoading.dismiss();
    // For checking time difference in preprocessing from api
    var t2 = DateTime.now();
    if (kDebugMode) {
      print("T2-t1: ${t2.difference(t1)}");
    }
  }

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    isLoggedIn();
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();

    Timer(const Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(_createRoute()));
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.volunteer_activism,
                  //   color: hexToColor(AppColors.loginBtnColor), //#237463
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
                        color: hexToColor(AppColors.loginBtnColor),
                        fontWeight: FontWeight.w800,
                        // textBaseline: TextBaseline.alphabetic,
                        fontSize: 35),
                  ),
                ],
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
            !LoggedIn ? const LoginPage() : const Dashboard(),
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
    // TODO: implement dispose
    super.dispose();
  }
}

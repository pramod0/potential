import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/screens/CANcreationform/createAccount.dart';
import 'package:potential/screens/login.dart';
import 'package:potential/utils/appTools.dart';
import 'package:potential/utils/googleSignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../app_assets_constants/AppStrings.dart';
import '../utils/noGlowBehaviour.dart';
import '../utils/styleConstants.dart';
import '../utils/track.dart';
import 'CANcreationform/verifyMobileNo.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  final maxLines = 2;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final TextEditingController usernameController =
      TextEditingController(text: "pramodgupta0@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "pRamod@123");

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const ExitDialogue()) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: hexToColor("#121212"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Get Started,",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 35,
                                color: hexToColor("#ffffff"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    width: MediaQuery.of(context).size.width - 10,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: hexToColor("#0065A0"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CreateAccountPage(),
                            ),
                          );
                        },
                        child: Text(
                          AppStrings.signUptext,
                          style: kGoogleStyleTexts.copyWith(
                              color: Colors.white, fontSize: 18.0),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 55,
                  //   width: MediaQuery.of(context).size.width - 10,
                  //   child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           backgroundColor: hexToColor("#0065A0"),
                  //           shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8.0))),
                  //       onPressed: () {
                  //         signInWithGoogle(context);
                  //       },
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           Image.asset(
                  //             "assets/googleLogo.png",
                  //             height: 30,
                  //             width: 30,
                  //           ),
                  //           Text(
                  //             " ${AppStrings.signUpWithGoogle}",
                  //             style: kGoogleStyleTexts.copyWith(
                  //                 color: Colors.white, fontSize: 18.0),
                  //           ),
                  //         ],
                  //       )),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${AppStrings.alreadyRegText} ",
                            style: kGoogleStyleTexts.copyWith(
                                color: Colors.white, fontSize: 18.0),
                          ),
                          Text(
                            AppStrings.signInText,
                            style: kGoogleStyleTexts.copyWith(
                                color: Colors.white, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ExitDialogue extends StatelessWidget {
  const ExitDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: hexToColor("#101010"),
      title: Text(
        "Exit App",
        style: kGoogleStyleTexts.copyWith(color: Colors.white, fontSize: 18.0),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: 100,
            width: 200,
            child: Column(
              children: [
                Text(
                  "Are you sure you want to exit the app?",
                  style: kGoogleStyleTexts.copyWith(
                      color: Colors.white, fontSize: 15.0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                side: const BorderSide(
                                    width: 0.5, color: Colors.black26)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              "Cancel",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontSize: 15.0,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 90,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffC93131),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () async {
                              exit(0);
                            },
                            child: Text(
                              "Exit",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

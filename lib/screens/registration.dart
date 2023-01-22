import 'package:flutter/material.dart';
import 'package:potential/screens/CANcreationform/createAccount.dart';
import 'package:potential/screens/login.dart';
import 'package:potential/utils/appTools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_assets_constants/AppStrings.dart';
import '../models/cancreation.dart';
import '../utils/noGlowBehaviour.dart';
import '../utils/styleConstants.dart';

class RegistrationPage extends StatefulWidget {
  late final CANIndFillEezzReq fillEezzReq;
  RegistrationPage({Key? key, required this.fillEezzReq}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScrollConfiguration(
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
                            )),
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
                            builder: (context) => CreateAccountPage(
                                fillEezzReq: widget.fillEezzReq),
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
                            builder: (context) =>
                                LoginPage(fillEezzReq: widget.fillEezzReq),
                          ),
                        );
                      },
                      child: Text(
                        AppStrings.signInText,
                        style: kGoogleStyleTexts.copyWith(
                            color: Colors.white, fontSize: 18.0),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

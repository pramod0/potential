// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/appTools.dart';
import '../ApiService.dart';
import '../util/network_util.dart';
import '../util/styleConstants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  late String _username = "";
  late String _password = "";

  final TextEditingController userNameController =
  TextEditingController(text: "pramod77484@gmail.com"); // for quick testing
  final TextEditingController passwordController =
  TextEditingController(text: "root123");

  @override
  void initState() {
    super.initState();
    // isLoggedIn();
  }

  // void isLoggedIn() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? expiryDate = pref.getString('expiry');
  //   if (expiryDate != null) {
  //     int? expired = DateTime.tryParse(expiryDate)?.compareTo(DateTime.now());
  //     if (expired! > 0) {
  //       String? studentJson = pref.getString('investmentData');
  //       Investor investorData =Investor.fromJson(jsonDecode(studentJson!));
  //       String? token = pref.getString('token');
  //       //Token(token!); // initialize toke
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => const Dashboard(investorData: investorData,)));
  //     }
  //   }
  // }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  showSnackBar(String text, Color color) {
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const ExitDialogue()) ??
        false;
  }

  login() async {
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }
    if (kDebugMode) {
      print(_username + _password);
    }
    _formKey.currentState!.save();
    EasyLoading.show(status: 'loading...');

    final String userName = userNameController.text;
    final String password = passwordController.text;

    var responseBody = jsonDecode(
        await ApiService().processLogin(userName, password, context));
    EasyLoading.dismiss();
    if (responseBody?['status_code'] == 1000) {
      String s = json.encode(responseBody['investorData']);
      Investor i = Investor.fromJson(jsonDecode(s));
      //String token = responseBody['token'].toString();
      //Token(token); // initialize token
      prefs.then((pref) => pref.setString(
          'investorData', json.encode(responseBody['investorData'])));
      prefs.then((pref) =>
          pref.setString('userId', responseBody['user_id'].toString()));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Dashboard(
            investorData: i,
          ),
        ),
      );

      // prefs.then(
      //         (pref) => pref.setString('token', responseBody['token'].toString()));
      // prefs.then((pref) =>
      //     pref.setString('expiry', responseBody['expiry'].toString()));
    } else {
      var message = responseBody['message'] ?? "Failed to login";
      if (userName.isEmpty && password.isEmpty) {
        showSnackBar("Please enter username & password", Colors.red);
      } else if (userName.isEmpty) {
        showSnackBar("Username is required", Colors.red);
      } else if (password.isEmpty) {
        showSnackBar("Password is required", Colors.red);
      } else {
        showSnackBar(message, Colors.red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: hexToColor("#101010"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Align(
                              child: Text(
                                AppStrings.qoute,
                                textAlign: TextAlign.center,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: hexToColor(
                                      "#91fa78"), //newColor//Bright-green
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppStrings.loginNowText,
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 40,
                                color: hexToColor("#0091E6"),
                              ),
                            ),
                          ),
                          Text(
                            "Please Login with your credentials",
                            style: kGoogleStyleTexts.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: hexToColor("#0091E6"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.userName,
                      style: kGoogleStyleTexts.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: hexToColor("#0091E6"),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: userNameController,
                              onSaved: (val) => _username = val!,
                              keyboardType: TextInputType.emailAddress,
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor("#0065A0"), fontSize: 15.0),
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: hexToColor("#0065A0"),
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: hexToColor("#0065A0"))),
                                fillColor:
                                const Color.fromARGB(30, 173, 205, 219),
                                filled: true,
                                hintText: AppStrings.userEmailHintText,
                                hintStyle: kGoogleStyleTexts.copyWith(
                                    color: hexToColor("#5F93B1"),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppStrings.userPassword,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: hexToColor("#0091E6"),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.justify,
                            controller: passwordController,
                            onSaved: (val) => _password = val!,
                            keyboardType: TextInputType.text,
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor("#0065A0"), fontSize: 15.0),
                            maxLines: 1,
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: hexToColor("#0065A0"),
                                  width: 1.0,
                                ),
                              ),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  borderSide:
                                  BorderSide(color: hexToColor("#0065A0"))),
                              fillColor:
                              const Color.fromARGB(30, 173, 205, 219),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _toggleVisibility();
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: hexToColor("#0065A0"),
                                  size: 22,
                                ),
                              ),
                              filled: true,
                              hintText: AppStrings.userPasswordHintText,
                              hintStyle: kGoogleStyleTexts.copyWith(
                                  color: hexToColor("#5F93B1"),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: hexToColor("#0065A0"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: login,
                      child: Text(
                        AppStrings.loginButtonText,
                        style: kGoogleStyleTexts.copyWith(
                            color: Colors.white, fontSize: 18.0),
                      )),
                )
              ],
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

class AppStrings {
  static const String loginNowText = "Login";
  static const String userName = 'Username';
  static const String userPassword = 'Password';
  static const String loginButtonText = 'Login';
  static const String loginText = "Heading goes here";
  static const String userEmailHintText = "Eg. person0@email.com";
  static const String userPasswordHintText = "Eg. xyZab@23";
  static const String qoute =
      "When you catch a glimpse of your potential, that's when passion is born.";
}
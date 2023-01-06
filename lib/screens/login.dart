import 'dart:convert';

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

  late String _username;
  late String _password;

  final TextEditingController userNameController =
  TextEditingController(text: "HYS076"); // for quick testing
  final TextEditingController passwordController =
  TextEditingController(text: "gsh#RH3jA");

  late String _username;
  late String _password;

  @override
  void initState() {
    super.initState();
    isLoggedIn();
  }

  void isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? expiryDate = pref.getString('expiry');
    if (expiryDate != null) {
      int? expired = DateTime.tryParse(expiryDate)?.compareTo(DateTime.now());
      if (expired! > 0) {
        String? studentJson = pref.getString('student');
        Student.fromJson(jsonDecode(studentJson!));
        String? token = pref.getString('token');
        Token(token!); // initialize toke
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    }
  }

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
        builder: (context) => ExitDialogue()) ??
        false;
  }

  login() async {
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }

    _formKey.currentState!.save();
    EasyLoading.show(status: 'loading...');

    final String userName = userNameController.text;
    final String password = passwordController.text;

    var responseBody = jsonDecode(
        await ApiService().processLogin(userName, password, context));
    EasyLoading.dismiss();

    if (responseBody?['status_code'] == 1000) {

      String s = json.encode("../util/loginData.json");
      Investor.fromJson(jsonDecode(s));
      String token = responseBody['token'].toString();
      //Token(token); // initialize token

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Dashboard()));

      prefs.then((pref) =>
          pref.setString('student', json.encode(responseBody['student'])));
      prefs.then((pref) =>
          pref.setString('userId', responseBody['user_id'].toString()));
      prefs.then(
              (pref) => pref.setString('token', responseBody['token'].toString()));
      prefs.then((pref) =>
          pref.setString('expiry', responseBody['expiry'].toString()));
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Card(
                              color: Color.fromARGB(30, 173, 205, 219),
                              child: Text(
                                AppStrings.loginNowText,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                  color: hexToColor("#0091E6"),
                                ),
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
                                  color: hexToColor("#0065A0"),
                                  fontSize: 15.0),
                              maxLines: 1,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15),
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
                                  borderSide: BorderSide(
                                      color: hexToColor("#0065A0"))),
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

class AppStrings {
  static const String loginNowText = "SignIn";
  static const String userName = 'Username';
  static const String userPassword = 'Password';
  static const String loginButtonText = 'Login';
  static const String loginText = "Heading goes here";
  static const String userEmailHintText = "Eg. person0@email.com";
  static const String userPasswordHintText = "Eg. xyZab@23";
}

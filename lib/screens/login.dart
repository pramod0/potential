import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/utils/AllData.dart';
import 'package:potential/screens/dashboard.dart';
// import 'package:potential/screens/tabspage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/cancreation.dart';
import '../models/token.dart';
import '../utils/appTools.dart';
import '../app_assets_constants/AppStrings.dart';
import '../ApiService.dart';
// import '../utils/googleSignIn.dart';
import '../utils/networkUtil.dart';
import '../utils/noGlowBehaviour.dart';
import '../utils/styleConstants.dart';
import 'CANcreationform/createAccount.dart';
import 'CheckConsent/checkCanNO.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // late String _username = "";
  // late String _password = "";

  final TextEditingController usernameController =
      TextEditingController(text: ""); // for quick testing
  final TextEditingController passwordController =
      TextEditingController(text: "");

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

  // TODO This method is too big : Pramod
  login() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }

    _formKey.currentState!.save();
    EasyLoading.show(status: 'loading...');

    try {
      final String userName = usernameController.text;
      final String password = passwordController.text;
      if (userName.isEmpty || password.isEmpty) {
        showSnackBar("Username or Password cannot be empty.", Colors.red);
        await EasyLoading.dismiss();
        return;
      }
      var responseBody =
          jsonDecode(await ApiService().processLogin(userName, password));
      //await EasyLoading.dismiss();

      if (responseBody['success'] == true) {
        String token = responseBody['data']['access_token'].toString();

        Token(token); // initialize token
        var prefs = SharedPreferences.getInstance();

        prefs.then((pref) => pref.setString('token', token));
        User investorData = User.fromJson(responseBody['data']['userData']);

        prefs.then((pref) => pref.setString(
            'investorData', jsonEncode(responseBody['data']['userData'])));
        AllData.setInvestorData(investorData);

        await EasyLoading.dismiss();

        // Check for CAN
        if (responseBody['data']['can'] == 'No') {
          await EasyLoading
              .dismiss(); // isn't EasyLoading been dismissed already?
          if (!context.mounted) return;
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CheckCANNO()));

          return;
        }

        TextInput.finishAutofillContext();
        usernameController.text = "";
        passwordController.text = "";
        if (!context.mounted) {
          return; // it resolves error of using context across async functions
        }
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        await EasyLoading.dismiss();
        if (kDebugMode) {
          print(responseBody);
        }
        if (responseBody['message'] != null) {
          if (responseBody['message'] == "incorrect PASSWORD") {
            await showSnackBar("Incorrect password", Colors.red);
          }
          await showSnackBar(responseBody['message'], Colors.red);
        } else {
          await showSnackBar(responseBody['data'], Colors.red);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception occurred during login: $e");
      }
      showSnackBar(e.toString(), Colors.red);
      await EasyLoading.dismiss();
    }
  }

  _onBackPressed() async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        if (canPop) {
          return;
        }
        await _onBackPressed();
      },
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor:
              hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppStrings.loginNowText,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                  color: hexToColor(AppColors
                                      .blackTextColor), //hexToColor("#ffffff"),
                                ),
                              ),
                            ),
                            Text(
                              "Please Login with your credentials",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: hexToColor(AppColors
                                    .blackTextColor), //hexToColor("#ffffff"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppStrings.userName,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: hexToColor(AppColors
                                          .blackTextColor) //hexToColor("#ffffff"),
                                      ),
                                )),
                          ),
                          SizedBox(
                            height: maxLines * 25.0,
                            child: TextFormField(
                                onTap: () {
                                  TextInput.finishAutofillContext();
                                },
                                autofillHints: const [
                                  AutofillHints.newUsername
                                ],
                                textInputAction: TextInputAction.next,
                                controller: usernameController,
                                onSaved: (val) =>
                                    usernameController.text = val!,
                                keyboardType: TextInputType.text,
                                style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: hexToColor(AppColors
                                        .blackTextColor), //hexToColor("#ffffff"),
                                    fontSize: 15.0),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: hexToColor(
                                          AppColors.noFocusBorderColor),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor(
                                              AppColors.hintTextColor))),
                                  fillColor:
                                      const Color.fromARGB(30, 173, 205, 219),
                                  filled: true,
                                  hintText: AppStrings.emailHintText,
                                  hintStyle: kGoogleStyleTexts.copyWith(
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                      //hexToColor("#ffffff"),
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
                                      color: hexToColor(AppColors
                                          .blackTextColor) //hexToColor("#ffffff"),
                                      ),
                                )),
                          ),
                          SizedBox(
                            height: maxLines * 25.0,
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.justify,
                              controller: passwordController,
                              onSaved: (val) => passwordController.text = val!,
                              keyboardType: TextInputType.text,
                              style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor(AppColors
                                      .blackTextColor), //hexToColor("#ffffff"),
                                  fontSize: 15.0),
                              autofillHints: const [AutofillHints.password],
                              maxLines: 1,
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: hexToColor(
                                        AppColors.noFocusBorderColor),
                                    width: 1.0,
                                  ),
                                ),
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                    )),
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
                                    color: hexToColor(AppColors.blackTextColor),
                                    //hexToColor(AppColors.whiteBorderColor),
                                    size: 22,
                                  ),
                                ),
                                filled: true,
                                hintText: AppStrings.passwordHintText,
                                hintStyle: kGoogleStyleTexts.copyWith(
                                    color: hexToColor(AppColors.hintTextColor),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  hexToColor(AppColors.loginBtnColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: login,
                          child: Text(
                            AppStrings.loginButtonText,
                            style: kGoogleStyleTexts.copyWith(
                                color: Colors.white, fontSize: 18.0),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CreateAccountPage(),
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
                            "${AppStrings.notSignedIn} ",
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor(AppColors.blackTextColor),
                                fontSize: 18.0),
                          ),
                          Text(
                            AppStrings.signUpText,
                            style: kGoogleStyleTexts.copyWith(
                                color: Colors.blueAccent, fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Theme(
                  //   data: ThemeData(
                  //     splashColor: Colors.transparent,
                  //     highlightColor: Colors.transparent,
                  //   ),
                  //   child: TextButton(
                  //     onPressed: () => {signInWithGoogle(context)},
                  //     child: Text(
                  //       AppStrings.signInWithGoogleText,
                  //       style: kGoogleStyleTexts.copyWith(
                  //           color: Colors.white, fontSize: 18.0),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

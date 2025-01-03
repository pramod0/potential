import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
//import 'package:potential/screens/CheckConsent/consent_no_data.dart';
import 'package:potential/screens/dashboard.dart';
import 'package:potential/screens/forgot_password.dart';
import 'package:potential/utils/AllData.dart';
// import 'package:potential/screens/tabspage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../app_assets_constants/app_strings.dart';
import '../models/token.dart';
import '../utils/networkUtil.dart';
import '../utils/noGlowBehaviour.dart';
import '../utils/styleConstants.dart';
import 'CANcreationform/create_account.dart';
import 'CheckConsent/check_can_no.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

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

  final TextEditingController usernameController = TextEditingController(
      text: "shubhamdathia7257@gmail.com"); // for quick testing
  final TextEditingController passwordController =
      TextEditingController(text: "1234@Skd");

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
          usernameController.text = "";
          passwordController.text = "";
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
          // print(responseBody);
        }
        if (responseBody['message'] != null) {
          if (responseBody['message'] == "Incorrect Credentials !!") {
            await showSnackBar("Incorrect password", Colors.red);
            return;
          }
          await showSnackBar(responseBody['message'], Colors.red);
        } else {
          await showSnackBar(responseBody['data'], Colors.red);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        // print("Exception occurred during login: $e");
      }
      // #TODO make below string constant
      showSnackBar("Server is currently unavailable. Please try again later.",
          AppColors.red);
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
          backgroundColor: AppColors.appThemeColor, //"#121212"),
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
                                AppStrings.loginNow,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40,
                                  color: AppColors.blackTextColor, //"#ffffff"),
                                ),
                              ),
                            ),
                            Text(
                              "Please Login with your credentials",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.blackTextColor, //"#ffffff"),
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
                      child: AutofillGroup(
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
                                    AppStrings.email,
                                    style: kGoogleStyleTexts.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColors
                                            .blackTextColor //"#ffffff"),
                                        ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                  // onTap: () {
                                  //   TextInput.finishAutofillContext();
                                  // },
                                  autofillHints: const [AutofillHints.username],
                                  textInputAction: TextInputAction.next,
                                  controller: usernameController,
                                  onSaved: (val) =>
                                      usernameController.text = val!,
                                  keyboardType: TextInputType.text,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.blackTextColor,
                                      //"#ffffff"),
                                      fontSize: 15.0),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: AppColors.noFocusBorderColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                        borderSide: BorderSide(
                                            color: AppColors.hintTextColor)),
                                    fillColor:
                                        const Color.fromARGB(30, 173, 205, 219),
                                    filled: true,
                                    hintText: AppStrings.emailHint,
                                    hintStyle: kGoogleStyleTexts.copyWith(
                                        color: AppColors.hintTextColor,
                                        //"#ffffff"),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        AppStrings.password,
                                        style: kGoogleStyleTexts.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: AppColors
                                                .blackTextColor //"#ffffff"),
                                            ),
                                      )),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        usernameController.text = "";
                                        passwordController.text = "";
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordScreen(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Forgot Password?",
                                        // textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                                color:
                                                    AppColors.loginBtnColor2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.justify,
                                controller: passwordController,
                                onSaved: (val) =>
                                    passwordController.text = val!,
                                keyboardType: TextInputType.text,
                                style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackTextColor,
                                    //"#ffffff"),
                                    fontSize: 15.0),
                                autofillHints: const [AutofillHints.password],
                                maxLines: 1,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: AppColors.noFocusBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                      borderSide: BorderSide(
                                        color: AppColors.blackTextColor,
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
                                      color: AppColors.blackTextColor,
                                      //AppColors.whiteBorderColor),
                                      size: 22,
                                    ),
                                  ),
                                  filled: true,
                                  hintText: AppStrings.passwordHint,
                                  hintStyle: kGoogleStyleTexts.copyWith(
                                      color: AppColors.hintTextColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.loginBtnColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: login,
                          child: Text(
                            AppStrings.login,
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
                      usernameController.text = "";
                      passwordController.text = "";
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
                            "${AppStrings.doNotHaveAc} ",
                            style: kGoogleStyleTexts.copyWith(
                                color: AppColors.blackTextColor,
                                fontSize: 18.0),
                          ),
                          Text(
                            AppStrings.signUp,
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

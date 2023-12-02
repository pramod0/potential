import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/screens/homeScreen.dart';
// import 'package:potential/screens/CANcreationform/verifyMobileNo.dart';
// import 'package:potential/screens/CheckConsent/NoConsent.dart';
// import 'package:potential/screens/CheckConsent/checkCanNO.dart';
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
import '../utils/exit_dialogue.dart';
import '../utils/networkUtil.dart';
import '../utils/noGlowBehaviour.dart';
import '../utils/styleConstants.dart';
// import '../utils/track.dart';
import 'CANcreationform/createAccount.dart';

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

  login() async {
    print(MediaQuery.of(context).size.width);

    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }
    if (kDebugMode) {
      print(usernameController.text + passwordController.text);
    }
    _formKey.currentState!.save();
    EasyLoading.show(status: 'loading...');
    var responseBody;
    try {
      final String userName = usernameController.text;
      final String password = passwordController.text;
      if (userName == "" || password == "") {
        showSnackBar("Please Check the Values", hexToColor("#ffffff"));
        await EasyLoading.dismiss();
        Exception();
        return;
      }
      responseBody =
          jsonDecode(await ApiService().processLogin(userName, password));
      //await EasyLoading.dismiss();

      if (responseBody['success'] == true) {
// var s = json.encode(responseBody['data']);
        // if (kDebugMode) {
        //   print(s);
        // }
        // AllData.investorData = Investor.fromJson(jsonDecode(s));
        String token = responseBody['data']['access_token'].toString();

        Token(token); // initialize token
        var prefs = SharedPreferences.getInstance();

        prefs.then((pref) => pref.setString('token', token));
        // print("token: $token\nuserData: ${responseBody['data']['userData']}");
        User investorData = User.fromJson(responseBody['data']['userData']);

        prefs.then((pref) => pref.setString(
            'investorData', jsonEncode(responseBody['data']['userData'])));
        AllData.setInvestorData(investorData);
        // if (kDebugMode) {
        //   print(investorData.firstName);
        // }
        await EasyLoading.dismiss();
        if (responseBody['data']['can'] == 'No') {
          await EasyLoading.dismiss();
          showSnackBar("Cannot proceed!!! No Transactions", Colors.red);
          return;
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //       builder: (context) => TakeConsentPage(
          //           can: responseBody['data']['can'],
          //           pan: responseBody['data']['userData']['panCard'])),
          // );
        }
        //if consent but no data
        //todo: implement route
        // responseBody =
        //     jsonDecode(await ApiService().dashboardAPI(token, 10, 0));
        // if (kDebugMode) {
        //   print(responseBody.toString());
        // }
        // InvestedData investedData = InvestedData.fromJson(responseBody['data']);
        // if (kDebugMode) {
        //   print("responseBody.toString()");
        // }
        // if (kDebugMode) {
        //   print(investedData.invested);
        // }
        // prefs.then((pref) =>
        //     pref.setString('investedData', responseBody['data'].toString()));
        //
        // AllData.setInvestmentData(investedData);
        TextInput.finishAutofillContext();
        usernameController.text = "";
        passwordController.text = "";
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HomeScreen()
              //     TabsPage(
              //   selectedIndex: 0,
              // ),
              ),
        );

        // prefs.then((pref) =>
        //     pref.setString('userId', responseBody['user_id'].toString()));
        //Track.isMobileNoVerified = true;

        // await auth.setPersistence(Persistence.LOCAL);

        // Track.isMobileNoVerified
        //     ? Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => TabsPage(
        //             selectedIndex: 1,
        //           ),
        //         ),
        //       )
        //     : Navigator.of(context).push(
        //         MaterialPageRoute(
        //           builder: (context) => VerifyMobileNum(),
        //         ),
        //       );

        // prefs.then((pref) =>
        //     pref.setString('expiry', responseBody['expiry'].toString()));
      } else {
        print("here");
        await EasyLoading.dismiss();

        var message = responseBody['messsage'] + "!!!" ?? "Failed to login";
        print(responseBody['messsage']);
        if (userName.isEmpty && password.isEmpty) {
          showSnackBar("Please enter username & password", Colors.red);
        } else if (userName.isEmpty) {
          showSnackBar("Username is required", Colors.red);
        } else if (password.isEmpty) {
          showSnackBar("Password is required", Colors.red);
        } else {
          await showSnackBar(message, Colors.red);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showSnackBar(e.toString(), Colors.red);
      await EasyLoading.dismiss();
    }
  }

  Future<bool> _onBackPressed() async {
    return exit(0);
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

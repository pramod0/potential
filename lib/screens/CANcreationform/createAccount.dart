import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/ApiService.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
//import 'package:potential/screens/CANcreationform/verifyMobileNo.dart';
import 'package:potential/utils/appTools.dart';
import 'package:potential/utils/noGlowBehaviour.dart';
import 'package:potential/utils/track.dart';
import 'package:potential/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_assets_constants/app_strings.dart';
//import '../../models/cancreation.dart';

//import '../../utils/AllData.dart';
// import '../../utils/exit_dialogue.dart';
import '../../utils/networkUtil.dart';
import '../../utils/styleConstants.dart';
import '../login.dart';
//import '../tabspage.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  Validations validations = Validations();
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  bool _showPassword2 = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  // final _auth = FirebaseAuth.instance;

  ValueNotifier<bool> isLoading = ValueNotifier(false);
  final TextEditingController firstNameController =
      TextEditingController(text: ""); // for quick testing
  final TextEditingController lastNameController =
      TextEditingController(text: ""); // for quick testing
  final TextEditingController emailIDController =
      TextEditingController(text: ""); // for quick testing
  final TextEditingController mobileNOController =
      TextEditingController(text: ""); // for quick testing
  final TextEditingController passwordController =
      TextEditingController(text: "");
  final TextEditingController confirmPasswordController =
      TextEditingController(text: "");
  final TextEditingController panCardController =
      TextEditingController(text: "");

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleVisibility2() {
    setState(() {
      _showPassword2 = !_showPassword2;
    });
  }

  showSnackBar(String text, Color color) {
    var snackBar = SnackBar(content: Text(text));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  register() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(
      status: "please wait...",
      dismissOnTap: false,
    );
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return;
    }
    try {
      String? check = validations.accountValidation(
          firstNameController.text,
          lastNameController.text,
          mobileNOController.text,
          emailIDController.text,
          passwordController.text,
          confirmPasswordController.text,
          panCardController.text);
      setState(() {
        _showPassword = _showPassword2 = false;
      });
      if (check != null) {
        // if (kDebugMode) {
        //   print("hii$check");
        // }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(check)),
        );
        isLoading.value = false;
        await EasyLoading.dismiss();
        return;
      }

      var payload = jsonEncode(<String, String>{
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phoneNumber': mobileNOController.text,
        'email': emailIDController.text,
        'password': passwordController.text,
        'confirmpassword': confirmPasswordController.text,
        'userRole': "user",
        'panCard': panCardController.text,
      });

      var responseBody = jsonDecode(await ApiService().signUp(payload));
      if (responseBody['success'] == true) {
        showSnackBar(responseBody['data'], Colors.black);
        Track.isRegistered = true;
        prefs.then((pref) => pref.setBool('isRegistered', true));

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
        await EasyLoading.dismiss();
      }
      await EasyLoading.dismiss();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Unable to process sign-up at the moment"),
      ));
      await EasyLoading.dismiss();
    } finally {
      setState(() {
        // passwordController.text = "";
      });
      await EasyLoading.dismiss();
    }
  }

  // Future<bool> _onBackPressed() async {
  //   return await showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) => const ExitDialogue()) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScrollConfiguration(
      behavior: NoGlowBehaviour(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor:
              hexToColor(AppColors.appThemeColorAppBar), //hexToColor("#161616")
          title: Text(
            "Create your account",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: hexToColor(AppColors.blackTextColor),
            ),
          ),
          iconTheme: IconThemeData(
            color: hexToColor(AppColors.blackTextColor),
          ),
        ),
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.fname,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: hexToColor(AppColors
                                          .blackTextColor), //hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: firstNameController,
                                  onSaved: (val) =>
                                      firstNameController.text = val!,
                                  keyboardType: TextInputType.name,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      //hexToColor(AppColors.blackTextColor),
                                      fontSize: 15.0),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: hexToColor(AppColors.formBorder),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: hexToColor(
                                                AppColors.hintTextColor))),
                                    fillColor:
                                        const Color.fromARGB(30, 173, 205, 219),
                                    filled: true,
                                    hintText: AppStrings.firstNameHintText,
                                    hintStyle: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.hintTextColor),
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
                                    AppStrings.lname,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: lastNameController,
                                onSaved: (val) =>
                                    lastNameController.text = val!,
                                keyboardType: TextInputType.name,
                                style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: hexToColor(AppColors.blackTextColor),
                                    fontSize: 15.0),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: hexToColor(AppColors.formBorder),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor(
                                              AppColors.hintTextColor))),
                                  fillColor:
                                      const Color.fromARGB(30, 173, 205, 219),
                                  filled: true,
                                  hintText: AppStrings.lastNameHintText,
                                  hintStyle: kGoogleStyleTexts.copyWith(
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.emailID,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: emailIDController,
                                  onSaved: (val) =>
                                      emailIDController.text = val!,
                                  keyboardType: TextInputType.emailAddress,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      fontSize: 15.0),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: hexToColor(AppColors.formBorder),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
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
                                    AppStrings.mobileNO,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: mobileNOController,
                                  onSaved: (val) =>
                                      mobileNOController.text = val!,
                                  keyboardType: TextInputType.number,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      fontSize: 15.0),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: hexToColor(AppColors.formBorder),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: hexToColor(
                                                AppColors.hintTextColor))),
                                    fillColor:
                                        const Color.fromARGB(30, 173, 205, 219),
                                    filled: true,
                                    hintText: AppStrings.mobileNO,
                                    hintStyle: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.hintTextColor),
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
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
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
                                    color: hexToColor(AppColors.blackTextColor),
                                    fontSize: 15.0),
                                maxLines: 1,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: hexToColor(AppColors.formBorder),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor(
                                              AppColors.hintTextColor))),
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
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      size: 22,
                                    ),
                                  ),
                                  filled: true,
                                  hintText: AppStrings.passwordHintText,
                                  hintStyle: kGoogleStyleTexts.copyWith(
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.confirmPassword,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.justify,
                                controller: confirmPasswordController,
                                onSaved: (val) =>
                                    confirmPasswordController.text = val!,
                                keyboardType: TextInputType.text,
                                style: kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: hexToColor(AppColors.blackTextColor),
                                    fontSize: 15.0),
                                maxLines: 1,
                                obscureText: !_showPassword2,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: hexToColor(AppColors.formBorder),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor(
                                              AppColors.hintTextColor))),
                                  fillColor:
                                      const Color.fromARGB(30, 173, 205, 219),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _toggleVisibility2();
                                    },
                                    child: Icon(
                                      _showPassword2
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      size: 22,
                                    ),
                                  ),
                                  filled: true,
                                  hintText: AppStrings.passwordHintText,
                                  hintStyle: kGoogleStyleTexts.copyWith(
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.panCard,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color:
                                          hexToColor(AppColors.hintTextColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: maxLines * 25.0,
                              child: TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: panCardController,
                                  onSaved: (val) =>
                                      panCardController.text = val!,
                                  style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color:
                                          hexToColor(AppColors.blackTextColor),
                                      fontSize: 15.0),
                                  maxLines: 1,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    UpperCaseTextFormatter()
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: hexToColor(AppColors.formBorder),
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: hexToColor(
                                                AppColors.hintTextColor))),
                                    fillColor:
                                        const Color.fromARGB(30, 173, 205, 219),
                                    filled: true,
                                    hintText: AppStrings.panCardHintText,
                                    hintStyle: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.hintTextColor),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  )),
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
                              backgroundColor:
                                  hexToColor(AppColors.loginBtnColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onPressed: register,
                          child: Text(
                            AppStrings.signUpText,
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor(AppColors.whiteTextColor),
                                fontSize: 18.0),
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print(oldValue.text);
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

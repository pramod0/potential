import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/ApiService.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/utils/appTools.dart';
import 'package:potential/utils/noGlowBehaviour.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_assets_constants/app_strings.dart';
import '../../utils/networkUtil.dart';
import '../../utils/styleConstants.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  bool _showPAN = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

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
  final TextEditingController confirmPANCardController =
      TextEditingController(text: "");

  EdgeInsets labelPadding =
      const EdgeInsets.only(bottom: 10.0, left: 15.0, right: 12.0);

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleVisibility2() {
    setState(() {
      _showPAN = !_showPAN;
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
    if (!_showPassword || !_showPAN) {
      setState(() {
        _showPassword = _showPAN = false;
      });
    }
    try {
      if (_formKey.currentState!.validate()) {
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
        if (responseBody != null) {
          if (responseBody['success'] == true) {
            showSnackBar(responseBody['data'], Colors.black);
            prefs.then((pref) => pref.setBool('isRegistered', true));
            Navigator.of(context).pop();
            await EasyLoading.dismiss();
          } else {
            // print(responseBody);
            showSnackBar(responseBody, Colors.black);
          }
        }
      }
      await EasyLoading.dismiss();
    } catch (e) {
      if (kDebugMode) {
        // print(e);
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
          backgroundColor: AppColors.appThemeColorAppBar, //"#161616")
          title: Text(
            "Create your account",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.blackTextColor,
            ),
          ),
          iconTheme: const IconThemeData(
            color: AppColors.blackTextColor,
          ),
        ),
        backgroundColor: AppColors.appThemeColor,
        body: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: labelPadding,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppStrings.firstName,
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: AppColors.blackTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: NormalTextFormField(
                                          fieldValidator: (value) {
                                            if (value!.isEmpty) {
                                              return AppStrings
                                                  .firstNameRequired;
                                            }
                                            return null;
                                          },
                                          mainController: firstNameController,
                                          hintText: AppStrings.firstNameHint,
                                          textInputType: TextInputType.name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: labelPadding,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppStrings.lastName,
                                            style: kGoogleStyleTexts.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: AppColors.hintTextColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: NormalTextFormField(
                                          fieldValidator: (value) {
                                            if (value!.isEmpty) {
                                              return AppStrings
                                                  .lastNameRequired;
                                            }
                                            return null;
                                          },
                                          mainController: lastNameController,
                                          hintText: AppStrings.lastNameHint,
                                          textInputType: TextInputType.name,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //EmailID
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.email,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),
                            NormalTextFormField(
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.emailRequired;
                                }
                                if (!emailRegex.hasMatch(value.toString())) {
                                  return AppStrings.validEmailError;
                                }
                                return null;
                              },
                              mainController: emailIDController,
                              hintText: AppStrings.emailHint,
                              textInputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //MobileNumber
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.mobileNumber,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),
                            NormalTextFormField(
                              //TODO : Convert to Number
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.mobileNumberRequired;
                                }
                                if (value.length < 10 ||
                                    value.length > 10 ||
                                    !mobileRegex.hasMatch(value)) {
                                  return AppStrings.invalidMobile;
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              mainController: mobileNOController,
                              hintText: AppStrings.mobileNumberHint,
                              textInputType: TextInputType.phone,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //Password
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.password,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),
                            ObscuredTextFormField(
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.passwordRequired;
                                }
                                if (value.length < 8) {
                                  return AppStrings.passwordLength8Error;
                                }
                                if (value.length > 16) {
                                  return AppStrings.passwordLength16Error;
                                }
                                return null;
                              },
                              showData: _showPassword,
                              suffixWidget: GestureDetector(
                                onTap: () {
                                  _toggleVisibility();
                                },
                                child: Icon(
                                  _showPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.blackTextColor,
                                  size: 22,
                                ),
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                UpperCaseTextFormatter()
                              ],
                              mainController: passwordController,
                              hintText: AppStrings.passwordHint,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //ConfirmPassword
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.confirmPassword,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),
                            NormalTextFormField(
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.passwordRequired;
                                }
                                if (value.length < 8) {
                                  return AppStrings.passwordLength8Error;
                                }
                                if (value.length > 16) {
                                  return AppStrings.passwordLength16Error;
                                }
                                if (passwordController.text != value) {
                                  return AppStrings.confirmPasswordMismatch;
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                UpperCaseTextFormatter()
                              ],
                              mainController: confirmPasswordController,
                              hintText: AppStrings.passwordHint,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //Pancard
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.panCard,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),

                            ObscuredTextFormField(
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.panCardRequired;
                                }
                                if (!panRegex.hasMatch(value)) {
                                  return AppStrings.invalidPAN;
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                UpperCaseTextFormatter()
                              ],
                              showData: _showPAN,
                              suffixWidget: GestureDetector(
                                onTap: () {
                                  _toggleVisibility2();
                                },
                                child: Icon(
                                  _showPAN
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.blackTextColor,
                                  size: 22,
                                ),
                              ),
                              mainController: panCardController,
                              hintText: AppStrings.panCardHint,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //Confirm Pan card
                            Padding(
                              padding: labelPadding,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    AppStrings.confirmPANCard,
                                    style: kGoogleStyleTexts.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.hintTextColor,
                                    ),
                                  )),
                            ),
                            NormalTextFormField(
                              fieldValidator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.panCardRequired;
                                }
                                if (!panRegex.hasMatch(value)) {
                                  return AppStrings.invalidPAN;
                                }
                                if (panCardController.text != value) {
                                  return AppStrings.confirmPasswordMismatch;
                                }
                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                UpperCaseTextFormatter()
                              ],
                              mainController: confirmPANCardController,
                              hintText: AppStrings.panCardHint,
                              textInputType: TextInputType.text
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
                              backgroundColor: AppColors.loginBtnColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                          onPressed: register,
                          child: Text(
                            AppStrings.signUp,
                            style: kGoogleStyleTexts.copyWith(
                                color: AppColors.whiteTextColor,
                                fontSize: 18.0),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width - 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${AppStrings.alreadyHaveAc} ",
                              style: kGoogleStyleTexts.copyWith(
                                  color: AppColors.blackTextColor,
                                  fontSize: 18.0),
                            ),
                            Text(
                              AppStrings.signIn,
                              style: kGoogleStyleTexts.copyWith(
                                  color: Colors.blueAccent, fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField({
    super.key,
    this.fieldValidator,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    required this.hintText,
    required this.mainController,
  });

  final TextEditingController mainController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String hintText;
  final fieldValidator;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: mainController,
      onSaved: (val) => mainController.text = val!,
      style: kGoogleStyleTexts.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.blackTextColor,
        fontSize: 15.0,
      ),
      maxLines: 1,
      validator: fieldValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.redAccent,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.hintTextColor,
            width: 2.0,
          ),
        ),
        fillColor: const Color.fromARGB(30, 173, 205, 219),
        filled: true,
        hintText: hintText,
        hintStyle: kGoogleStyleTexts.copyWith(
            color: AppColors.hintTextColor,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class ObscuredTextFormField extends StatelessWidget {
  const ObscuredTextFormField({
    super.key,
    this.fieldValidator,
    this.inputFormatters,
    this.showData,
    this.suffixWidget,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.visiblePassword,
    required this.hintText,
    required this.mainController,
  });

  final TextEditingController mainController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String hintText;
  final showData;
  final suffixWidget;
  final fieldValidator;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: mainController,
      onSaved: (val) => mainController.text = val!,
      style: kGoogleStyleTexts.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.blackTextColor,
        fontSize: 15.0,
      ),
      maxLines: 1,
      validator: fieldValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      obscureText: !showData,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.redAccent,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.hintTextColor,
            width: 2.0,
          ),
        ),
        fillColor: const Color.fromARGB(30, 173, 205, 219),
        filled: true,
        hintText: hintText,
        hintStyle: kGoogleStyleTexts.copyWith(
            color: AppColors.hintTextColor,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // print(oldValue.text);
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

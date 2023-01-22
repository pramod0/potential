import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/utils/appTools.dart';
import 'package:potential/utils/noGlowBehaviour.dart';
import 'package:potential/utils/track.dart';
import 'package:potential/utils/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_assets_constants/AppStrings.dart';
import '../../models/cancreation.dart';

import '../../utils/styleConstants.dart';
import '../login.dart';

class CreateAccountPage extends StatefulWidget {
  late CANIndFillEezzReq fillEezzReq;
  CreateAccountPage({Key? key, required this.fillEezzReq}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  Validations validations = Validations();
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final TextEditingController firstNameController =
      TextEditingController(text: "Pramod"); // for quick testing
  final TextEditingController lastNameController =
      TextEditingController(text: "Gupta"); // for quick testing
  final TextEditingController emailIDController = TextEditingController(
      text: "pramodgupta0@gmail.com"); // for quick testing
  final TextEditingController mobileNOController =
      TextEditingController(text: "8363462346"); // for quick testing
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
        appBar: AppBar(
          backgroundColor: Colors.transparent, //hexToColor("#161616")
          title: Text(
            "Create your account",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: hexToColor("#ffffff"),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: hexToColor("#121212"),
        body: SingleChildScrollView(
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
                                  color: hexToColor("#ffffff"),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: firstNameController,
                              onSaved: (val) => firstNameController.text = val!,
                              keyboardType: TextInputType.name,
                              style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor("#0065A0"),
                                  fontSize: 15.0),
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
                                hintText: AppStrings.firstNameHintText,
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
                                AppStrings.lname,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: hexToColor("#ffffff"),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: lastNameController,
                              onSaved: (val) => lastNameController.text = val!,
                              keyboardType: TextInputType.name,
                              style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor("#0065A0"),
                                  fontSize: 15.0),
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
                                hintText: AppStrings.lastNameHintText,
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
                                AppStrings.emailID,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: hexToColor("#ffffff"),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: emailIDController,
                              onSaved: (val) => emailIDController.text = val!,
                              keyboardType: TextInputType.emailAddress,
                              style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor("#0065A0"),
                                  fontSize: 15.0),
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
                                hintText: AppStrings.emailHintText,
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
                                AppStrings.mobileNO,
                                style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: hexToColor("#ffffff"),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: maxLines * 25.0,
                          child: TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: mobileNOController,
                              onSaved: (val) => mobileNOController.text = val!,
                              keyboardType: TextInputType.number,
                              style: kGoogleStyleTexts.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: hexToColor("#0065A0"),
                                  fontSize: 15.0),
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
                                hintText: AppStrings.mobileNO,
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
                                  color: hexToColor("#ffffff"),
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
                                color: hexToColor("#0065A0"),
                                fontSize: 15.0),
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
                              hintText: AppStrings.passwordHintText,
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
                      onPressed: () {
                        String? check = validations.accountValidation(
                            firstNameController.text,
                            lastNameController.text,
                            mobileNOController.text,
                            emailIDController.text,
                            passwordController.text);
                        if (check == null) {
                          addDataToCANFill();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(fillEezzReq: widget.fillEezzReq),
                            ),
                          );
                        } else {
                          if (kDebugMode) {
                            print("hii$check");
                          }
                        }
                      },
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

  void addDataToCANFill() async {
    widget.fillEezzReq.rEQBODY?.hOLDERRECORDS?.hOLDERRECORD?.nAME =
        "${firstNameController.text} ${lastNameController.text}";
    widget.fillEezzReq.rEQBODY?.hOLDERRECORDS?.hOLDERRECORD?.cONTACTDETAIL
        ?.pRIEMAIL = emailIDController.text;
    widget.fillEezzReq.rEQBODY?.hOLDERRECORDS?.hOLDERRECORD?.cONTACTDETAIL
        ?.pRIMOBNO = mobileNOController.text;
    widget.fillEezzReq.rEQBODY?.hOLDERRECORDS?.hOLDERRECORD?.cONTACTDETAIL
        ?.pRIMOBBELONGSTO = "S";
    widget.fillEezzReq.rEQBODY?.hOLDERRECORDS?.hOLDERRECORD?.cONTACTDETAIL
        ?.pRIEMAILBELONGSTO = "S";

    Track.isRegistered = true;
    Map<String, dynamic> allData = widget.fillEezzReq.toJson();
    String user = jsonEncode(widget.fillEezzReq);
    print(user.toString());
    prefs.then((pref) => pref.setBool('isRegistered', true));
    await prefs.then(
        (pref) => pref.setString('fillEezzReq', widget.fillEezzReq.toString()));
  }
}

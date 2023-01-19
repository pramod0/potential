import 'package:flutter/material.dart';
import 'package:potential/screens/CANcreationform/preLogin.dart';

//import 'package:potential/screens/CANcreationform/preLogin.dart';
import 'package:potential/utils/appTools.dart';
import 'package:potential/utils/noGlowBehaviour.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_assets_constants/AppStrings.dart';
import '../../models/cancreation.dart';

import '../../utils/styleConstants.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final CanIndFillEezzReq _fillEezzReq = CanIndFillEezzReq();
  final prefs = SharedPreferences.getInstance();
  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

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
                        _fillEezzReq.reqBody.holderRecords.holderRecord.name =
                            "${firstNameController.text} ${lastNameController.text}";
                        _fillEezzReq.reqBody.holderRecords.holderRecord
                            .contactDetail.priEmail = emailIDController.text;
                        _fillEezzReq.reqBody.holderRecords.holderRecord
                            .contactDetail.priMobNo = mobileNOController.text;
                        _fillEezzReq.reqBody.holderRecords.holderRecord
                            .contactDetail.priEmailBelongsto = "S";
                        _fillEezzReq.reqBody.holderRecords.holderRecord
                            .contactDetail.priMobBelongsto = "S";
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PreLoginPage(),
                          ),
                        );
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
}

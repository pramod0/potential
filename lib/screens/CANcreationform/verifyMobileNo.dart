//import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:potential/screens/tabspage.dart';
// import 'package:potential/utils/AllData.dart';
import 'package:potential/utils/appTools.dart';

// import 'package:firebase_auth/firebase_auth.dart';

import '../../app_assets_constants/AppColors.dart';
import '../../app_assets_constants/AppStrings.dart';
//import '../../models/cancreation.dart';
import '../../utils/styleConstants.dart';
import '../../utils/track.dart';
//import '../login.dart';

class VerifyMobileNum extends StatefulWidget {
  const VerifyMobileNum({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyMobileNum> createState() => _CreateVerifyMobileNum();
}

class _CreateVerifyMobileNum extends State<VerifyMobileNum> {
  final maxLines = 2;
  final TextEditingController mobileNOController =
      TextEditingController(text: "");
  final TextEditingController otpController1 = TextEditingController(text: "");
  final TextEditingController otpController2 = TextEditingController(text: "");
  final TextEditingController otpController3 = TextEditingController(text: "");
  final TextEditingController otpController4 = TextEditingController(text: "");
  final TextEditingController otpController5 = TextEditingController(text: "");
  final TextEditingController otpController6 = TextEditingController(text: "");
  final TextEditingController otpController = TextEditingController(text: "");
  // final auth = FirebaseAuth.instance;

  // otpDialogBox(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Enter your OTP'),
  //           content: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: TextFormField(
  //               decoration: const InputDecoration(
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(5),
  //                   ),
  //                 ),
  //               ),
  //               onChanged: (value) {
  //                 otp = value;
  //               },
  //             ),
  //           ),
  //           contentPadding: const EdgeInsets.all(10.0),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 signIn(otp!);
  //               },
  //               child: const Text(
  //                 'Submit',
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  String? phoneNumber, verificationId;
  String? otp, authStatus = "";

  Future<void> signIn(String otp) async {
    // await auth.setSettings(phoneNumber: "+91 7303 545 657");
    // await FirebaseAuth.instance.signInWithPhoneNumber("+91 7303 545 657");
  }

  // Future<void> _logout() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  verifyPhoneNumber(BuildContext context) async {
    validateStepFourContactInfo();
    phoneNumber =
        "+91 ${mobileNOController.text[0]}${mobileNOController.text[1]}${mobileNOController.text[2]}${mobileNOController.text[3]} "
        "${mobileNOController.text[4]}${mobileNOController.text[5]}${mobileNOController.text[6]} "
        "${mobileNOController.text[7]}${mobileNOController.text[8]}${mobileNOController.text[9]} ";
    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: phoneNumber,
    //   timeout: const Duration(seconds: 120),
    //   verificationCompleted: (AuthCredential authCredential) {
    //     setState(() {
    //       authStatus = "Your account is successfully verified";
    //     });
    //
    //     // Navigator.of(context).push(
    //     //   MaterialPageRoute(
    //     //     builder: (context) => TabsPage(
    //     //       selectedIndex: 0,
    //     //     ),
    //     //   ),
    //     // );
    //   },
    //   verificationFailed: (FirebaseAuthException authException) {
    //     setState(() {
    //       authStatus = "Authentication failed";
    //     });
    //   },
    //   codeSent: (String verId, [int? forceCodeResent]) {
    //     Track.isOTPGenerated = true;
    //     verificationId = verId;
    //     setState(() {
    //       authStatus = "OTP has been successfully send\nIt is valid for 30";
    //     });
    //     showDialog(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (context) => AlertDialog(
    //               title: const Text("Enter SMS Code"),
    //               content: Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: <Widget>[
    //                   TextField(
    //                     controller: otpController,
    //                   ),
    //                 ],
    //               ),
    //               actions: <Widget>[
    //                 ElevatedButton(
    //                   onPressed: performVerification(context),
    //                   child: const Text("Done"),
    //                 )
    //               ],
    //             ));
    //   },
    //   codeAutoRetrievalTimeout: (String verId) {
    //     verificationId = verId;
    //     setState(() {
    //       authStatus = "TIMEOUT";
    //     });
    //   },
    // );
  }

  performVerification(BuildContext context) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    //
    // var smsCode = otpController.text.trim();
    //
    // var credential = PhoneAuthProvider.credential(
    //     verificationId: verificationId!, smsCode: smsCode);
    // await auth.signInWithCredential(credential).catchError((e) {
    //   if (kDebugMode) {
    //     print(e);
    //   }
    // });
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 0)));
    // Track.isMobileNoVerified = true;
  }

  String? validateStepFourContactInfo() {
    Pattern pattern = "(0/91)?[6-9][0-9]{9}";
    RegExp regex = RegExp(pattern.toString());
    // var email = data['email'];
    var contactNo = mobileNOController.text;

    if (contactNo == '') {
      return AppStrings.contactNoRequired;
    } else if (!regex.hasMatch(contactNo)) {
      return "Invalid Contact Number";
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    //verifyNo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = (MediaQuery.of(context).size.width - 60) / 6;
    double width = (((MediaQuery.of(context).size.width - 60) / 6));
    // if (kDebugMode) {
    //   print(height);
    // }
    return Scaffold(
      backgroundColor: hexToColor("#121212"),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
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
              initialValue: '0',
              onSaved: (val) => mobileNOController.text = val!,
              keyboardType: TextInputType.number,
              style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w400,
                  color: hexToColor("#0065A0"),
                  fontSize: 15.0),
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: hexToColor("#0065A0"),
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(color: hexToColor("#0065A0"))),
                fillColor: const Color.fromARGB(30, 173, 205, 219),
                filled: true,
                hintText: AppStrings.mobileNO,
                hintStyle: kGoogleStyleTexts.copyWith(
                    color: hexToColor("#5F93B1"),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width - 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: () {
                mobileNOController.text == ""
                    ? null
                    : verifyPhoneNumber(context);
              },
              child: Text(
                AppStrings.generateOTP,
                style: kGoogleStyleTexts.copyWith(
                    color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Track.isOTPGenerated == false
                ? Container()
                : otpField(height, width),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width - 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TabsPage(
                      selectedIndex: 0,
                    ),
                  ),
                );
              },
              child: Text(
                AppStrings.verifyLater,
                style: kGoogleStyleTexts.copyWith(
                    color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            authStatus == "" ? "" : authStatus!,
            style: TextStyle(
                color: authStatus!.contains("fail") ||
                        authStatus!.contains("TIMEOUT")
                    ? Colors.red
                    : Colors.green),
          )
        ],
      ),
    );
  }

  Widget otpField(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 40.0, right: 18.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(AppStrings.verificationCode,
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: hexToColor(AppColors.blackTextColor),
                    fontSize: 15.0)),
          ),
          Form(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                otpFieldSingle(
                    otpController: otpController1,
                    height: height,
                    width: width),
                otpFieldSingle(
                    otpController: otpController2,
                    height: height,
                    width: width),
                otpFieldSingle(
                    otpController: otpController3,
                    height: height,
                    width: width),
                otpFieldSingle(
                    otpController: otpController4,
                    height: height,
                    width: width),
                otpFieldSingle(
                    otpController: otpController5,
                    height: height,
                    width: width),
                otpFieldSingle(
                    otpController: otpController6,
                    height: height,
                    width: width),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class otpFieldSingle extends StatelessWidget {
  const otpFieldSingle({
    super.key,
    required this.otpController,
    required this.height,
    required this.width,
  });

  final TextEditingController otpController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        textInputAction: TextInputAction.next,
        controller: otpController,
        onChanged: (val) {
          if (val.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (val) => otpController.text = val!,
        keyboardType: TextInputType.number,
        style: kGoogleStyleTexts.copyWith(
            fontWeight: FontWeight.w400,
            color: hexToColor("#0065A0"),
            fontSize: 15.0),
        maxLines: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: hexToColor(AppColors.textFieldOutlineBorderColor)),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: hexToColor("#ffffff"))),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(
              color: hexToColor("#0065A0"),
            ),
          ),
        ),
      ),
    );
  }
}

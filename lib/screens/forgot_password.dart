import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/ApiService.dart';
import 'package:potential/screens/verify_otp_newpass.dart';

import '../utils/elevated_expaned.dart';
import '../utils/styleConstants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  showSnackBar(String text, Color color) {
    var snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.endToStart,
        content: AutoSizeText(
          text,
          style: kGoogleStyleTexts.copyWith(
            color: color,
            fontSize: 15,
          ),
        ));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                controller: _textController,
                focusNode: _emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your registered email address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!RegExp(r"[^@ ]+@[^@ ]+\.[^@ ]+").hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ExpandedElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var returned = await ApiService().sendOTP(
                      email: _textController.text,
                    );
                    var ret = jsonDecode(returned);
                    bool success = jsonDecode(returned)["success"];
                    if (kDebugMode) {
                      print(success);
                    }
                    if (success) {
                      showSnackBar("OTP Sent Sucessfully", Colors.blueAccent);
                      if (!context.mounted) return;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => VerifyEmailScreen(
                            email: _textController.text,
                          ),
                        ),
                      );
                    } else {
                      print(ret);
                      if (ret["message"] ==
                          "Cannot read property 'update' of null") {
                        showSnackBar(
                            "Email ID not registered", Colors.redAccent);
                      } else {
                        showSnackBar(
                            "Try again after some time", Colors.redAccent);
                      }
                      // Navigator.of(context).pop();
                    }
                  }
                },
                textToShow: 'Send OTP',
              )
            ],
          ),
        ),
      ),
    );
  }
}

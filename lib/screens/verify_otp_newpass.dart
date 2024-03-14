import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/ApiService.dart';

import '../app_assets_constants/AppColors.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email; // Pass the email from Forgot Password screen

  const VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _newPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
  final _otpFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();

  String _errorMessage = '';

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _otpFocusNode.dispose();
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
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
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(
                // controller: _emailController,
                readOnly: true,
                initialValue: widget.email,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                focusNode: _otpFocusNode,
                decoration: const InputDecoration(
                  labelText: 'OTP',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  }
                  // Add more OTP validation rules here (e.g., length, format)
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _newPasswordController,
                obscureText: !_showNewPassword,
                focusNode: _newPasswordFocusNode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  // Add more password validation rules here (e.g., length, strength)
                  return null;
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                      .requestFocus(_confirmPasswordFocusNode);
                },
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showNewPassword = !_showNewPassword;
                      });
                    },
                    child: Icon(
                      _showNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: hexToColor(AppColors.blackTextColor),
                      //hexToColor(AppColors.whiteBorderColor),
                      size: 22,
                    ),
                  ),
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: !_showConfirmPassword,
                focusNode: _confirmPasswordFocusNode,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_otpFocusNode);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                    child: Icon(
                      _showConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: hexToColor(AppColors.blackTextColor),
                      //hexToColor(AppColors.whiteBorderColor),
                      size: 22,
                    ),
                  ),
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var returned = await ApiService().sendOTP(
                        email: widget.email,
                      );
                      bool success = jsonDecode(returned)["success"];
                      if (kDebugMode) {
                        print(success);
                      }
                      if (success) {
                        showSnackBar(
                            "OTP sent Successfully", Colors.blueAccent);
                      } else {
                        showSnackBar("Unable to send OTP", Colors.redAccent);
                      }
                    },
                    child: const Text('Resend OTP'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var returned = await ApiService().verifyOTP(
                            email: widget.email,
                            otp: _otpController.text,
                            pass: _newPasswordController.text,
                            confirmPass: _confirmPasswordController.text);
                        var jsonji = jsonDecode(returned);
                        bool success = jsonji["success"];
                        ;
                        if (kDebugMode) {
                          print(success);
                        }
                        if (success) {
                          //todo:show snackbar and got to login page pop
                          showSnackBar("Password changed Sucessfully",
                              Colors.blueAccent);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        } else {
                          // if (kDebugMode) {
                          //   print(jsonji["error"][0]["message"].toString());
                          // }
                          if (jsonji["error"].runtimeType == [].runtimeType) {
                            showSnackBar(
                                jsonji["error"][0]["message"].toString(),
                                Colors.redAccent);
                          } else {
                            showSnackBar(
                                jsonji["error"].toString(), Colors.redAccent);
                          }
                          if (!context.mounted) return;
                        }
                      }
                    },
                    child: const Text('Verify OTP'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

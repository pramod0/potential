import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:potential/ApiService.dart';

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

  void _verifyOTP() async {
    // Implement API call with http package
    // Send OTP along with other required parameters (e.g., new password)
    final response = await http.post(Uri.parse('your-api-endpoint'), body: {
      'otp': _otpController.text,
      'newPassword': _newPasswordController.text,
      // ...other parameters
    });
    if (response.statusCode == 200) {
      // Handle successful verification (e.g., navigate to success screen)
      Navigator.pushNamed(
          context, '/success'); // Replace with your success route
    } else {
      setState(() {
        _errorMessage = 'Invalid OTP or error: ${response.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
                decoration: InputDecoration(
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
                obscureText: true,
                focusNode: _newPasswordFocusNode,
                decoration: InputDecoration(
                  labelText: 'New Password',
                ),
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
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                focusNode: _confirmPasswordFocusNode,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
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
                        //todo:show snackbar
                      }
                    },
                    child: Text('resend OTP'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var returned = await ApiService().verifyOTP(
                            email: widget.email,
                            otp: _otpController.text,
                            pass: _newPasswordController.text,
                            confirmPass: _confirmPasswordController.text);
                        bool success = jsonDecode(returned)["success"];
                        if (kDebugMode) {
                          print(success);
                        }
                        if (success) {
                          //todo:show snackbar and got to login page pop
                        }
                      }
                    },
                    child: Text('Verify OTP'),
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

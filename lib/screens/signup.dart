import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potential/ApiService.dart';

import '../app_assets_constants/AppStrings.dart';
import '../utils/styleConstants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState(){
    return _SignUpPageState();
  }

}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _panCardController = TextEditingController();

  String? _validatePanCard(String? value) {
    // Example pan card validation logic (can be customized)
    if (value == null || value.isEmpty) {
      return 'Please enter your PAN Card number';
    }
    // Add your validation logic for PAN Card format
    // For example, you can use regular expressions to validate the format
    // or call an API to verify the PAN Card number
    // Here, we'll assume a valid PAN Card is 10 characters long
    if (value.length != 10) {
      return 'Please enter a valid PAN Card number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    // Example email validation logic (can be customized)
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // Add your email validation logic here (using regex, package, or API)
    // Here, we'll assume a simple format validation
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    // Example phone number validation logic (can be customized)
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // Add your phone number validation logic here (using regex, package, or API)
    // Here, we'll assume a simple format validation
    if (value.length != 10) {
      return 'Please enter a valid Indian mobile number';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with signup logic here
      // You can access the field values using the controllers:
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final phoneNumber = _phoneNumberController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;
      final panCard = _panCardController.text.toUpperCase();

      // Create a JSON payload
      var payload = jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'email': email,
        'password': password,
        'confirmpassword': password,
        'userRole': "user",
        'panCard': panCard,
      });

      ApiService().signUp(payload);
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _panCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.firsNameText),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.lastNameText),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneNumberController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.mobileNO),
                  validator: _validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(13),
                  ],
                ),
                TextFormField(
                  controller: _emailController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.emailID),
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.passwordText),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                      labelText: AppStrings.confirmPasswordText),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _panCardController,
                  decoration:
                      const InputDecoration(labelText: AppStrings.panCard),
                  validator: _validatePanCard,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[A-Za-z]{5}d{4}[A-Za-z]{1}')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    AppStrings.signUpText,
                    style: kGoogleStyleTexts.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

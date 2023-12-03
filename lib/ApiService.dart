import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/utils/constants.dart';
import 'package:http/http.dart';

class ApiService {
  // Pramod: I do not understand the code myself. I wanted to make ApiService class singleton.
  // Apparently there is very little documentation regarding sharedInstance.

  ApiService._sharedInstance();

  static final ApiService _shared = ApiService._sharedInstance();

  factory ApiService() => _shared;

  Future<String> signUp(String payload) async {
    // Replace this with your signup endpoint URL
    Uri signupUri = Uri.parse('${Constants.domainURL}${Constants.signupURL}');

    Response response = await post(
      signupUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      // Signup successful
      if (kDebugMode) {
        print(response.body);
      }
      return response.body;
    } else {
      // Signup failed
      if (kDebugMode) {
        print(response.body);
      }
      throw Exception('Signup failed');
    }
  }

  Future<String> processLogin(String userName, String password) async {
    Uri loginUri = Uri.parse('${Constants.domainURL}${Constants.loginURL}');
    if (kDebugMode) {
      print(loginUri);
    }

    try {
      Response response = await post(loginUri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'email': userName,
            'password': password,
            "deviceType": "android"
          })).timeout(const Duration(seconds: 10)); // end of http.post
      // print(response.body.toString());
      if (kDebugMode) {
        print(response.body);
      }
      return response.body;
    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('Please try again after some time.');
      }
      throw ("Please try again after some time.");
    }
  }

  // Future<bool> checkConsentdone(
  //     String can, String pan, DateTime dob, BuildContext context) async {
  //   Uri loginUri = Uri.parse('${Constants.domainURL}${Constants.loginURL}');
  //   if (kDebugMode) {
  //     print(loginUri);
  //   }
  //
  //   Response response = await post(loginUri,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'email': userName,
  //         'password': password,
  //         "deviceType": "android"
  //       })); // end of http.post
  //   // print(response.body.toString());
  //   return true;
  // }

  Future<String> dashboardAPI(String token, int limit, int offset) async {
    // Replace this with your signup endpoint URL
    Uri dashboardURI = Uri.parse(
        '${Constants.domainURL}${Constants.dashboardURL}?limit=$limit&offset=$offset');
    // http://localhost:7070/api/dashboard?limit=100&offset=0

    // if (kDebugMode) {
    //   print(dashboardURI.toString());
    // }

    try {
      Response response = await get(dashboardURI, headers: <String, String>{
        'Content-Type': 'application/json', //; charset=UTF-8
        'Authorization': 'Bearer $token'
      }).timeout(const Duration(seconds: 5));
      // if (kDebugMode) {
      //   print(response.body);
      // }
      if (response.statusCode == 200) {
        // Signup successful
        // if (kDebugMode) {
        //   print(response.body);
        // }
        return response.body;
      } else {
        // Signup failed
        // if (kDebugMode) {
        //   print(response.body);
        // }
        throw Exception('dashboard api failed');
      }
    } on TimeoutException catch (e) {
      print('Please try again after some time.');
      return "Please try again after some time.";
    }
  }

  Future<String> schemeSummaryAPI(
      String token, String fund, String scheme) async {
    // Replace this with your signup endpoint URL
    Uri dashboardURI =
        Uri.parse('${Constants.domainURL}${Constants.schemeSummaryURL}');
    // http://localhost:7070/api/dashboard?limit=100&offset=0

    // if (kDebugMode) {
    //   print(dashboardURI.toString());
    // }

    try {
      Response response = await get(dashboardURI, headers: <String, String>{
        'Content-Type': 'application/json', //; charset=UTF-8
        'Authorization': 'Bearer $token',
        'fund': fund,
        'scheme': scheme
      }).timeout(const Duration(seconds: 5));
      // if (kDebugMode) {
      //   print(response.body);
      // }
      if (response.statusCode == 200) {
        // Signup successful
        // if (kDebugMode) {
        //   print(response.body);
        // }
        return response.body;
      } else {
        // Signup failed
        // if (kDebugMode) {
        //   print(response.body);
        // }
        throw Exception('schemeSummary api failed');
      }
    } on TimeoutException catch (e) {
      // print('Please try again after some time.');
      return "Please try again after some time.";
    }
  }
// Future<String> canCreation(String userName, BuildContext context) async {
//   // var response = await http.post(
//   //     Uri.parse('${Constants.domainURL}${Constants.loginURL}'),
//   //     headers: <String, String>{
//   //       'Content-Type': 'application/xml; charset=UTF-8',
//   //     },
//   //     body: jsonEncode(
//   //         <String, String>{'username': userName, 'password': password}));
//
//   return js;
//   // return loginModelFromJson(response.body);
// }
}

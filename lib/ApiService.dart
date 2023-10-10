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
  String js =
      "{\"expiry\":\"2023-01-07T01:21:19.999735Z\",\"token\":\"3842461fdf754e2756dfbf8d3a6516b9a2b367ea62a1f006f5e7eec98f395c34\",\"user_id\":43,\"status_code\":1000,\"message\":\"LoginSuccessful.\",\"investorData\":{\"id\":\"HYS076\",\"name\":\"Pramod Gupta\",\"investment_data\":{\"invested\":500000,\"current\":700000,\"fund_data\":[{\"fund_name\":\"Parag Parikh FlexiCap Mutual Fund\",\"invested\":300000,\"current\":470000,\"current_nav\":47,\"total_units\":10000},{\"fund_name\":\"Pramod Gupta Mutual Fund\",\"invested\":200000,\"current\":230000,\"current_nav\":23,\"total_units\":10000}]}}}";

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

  Future<String> processLogin(
      String userName, String password, BuildContext context) async {
    Uri loginUri = Uri.parse('${Constants.domainURL}${Constants.loginURL}');
    if (kDebugMode) {
      print(loginUri);
    }

    Response response = await post(loginUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': userName,
          'password': password,
          "deviceType": "android"
        })); // end of http.post
    // print(response.body.toString());
    return response.body;
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

    if (kDebugMode) {
      print(dashboardURI.toString());
    }

    Response response = await get(dashboardURI, headers: <String, String>{
      'Content-Type': 'application/json', //; charset=UTF-8
      'Authorization': 'Bearer $token'
    });
    // if (kDebugMode) {
    //   print(response.body);
    // }
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
      throw Exception('dashboard api failed');
    }
  }

  Future<String> schemeSummaryAPI(
      String token, String fund, String scheme) async {
    // Replace this with your signup endpoint URL
    Uri dashboardURI =
        Uri.parse('${Constants.domainURL}${Constants.schemeSummaryURL}');
    // http://localhost:7070/api/dashboard?limit=100&offset=0

    if (kDebugMode) {
      print(dashboardURI.toString());
    }

    Response response = await get(dashboardURI, headers: <String, String>{
      'Content-Type': 'application/json', //; charset=UTF-8
      'Authorization': 'Bearer $token',
      'fund': fund,
      'scheme': scheme
    });
    // if (kDebugMode) {
    //   print(response.body);
    // }
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
      throw Exception('schemeSummary api failed');
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

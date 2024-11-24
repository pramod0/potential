import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/models/schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:jwt_decoder/jwt_decoder.dart';

import '../ApiService.dart';
import '../models/token.dart';

class AllData {
  // static late CANIndFillEezzReq fillEezzReq;
  static InvestedData investedData = InvestedData(
      invested: 0,
      current: 0,
      totalReturns: 0,
      absReturns: 0,
      xirr: 0,
      //
      sinceDaysCAGR: 0,
      fundData: []);
  static Map<String, SchemeData> schemeMap = <String, SchemeData>{};
  static late User investorData;
  static DateTime lastFetchTime =
      DateTime.now(); // Define your refresh interval

  /// private constructor
  AllData._sharedInstance();

  /// the one and only instance of this singleton
  static final instance = AllData._sharedInstance();

  factory AllData() => instance;

  static setInvestorData(User investorData) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    AllData.investorData = investorData;
    AllData.lastFetchTime = DateTime.now();
  }

  static setInvestmentData(InvestedData investedData) async {
    AllData.investedData = investedData;
    AllData.lastFetchTime = DateTime.now();
  }

  static setSchemeSummary(SchemeData schemeSummary) async {
    if (kDebugMode) {
      // print(schemeSummary.data[0].key);
    }
    AllData.schemeMap
        .putIfAbsent(schemeSummary.data[0].key, () => schemeSummary);
    AllData.lastFetchTime = DateTime.now();
  }

  static printAll() {
    if (kDebugMode) {
      // print(AllData.investorData.toJson());
      // print(AllData.investedData.toJson());
      // print(AllData.schemeMap.toString());
    }
  }

  static Future<String> getSchemeData(String fund, String scheme) async {
    try {
      EasyLoading.show(
        status: 'please wait your Data is loading...',
      );

      if (AllData.schemeMap.containsKey('${fund}_$scheme')) {
        await EasyLoading.dismiss();
        return '${fund}_${scheme.toString()}';
      }
      var token = Token.instance.token;
      // if (kDebugMode) {
      //   print(token);
      // }
      var responseBody =
          jsonDecode(await ApiService().schemeSummaryAPI(token, fund, scheme));

      // if (kDebugMode) {
      //   print("summary");
      //   print(responseBody.toString());
      // }
      SchemeData schemeData = SchemeData.fromJson(responseBody['fundData']);

      // if (kDebugMode) {
      //   print("responseBody.toString()");
      // }
      // if (kDebugMode) {
      //   print(schemeData.length);
      // }

      AllData.setSchemeSummary(schemeData);
      // if (kDebugMode) {
      //   print(schemeData.length);
      // }
      var prefs = SharedPreferences.getInstance();
      prefs.then(
          (pref) => pref.setString('allSchemes', AllData.schemeMap.toString()));
      await EasyLoading.dismiss();
      // if (kDebugMode) {
      //   print(schemeData.length);
      // }
      return '${fund}_${scheme.toString()}';
    } catch (e) {
      if (kDebugMode) {
        // print(e);
      }
      // var schemes = "No";
      await EasyLoading.dismiss();
      return "";
    }
  }

  static bool checkLastFetched() {
    if (DateTime.now().day - lastFetchTime.day > 0) {
      return true;
    }
    return false;
  }
}

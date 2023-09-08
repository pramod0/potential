import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/token.dart';
import '../models/cancreation.dart';

class AllData {
  // static late CANIndFillEezzReq fillEezzReq;
  static late InvestedData investedData;
  static late User investorData;

  /// private constructor
  AllData._sharedInstance();

  /// the one and only instance of this singleton
  static final instance = AllData._sharedInstance();

  factory AllData() => instance;

  static setInvestorData(User investorData) async {
    // SharedPreferences pref = await SharedPreferences.getInstance();
    AllData.investorData = investorData;
  }

  static setInvestmentData(InvestedData investedData) async {
    AllData.investedData = investedData;
  }
}

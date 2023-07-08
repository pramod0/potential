import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:potential/models/investor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cancreation.dart';

class AllData {
  static late CANIndFillEezzReq fillEezzReq;
  static late Investor investorData;
  getCanData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      String? dec = pref.getString('fillEezzReq');
      var userMap = jsonDecode(dec!);
      fillEezzReq = CANIndFillEezzReq.fromJson(userMap);
    } catch (err) {
      fillEezzReq = CANIndFillEezzReq();
    }
  }

  getInvestorData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      String? dec = pref.getString('investedData');
      var userMap = jsonDecode(dec!);
      investorData = Investor.fromJson(userMap);
    } catch (err) {
      investorData = Investor();
    }
  }

  AllData() {
    getCanData();
    getInvestorData();
  }
}


import 'package:flutter/foundation.dart';
import 'package:potential/models/investments.dart';
import 'package:potential/models/investor.dart';
import 'package:potential/models/schemes.dart';

class AllData {
  // static late CANIndFillEezzReq fillEezzReq;
  static InvestedData investedData = InvestedData(
      invested: 0,
      current: 0,
      totalReturns: 0,
      absReturns: 0,
      xirr: 0,
      irr: 0,
      sinceDaysCAGR: 0,
      fundData: []);
  static Map<String, SchemeData> schemeMap = <String, SchemeData>{};
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

  static setSchemeSummary(SchemeData schemeSummary) async {
    if (kDebugMode) {
      print(schemeSummary.data[0].key);
    }
    AllData.schemeMap
        .putIfAbsent(schemeSummary.data[0].key, () => schemeSummary);
  }
}

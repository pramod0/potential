import 'package:flutter/services.dart';

class Investor {
  String? id;
  String? name;
  InvestmentData? investmentData;

  Investor({this.id, this.name, this.investmentData});

  Investor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    investmentData = json['investment_data'] != null
        ? InvestmentData.fromJson(json['investment_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (investmentData != null) {
      data['investment_data'] = investmentData!.toJson();
    }
    return data;
  }
}

class InvestmentData {
  int? invested;
  int? current;
  int? totalRet;
  double perReturns = 0.0;
  // XIIR is calculated on historical data
  // % return current-initial/initial

  List<FundData>? fundData;

  InvestmentData({this.invested, this.current, this.fundData});

  InvestmentData.fromJson(Map<String, dynamic> json) {
    invested = json['invested'];
    current = json['current'];
    totalRet = (invested! + current!);
    perReturns = ((current!) - (invested!)) / (invested!) * 100;
    if (json['fund_data'] != null) {
      fundData = <FundData>[];
      json['fund_data'].forEach((v) {
        fundData!.add(FundData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invested'] = invested;
    data['current'] = current;
    if (fundData != null) {
      data['fund_data'] = fundData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FundData {
  String? fundName;
  int? invested;
  int? current;
  int? currentNav;
  int? totalUnits;
  double perReturns = 0.0;

  FundData(
      {this.fundName,
      this.invested,
      this.current,
      this.currentNav,
      this.totalUnits});

  FundData.fromJson(Map<String, dynamic> json) {
    fundName = json['fund_name'];
    invested = json['invested'];
    current = json['current'];
    currentNav = json['current_nav'];
    totalUnits = json['total_units'];
    perReturns = ((current!) - (invested!)) / (invested!) * 100;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fund_name'] = fundName;
    data['invested'] = invested;
    data['current'] = current;
    data['current_nav'] = currentNav;
    data['total_units'] = totalUnits;
    return data;
  }
}

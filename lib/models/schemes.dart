import 'package:flutter/foundation.dart';

class SchemeData {
  int length = 0;
  List<Data> data = <Data>[];

  SchemeData({required this.length, required this.data});

  SchemeData.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    if (kDebugMode) {
      print("object");
    }
    if (kDebugMode) {
      print(length);
    }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['length'] = length;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  String folioNumber = "";
  double amount = 0;
  double units = 0.0;
  double nav = 0.0;
  String date = "";
  String transType = "";
  String paymentStatus = "";
  String transactionStatus = "";
  int installmentNumber = 0;
  String transactionNumber = "";
  String key = "";

  Data(
      {required this.folioNumber,
      required this.amount,
      required this.units,
      required this.nav,
      required this.date,
      required this.transType,
      required this.paymentStatus,
      required this.transactionStatus,
      required this.installmentNumber,
      required this.transactionNumber,
      required this.key});

  Data.fromJson(Map<String, dynamic> json) {
    folioNumber = json['folioNumber'];
    amount = json['amount'].toDouble();
    units = json['units'].toDouble();
    nav = json['nav'].toDouble();
    date = json['date'];
    transType = json['transType'];
    paymentStatus = json['paymentStatus'];
    transactionStatus = json['transactionStatus'];
    installmentNumber = json['installmentNumber'] ?? 1;
    transactionNumber = json['transactionNumber'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['folioNumber'] = folioNumber;
    data['amount'] = amount;
    data['units'] = units;
    data['nav'] = nav;
    data['date'] = date;
    data['transType'] = transType;
    data['paymentStatus'] = paymentStatus;
    data['transactionStatus'] = transactionStatus;
    data['installmentNumber'] = installmentNumber;
    data['transactionNumber'] = transactionNumber;
    data['key'] = key;
    return data;
  }
}

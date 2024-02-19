class InvestedData {
  double invested = 0;
  double current = 0;
  double totalReturns = 0;
  double absReturns = 0;
  double xirr = 0;
  double irr = 0;
  double sinceDaysCAGR = 0;
  List<FundData> fundData = <FundData>[];

  InvestedData(
      {required this.invested,
      required this.current,
      required this.totalReturns,
      required this.absReturns,
      required this.xirr,
      required this.irr,
      required this.sinceDaysCAGR,
      required this.fundData});

  InvestedData.fromJson(Map<String, dynamic> json) {
    invested = json['invested'].toDouble();
    current = json['current'].toDouble();
    totalReturns = json['totalReturns'].toDouble();
    absReturns = json['absReturns'].toDouble();
    xirr = json['xirr'].toDouble();
    irr = json['irr'].toDouble();
    sinceDaysCAGR = json['sinceDaysCAGR'].toDouble();
    if (json['fundData'] != null) {
      fundData = <FundData>[];
      json['fundData'].forEach((v) {
        fundData.add(FundData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invested'] = invested;
    data['current'] = current;
    data['totalReturns'] = totalReturns;
    data['absReturns'] = absReturns;
    data['xirr'] = xirr;
    data['irr'] = irr;
    data['sinceCAGR'] = sinceDaysCAGR;
    data['fundData'] = fundData.map((v) => v.toJson()).toList();
    return data;
  }
}

class FundData {
  String fundName = '';
  String fundCode = '';
  String schemeName = '';
  String schemeCode = '';
  List<dynamic> folioList = <dynamic>[];
  double sipAmount = 0;
  double invested = 0;
  double unitHolding = 0;
  double currentNAV = 0;
  double currentValue = 0;
  double xirr = 0;
  double irr = 0;
  double totalReturns = 0;
  double absReturns = 0;
  String sinceDate = '';
  double sinceYears = 0;
  int sinceDays = 0;
  int installmentNumber = 0;
  double sinceDaysCAGR = 0;

  FundData(
      {required this.fundName,
      required this.fundCode,
      required this.schemeName,
      required this.schemeCode,
      required this.folioList,
      required this.sipAmount,
      required this.invested,
      required this.unitHolding,
      required this.currentNAV,
      required this.currentValue,
      required this.xirr,
      required this.irr,
      required this.totalReturns,
      required this.absReturns,
      required this.sinceDate,
      required this.sinceYears,
      required this.sinceDays,
      required this.installmentNumber,
      required this.sinceDaysCAGR});

  FundData.fromJson(Map<String, dynamic> json) {
    fundName = json['fundName'];
    fundCode = json['fundCode'];
    schemeName = json['schemeName'];
    schemeCode = json['schemeCode'];
    folioList = json['folioList'];
    sipAmount = json['sipAmount'].toDouble() ?? 0;
    invested = json['invested'].toDouble() ?? 0;
    unitHolding = json['units'].toDouble() ?? 0;
    currentNAV = json['currentNAV'].toDouble() ?? 0;
    currentValue = json['currentValue'].toDouble() ?? 0;
    xirr = json['xirr'].toDouble() ?? 0;
    irr = json['irr'].toDouble() ?? 0;
    totalReturns = json['totalReturns'].toDouble() ?? 0;
    absReturns = json['absReturns'].toDouble() ?? 0;
    sinceDate = json['sinceDate'];
    sinceYears = json['sinceYears'].toDouble() ?? 0;
    sinceDays = json['sinceDays'] ?? 0;
    installmentNumber = json['installmentNumber'] ?? 0;
    sinceDaysCAGR = json['sinceDaysCAGR'].toDouble() ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fundName'] = fundName;
    data['fundCode'] = fundCode;
    data['schemeName'] = schemeName;
    data['schemeCode'] = schemeCode;
    data['folioList'] = folioList;
    data['sipAmount'] = sipAmount;
    data['invested'] = invested;
    data['units'] = unitHolding;
    data['currentNAV'] = currentNAV;
    data['currentValue'] = currentValue;
    data['xirr'] = xirr;
    data['irr'] = irr;
    data['totalReturns'] = totalReturns;
    data['absReturns'] = absReturns;
    data['sinceDate'] = sinceDate;
    data['sinceYears'] = sinceYears;
    data['sinceDays'] = sinceDays;
    data['installmentNumber'] = installmentNumber;
    data['sinceDaysCAGR'] = sinceDaysCAGR;
    return data;
  }
}

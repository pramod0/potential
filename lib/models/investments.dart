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
    invested = (json['invested'] ?? 0).toDouble();
    current = (json['current'] ?? 0).toDouble();
    totalReturns = (json['totalReturns'] ?? 0).toDouble();
    absReturns = (json['absReturns'] ?? 0).toDouble();
    xirr = (json['xirr'] ?? 0).toDouble();
    irr = (json['irr'] ?? 0).toDouble();
    sinceDaysCAGR = (json['sinceDaysCAGR'] ?? 0).toDouble();
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
    sipAmount = (json['sipAmount'] ?? 0).toDouble();
    invested = (json['invested'] ?? 0).toDouble();
    unitHolding = (json['units'] ?? 0).toDouble();
    currentNAV = (json['currentNAV'] ?? 0).toDouble();
    currentValue = (json['currentValue'] ?? 0).toDouble();
    xirr = (json['xirr'] ?? 0).toDouble();
    irr = (json['irr'] ?? 0).toDouble();
    totalReturns = (json['totalReturns'] ?? 0).toDouble();
    absReturns = (json['absReturns'] ?? 0).toDouble();
    sinceDate = json['sinceDate'];
    sinceYears = (json['sinceYears'] ?? 0).toDouble();
    sinceDays = json['sinceDays'];
    installmentNumber = json['installmentNumber'];
    sinceDaysCAGR = (json['sinceDaysCAGR'] ?? 0).toDouble();
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

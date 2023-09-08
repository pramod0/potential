class InvestedData {
  var invested;
  var current;
  var totalReturns;
  var totalReturnsPercentage;
  List<FundData>? fundData;

  InvestedData({this.invested, this.current, this.fundData});

  InvestedData.fromJson(Map<String, dynamic> json) {
    invested = json['invested'];
    current = json['current'];
    totalReturns = current! - invested!;
    totalReturnsPercentage = (current! - invested!) / invested! * 100;
    if (json['fundData'] != null) {
      fundData = <FundData>[];
      json['fundData'].forEach((v) {
        fundData!.add(FundData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['invested'] = invested;
    data['current'] = current;
    data['totalReturns'] = current! - invested!;
    data['totalReturnsPercentage'] = totalReturnsPercentage;
    if (fundData != null) {
      data['fundData'] = fundData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FundData {
  var id;
  var fundName;
  var schemeName;
  var folioNumber;
  var folioCheckDigit;
  var unitHolding;
  var currentValue;
  var nav;
  var navDate;
  int? invested;
  var perReturns;
  var totalReturns;

  FundData(
      {this.id,
      this.fundName,
      this.schemeName,
      this.folioNumber,
      this.folioCheckDigit,
      this.unitHolding,
      this.currentValue,
      this.nav,
      this.navDate,
      this.invested});

  FundData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fundName = json['fundName'];
    schemeName = json['schemeName'];
    folioNumber = json['folioNumber'];
    folioCheckDigit = json['folioCheckDigit'];
    unitHolding = json['unitHolding'];
    currentValue = json['currentValue'];
    nav = json['nav'];
    navDate = json['navDate'];
    invested = json['invested'];
    totalReturns = currentValue! - invested!;
    perReturns = (currentValue! - invested!) / invested! * 100;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fundName'] = fundName;
    data['schemeName'] = schemeName;
    data['folioNumber'] = folioNumber;
    data['folioCheckDigit'] = folioCheckDigit;
    data['unitHolding'] = unitHolding;
    data['currentValue'] = currentValue;
    data['nav'] = nav;
    data['navDate'] = navDate;
    data['invested'] = invested;
    return data;
  }
}

class Investor {
  String? id;
  String? name;
  late InvestmentData investmentData;

  Investor({this.id, this.name, required this.investmentData});

  Investor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    investmentData = (json['investment_data'] != null
        ? InvestmentData.fromJson(json['investment_data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.investmentData != null) {
      data['investment_data'] = this.investmentData!.toJson();
    }
    return data;
  }
}

class InvestmentData {
  late String invested;
  late String current;
  late List<FundData> fundData;

  InvestmentData({required this.invested, required this.current, required this.fundData});

  InvestmentData.fromJson(Map<String, dynamic> json) {
    invested = json['invested'];
    current = json['current'];
    if (json['fund_data'] != null) {
      fundData = <FundData>[];
      json['fund_data'].forEach((v) {
        fundData!.add(new FundData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invested'] = this.invested;
    data['current'] = this.current;
    if (this.fundData != null) {
      data['fund_data'] = this.fundData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  int getReturns(){
    int returns = int.parse(current) - int.parse(invested);
    print("return: "+ returns.toString());
    return returns;
}
}

class FundData {
  late String fundName;
  late String invested;
  late String current;
  late String currentNav;
  late String totalUnits;

  FundData(
      {required this.fundName,
        required this.invested,
        required this.current,
        required this.currentNav,
        required this.totalUnits});

  FundData.fromJson(Map<String, dynamic> json) {
    fundName = json['fund_name'];
    invested = json['invested'];
    current = json['current'];
    currentNav = json['current_nav'];
    totalUnits = json['total_units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fund_name'] = this.fundName;
    data['invested'] = this.invested;
    data['current'] = this.current;
    data['current_nav'] = this.currentNav;
    data['total_units'] = this.totalUnits;
    return data;
  }
}
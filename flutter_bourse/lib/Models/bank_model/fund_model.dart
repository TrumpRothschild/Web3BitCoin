
class FundModel {
  int? total;
  List<FundRows>? rows;
  int? code;
  String? msg;

  FundModel({this.total, this.rows, this.code, this.msg});

  FundModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <FundRows>[];
      json['rows'].forEach((v) { rows!.add(new FundRows.fromJson(v)); });
    }
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}

class FundRows {
  int? fundId;
  String? fundName;
  String? description;
  String? lowRisk;
  double? profitRate;
  double? fee;
  double? weekRate;
  double? annualRate;
  double? price;
  double? increaseRate;
  double? marketValue;
  double? turnover;
  String? stockNumber;
  List<List>? trend;

  FundRows({this.fundId, this.fundName, this.description, this.lowRisk, this.profitRate, this.fee, this.weekRate, this.annualRate, this.price, this.increaseRate, this.marketValue, this.turnover, this.stockNumber, this.trend});

  FundRows.fromJson(Map<String, dynamic> json) {
    fundId = json['fundId'];
    fundName = json['fundName'];
    description = json['description'];
    lowRisk = json['lowRisk'];
    profitRate = json['profitRate'];
    fee = json['fee'];
    weekRate = json['weekRate'];
    annualRate = json['annualRate'];
    price = json['price'];
    increaseRate = json['increaseRate'];
    marketValue = json['marketValue'];
    turnover = json['turnover'];
    stockNumber = json['stockNumber'];
    if (json['trend'] != null) {
      trend = <List>[];
      // json['trend'].forEach((v) { trend!.add(new List.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fundId'] = this.fundId;
    data['fundName'] = this.fundName;
    data['description'] = this.description;
    data['lowRisk'] = this.lowRisk;
    data['profitRate'] = this.profitRate;
    data['fee'] = this.fee;
    data['weekRate'] = this.weekRate;
    data['annualRate'] = this.annualRate;
    data['price'] = this.price;
    data['increaseRate'] = this.increaseRate;
    data['marketValue'] = this.marketValue;
    data['turnover'] = this.turnover;
    data['stockNumber'] = this.stockNumber;
    if (this.trend != null) {
      data['trend'] = this.trend!.toList();
    }
    return data;
  }
}

class Trend {

Trend.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}
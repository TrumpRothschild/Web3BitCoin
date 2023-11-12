
class SavingModel {
  int? total;
  List<SavingRows>? rows;
  int? code;
  String? msg;

  SavingModel({this.total, this.rows, this.code, this.msg});

  SavingModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <SavingRows>[];
      json['rows'].forEach((v) {
        rows!.add(new SavingRows.fromJson(v));
      });
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

class SavingRows {
  int? savingId;
  String? savingName;
  String? description;
  int? fee;
  double? profitRate;
  String? duringType;
  double? dailyProfit;
  double? dailyInterest;
  int? accumulatedProfit;
  double? totalInterest;

  SavingRows(
      {this.savingId,
        this.savingName,
        this.description,
        this.fee,
        this.profitRate,
        this.duringType,
        this.dailyProfit,
        this.dailyInterest,
        this.accumulatedProfit,
        this.totalInterest});

  SavingRows.fromJson(Map<String, dynamic> json) {
    savingId = json['savingId'];
    savingName = json['savingName'];
    description = json['description'];
    fee = json['fee'];
    profitRate = json['profitRate'];
    duringType = json['duringType'];
    dailyProfit = json['dailyProfit'];
    dailyInterest = json['dailyInterest'];
    accumulatedProfit = json['accumulatedProfit'];
    totalInterest = json['totalInterest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['savingId'] = this.savingId;
    data['savingName'] = this.savingName;
    data['description'] = this.description;
    data['fee'] = this.fee;
    data['profitRate'] = this.profitRate;
    data['duringType'] = this.duringType;
    data['dailyProfit'] = this.dailyProfit;
    data['dailyInterest'] = this.dailyInterest;
    data['accumulatedProfit'] = this.accumulatedProfit;
    data['totalInterest'] = this.totalInterest;
    return data;
  }
}
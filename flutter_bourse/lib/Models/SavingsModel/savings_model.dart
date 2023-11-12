class SavingsModel {
  int? total;
  List<SavingsRows>? rows;
  int? code;
  String? msg;

  SavingsModel({this.total, this.rows, this.code, this.msg});
  SavingsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <SavingsRows>[];
      json['rows'].forEach((v) {
        rows!.add(new SavingsRows.fromJson(v));
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


class SavingsRows {
  int? stId;
  int? savingId;
  int? coinId;
  String? dealTime;
  int? amount;
  String? status;
  String? address;
  String? hash;
  String? direction;
  String? coinName;
  int? coinRate;
  String? savingsName;
  double? currentRate;
  double? regularRate;
  double? profitRate;
  double? dailyProfit;
  double? annualRate;
  int? accumulatedProfit;
  int? dailyInterest;
  double? totalInterest;
  int? outputAmount;
  double? totalOutputAmount;
  double? totalAmount;
  String? orderNum;

  SavingsRows(
      {this.stId,
        this.savingId,
        this.coinId,
        this.dealTime,
        this.amount,
        this.status,
        this.address,
        this.hash,
        this.direction,
        this.coinName,
        this.coinRate,
        this.savingsName,
        this.currentRate,
        this.regularRate,
        this.profitRate,
        this.dailyProfit,
        this.annualRate,
        this.accumulatedProfit,
        this.dailyInterest,
        this.totalInterest,
        this.outputAmount,
        this.totalOutputAmount,
        this.totalAmount,
        this.orderNum});

  SavingsRows.fromJson(Map<String, dynamic> json) {
    stId = json['stId'];
    savingId = json['savingId'];
    coinId = json['coinId'];
    dealTime = json['dealTime'];
    amount = json['amount'];
    status = json['status'];
    address = json['address'];
    hash = json['hash'];
    direction = json['direction'];
    coinName = json['coinName'];
    coinRate = json['coinRate'];
    savingsName = json['savingsName'];
    currentRate = json['currentRate'];
    regularRate = json['regularRate'];
    profitRate = json['profitRate'];
    dailyProfit = json['dailyProfit'];
    annualRate = json['annualRate'];
    accumulatedProfit = json['accumulatedProfit'];
    dailyInterest = json['dailyInterest'];
    totalInterest = json['totalInterest'];
    outputAmount = json['outputAmount'];
    totalOutputAmount = json['totalOutputAmount'];
    totalAmount = json['totalAmount'];
    orderNum = json['orderNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stId'] = this.stId;
    data['savingId'] = this.savingId;
    data['coinId'] = this.coinId;
    data['dealTime'] = this.dealTime;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['direction'] = this.direction;
    data['coinName'] = this.coinName;
    data['coinRate'] = this.coinRate;
    data['savingsName'] = this.savingsName;
    data['currentRate'] = this.currentRate;
    data['regularRate'] = this.regularRate;
    data['profitRate'] = this.profitRate;
    data['dailyProfit'] = this.dailyProfit;
    data['annualRate'] = this.annualRate;
    data['accumulatedProfit'] = this.accumulatedProfit;
    data['dailyInterest'] = this.dailyInterest;
    data['totalInterest'] = this.totalInterest;
    data['outputAmount'] = this.outputAmount;
    data['totalOutputAmount'] = this.totalOutputAmount;
    data['totalAmount'] = this.totalAmount;
    data['orderNum'] = this.orderNum;
    return data;
  }
}
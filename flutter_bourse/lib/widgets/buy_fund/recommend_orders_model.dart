
class RecommendOrdersModel {
  int? total;
  List<RecommendOrdersRows>? rows;
  int? code;
  String? msg;

  RecommendOrdersModel({this.total, this.rows, this.code, this.msg});

  RecommendOrdersModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <RecommendOrdersRows>[];
      json['rows'].forEach((v) {
        rows!.add(new RecommendOrdersRows.fromJson(v));
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

class RecommendOrdersRows {
  int? rtId;
  int? recommendId;
  int? coinId;
  String? dealTime;
  int? amount;
  int? price;
  String? status;
  String? address;
  String? hash;
  String? direction;
  String? coinName;
  int? coinRate;
  String? recommendName;
  double? outputAmount;
  double? totalAmount;
  double? totalOutputAmount;
  String? orderNum;
  double? dailyProfit;
  double? annualRate;

  RecommendOrdersRows(
      {this.rtId,
        this.recommendId,
        this.coinId,
        this.dealTime,
        this.amount,
        this.price,
        this.status,
        this.address,
        this.hash,
        this.direction,
        this.coinName,
        this.coinRate,
        this.recommendName,
        this.outputAmount,
        this.totalAmount,
        this.totalOutputAmount,
        this.orderNum,
        this.dailyProfit,
        this.annualRate});

  RecommendOrdersRows.fromJson(Map<String, dynamic> json) {
    rtId = json['rtId'];
    recommendId = json['recommendId'];
    coinId = json['coinId'];
    dealTime = json['dealTime'];
    amount = json['amount'];
    price = json['price'];
    status = json['status'];
    address = json['address'];
    hash = json['hash'];
    direction = json['direction'];
    coinName = json['coinName'];
    coinRate = json['coinRate'];
    recommendName = json['recommendName'];
    outputAmount = json['outputAmount'];
    totalAmount = json['totalAmount'];
    totalOutputAmount = json['totalOutputAmount'];
    orderNum = json['orderNum'];
    dailyProfit = json['dailyProfit'];
    annualRate = json['annualRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rtId'] = this.rtId;
    data['recommendId'] = this.recommendId;
    data['coinId'] = this.coinId;
    data['dealTime'] = this.dealTime;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['status'] = this.status;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['direction'] = this.direction;
    data['coinName'] = this.coinName;
    data['coinRate'] = this.coinRate;
    data['recommendName'] = this.recommendName;
    data['outputAmount'] = this.outputAmount;
    data['totalAmount'] = this.totalAmount;
    data['totalOutputAmount'] = this.totalOutputAmount;
    data['orderNum'] = this.orderNum;
    data['dailyProfit'] = this.dailyProfit;
    data['annualRate'] = this.annualRate;
    return data;
  }
}
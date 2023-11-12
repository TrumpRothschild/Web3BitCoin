

class MinerHistoryModel {
  int? total;
  List<MinerRows>? rows;
  int? code;
  String? msg;

  MinerHistoryModel({this.total, this.rows, this.code, this.msg});

  MinerHistoryModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <MinerRows>[];
      json['rows'].forEach((v) {
        rows!.add(new MinerRows.fromJson(v));
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

class MinerRows {
  int? mtId;
  int? minerId;
  int? coinId;
  int? month;
  String? dealTime;
  int? amount;
  double? price;
  String? status;
  String? address;
  String? hash;
  String? imgUrl;
  String? outputCoin;
  int? coinRate;
  String? minerName;
  String? minerType;
  String? supportCoinName;
  String? duringType;
  double? outputAmount;
  double? totalAmount;
  String? orderNum;

  MinerRows(
      {this.mtId,
        this.minerId,
        this.coinId,
        this.month,
        this.dealTime,
        this.amount,
        this.price,
        this.status,
        this.address,
        this.hash,
        this.imgUrl,
        this.outputCoin,
        this.coinRate,
        this.minerName,
        this.minerType,
        this.supportCoinName,
        this.duringType,
        this.outputAmount,
        this.totalAmount,
        this.orderNum});

  MinerRows.fromJson(Map<String, dynamic> json) {
    mtId = json['mtId'];
    minerId = json['minerId'];
    coinId = json['coinId'];
    month = json['month'];
    dealTime = json['dealTime'];
    amount = json['amount'];
    price = json['price'];
    status = json['status'];
    address = json['address'];
    hash = json['hash'];
    imgUrl = json['imgUrl'];
    outputCoin = json['outputCoin'];
    coinRate = json['coinRate'];
    minerName = json['minerName'];
    minerType = json['minerType'];
    supportCoinName = json['supportCoinName'];
    duringType = json['duringType'];
    outputAmount = json['outputAmount'];
    totalAmount = json['totalAmount'];
    orderNum = json['orderNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mtId'] = this.mtId;
    data['minerId'] = this.minerId;
    data['coinId'] = this.coinId;
    data['month'] = this.month;
    data['dealTime'] = this.dealTime;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['status'] = this.status;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['imgUrl'] = this.imgUrl;
    data['outputCoin'] = this.outputCoin;
    data['coinRate'] = this.coinRate;
    data['minerName'] = this.minerName;
    data['minerType'] = this.minerType;
    data['supportCoinName'] = this.supportCoinName;
    data['duringType'] = this.duringType;
    data['outputAmount'] = this.outputAmount;
    data['totalAmount'] = this.totalAmount;
    data['orderNum'] = this.orderNum;
    return data;
  }
}
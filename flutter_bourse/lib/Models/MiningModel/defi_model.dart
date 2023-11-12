
class DefiModel {
  int? total;
  List<DefiData>? rows;
  int? code;
  String? msg;

  DefiModel({this.total, this.rows, this.code, this.msg});

  DefiModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <DefiData>[];
      json['rows'].forEach((v) {
        rows!.add(new DefiData.fromJson(v));
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

class DefiData {

  String? createBy;
  String? updateBy;
  String? updateTime;
  int? minerId;
  int? userId;
  int? deptId;
  String? minerName;
  String? hardware;
  int? hashRate;
  int? power;
  String? powerUnit;
  int? expectedEarnings;
  int? cost;
  double? estimatedProfit;
  String? imgUrl;
  double? profitRate;
  double? fee;
  int? total;
  String? minerType;
  String? outputCoin;
  String? algorithmName;
  String? coinPower;
  String? algorithmPower;


  DefiData(
      {
        this.createBy,
        this.updateBy,
        this.updateTime,
        this.minerId,
        this.userId,
        this.deptId,
        this.minerName,
        this.hardware,
        this.hashRate,
        this.power,
        this.powerUnit,
        this.expectedEarnings,
        this.cost,
        this.estimatedProfit,
        this.imgUrl,
        this.profitRate,
        this.fee,
        this.total,
        this.minerType,
        this.outputCoin,
        this.algorithmName,
        this.coinPower,
        this.algorithmPower,
      });

  DefiData.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];

    updateBy = json['updateBy'];
    updateTime = json['updateTime'];

    minerId = json['minerId'];
    userId = json['userId'];
    deptId = json['deptId'];
    minerName = json['minerName'];
    hardware = json['hardware'];
    hashRate = json['hashRate'];

    power = json['power'];
    powerUnit = json['powerUnit'];
    expectedEarnings = json['expectedEarnings'];
    cost = json['cost'];
    estimatedProfit = json['estimatedProfit'];
    imgUrl = json['imgUrl'];
    profitRate = json['profitRate'];
    fee = json['fee'];
    total = json['total'];
    minerType = json['minerType'];
    outputCoin = json['outputCoin'];
    algorithmName = json['algorithmName'];
    coinPower = json['coinPower'];
    algorithmPower = json['algorithmPower'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;

    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;

    data['minerId'] = this.minerId;
    data['userId'] = this.userId;
    data['deptId'] = this.deptId;
    data['minerName'] = this.minerName;
    data['hardware'] = this.hardware;
    data['hashRate'] = this.hashRate;

    data['power'] = this.power;
    data['powerUnit'] = this.powerUnit;
    data['expectedEarnings'] = this.expectedEarnings;
    data['cost'] = this.cost;
    data['estimatedProfit'] = this.estimatedProfit;
    data['imgUrl'] = this.imgUrl;
    data['profitRate'] = this.profitRate;
    data['fee'] = this.fee;
    data['total'] = this.total;
    data['minerType'] = this.minerType;
    data['outputCoin'] = this.outputCoin;
    data['algorithmName'] = this.algorithmName;
    data['coinPower'] = this.coinPower;
    data['algorithmPower'] = this.algorithmPower;

    return data;
  }
}
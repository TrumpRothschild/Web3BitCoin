class KuangjiModel {
  int? total;
  List<KuangjiRows>? rows;
  int? code;
  String? msg;

  KuangjiModel({this.total, this.rows, this.code, this.msg});

  KuangjiModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <KuangjiRows>[];
      json['rows'].forEach((v) {
        rows!.add(new KuangjiRows.fromJson(v));
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

class KuangjiRows {
  String? createBy;

  String? updateBy;
  // String? updateTime;

  int? minerId;
  int? userId;
  int? deptId;
  String? minerName;
  String? hardware;
  int? hashRate;
  String? hashRateUnit;
  int? power;
  String? powerUnit;
  double? expectedEarnings;
  double? cost;
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
  Null? version;

  KuangjiRows(
      {this.createBy,

        this.updateBy,
        // this.updateTime,

        this.minerId,
        this.userId,
        this.deptId,
        this.minerName,
        this.hardware,
        this.hashRate,
        this.hashRateUnit,
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
        // this.version
      });

  KuangjiRows.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];

    updateBy = json['updateBy'];
    // updateTime = json['updateTime'];

    minerId = json['minerId'];
    userId = json['userId'];
    deptId = json['deptId'];
    minerName = json['minerName'];
    hardware = json['hardware'];
    hashRate = json['hashRate'];
    hashRateUnit = json['hashRateUnit'];
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
    // version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;

    data['updateBy'] = this.updateBy;
    // data['updateTime'] = this.updateTime;

    data['minerId'] = this.minerId;
    data['userId'] = this.userId;
    data['deptId'] = this.deptId;
    data['minerName'] = this.minerName;
    data['hardware'] = this.hardware;
    data['hashRate'] = this.hashRate;
    data['hashRateUnit'] = this.hashRateUnit;
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
    data['coinName'] = this.outputCoin;
    data['algorithmName'] = this.algorithmName;
    data['coinPower'] = this.coinPower;
    data['algorithmPower'] = this.algorithmPower;
    // data['version'] = this.version;
    return data;
  }
}
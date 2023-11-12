class MiningInfoModel {
  int? total;

  Data? data;
  int? code;


  MiningInfoModel({this.total, this.data, this.code,});

  MiningInfoModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;

    return data;
  }
}

class Data {
  List<MinerAlgorithm>? minerAlgorithm;
  List<Miner>? miner;

  Data({this.minerAlgorithm, this.miner});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['minerAlgorithm'] != null) {
      minerAlgorithm = <MinerAlgorithm>[];
      json['minerAlgorithm'].forEach((v) {
        minerAlgorithm!.add(new MinerAlgorithm.fromJson(v));
      });
    }
    if (json['miner'] != null) {
      miner = <Miner>[];
      json['miner'].forEach((v) {
        miner!.add(new Miner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.minerAlgorithm != null) {
      data['minerAlgorithm'] =
          this.minerAlgorithm!.map((v) => v.toJson()).toList();
    }
    if (this.miner != null) {
      data['miner'] = this.miner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MinerAlgorithm {
  String? coinType;
  String? computingPower;
  String? algorithmPower;
  String? titleAlgorithm;
  int? cTime;
  int? id;

  MinerAlgorithm(
      {this.coinType,
        this.computingPower,
        this.algorithmPower,
        this.titleAlgorithm,
        this.cTime,
        this.id});

  MinerAlgorithm.fromJson(Map<String, dynamic> json) {
    coinType = json['coinType'];
    computingPower = json['computingPower'];
    algorithmPower = json['algorithmPower'];
    titleAlgorithm = json['titleAlgorithm'];
    cTime = json['c_time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinType'] = this.coinType;
    data['computingPower'] = this.computingPower;
    data['algorithmPower'] = this.algorithmPower;
    data['titleAlgorithm'] = this.titleAlgorithm;
    data['c_time'] = this.cTime;
    data['id'] = this.id;
    return data;
  }
}

class Miner {
  String? profitability;
  String? total;
  String? cost;
  String? expectedProfit;
  String? fee;
  int? cTime;
  String? hashRate;
  int? id;
  String? power;
  String? hardware;
  String? expectedEarnings;

  Miner(
      {this.profitability,
        this.total,
        this.cost,
        this.expectedProfit,
        this.fee,
        this.cTime,
        this.hashRate,
        this.id,
        this.power,
        this.hardware,
        this.expectedEarnings});

  Miner.fromJson(Map<String, dynamic> json) {
    profitability = json['profitability'];
    total = json['total'];
    cost = json['cost'];
    expectedProfit = json['expectedProfit'];
    fee = json['fee'];
    cTime = json['c_time'];
    hashRate = json['hashRate'];
    id = json['id'];
    power = json['power'];
    hardware = json['hardware'];
    expectedEarnings = json['expectedEarnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profitability'] = this.profitability;
    data['total'] = this.total;
    data['cost'] = this.cost;
    data['expectedProfit'] = this.expectedProfit;
    data['fee'] = this.fee;
    data['c_time'] = this.cTime;
    data['hashRate'] = this.hashRate;
    data['id'] = this.id;
    data['power'] = this.power;
    data['hardware'] = this.hardware;
    data['expectedEarnings'] = this.expectedEarnings;
    return data;
  }
}
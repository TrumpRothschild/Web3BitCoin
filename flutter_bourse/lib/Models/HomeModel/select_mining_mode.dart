class SelectMiningModel {
  int? total;

  List<MiningData>? data;
  int? code;


  SelectMiningModel({this.total,this.data, this.code,});

  SelectMiningModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    if (json['data'] != null) {
      data = <MiningData>[];
      json['data'].forEach((v) {
        data!.add(new MiningData.fromJson(v));
      });
    }
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;

    return data;
  }
}

class MiningData {
  int? totalOutput;
  int? userRevenue;
  int? totaolCoin;
  int? total;
  int? banlanceAccount;
  double? walletAccount;
  int? exchange;
  int? id;
  int? participant;
  String? validNode;

  MiningData(
      {this.totalOutput,
        this.userRevenue,
        this.totaolCoin,
        this.total,
        this.banlanceAccount,
        this.walletAccount,
        this.exchange,
        this.id,
        this.participant,
        this.validNode});

  MiningData.fromJson(Map<String, dynamic> json) {
    totalOutput = json['totalOutput'];
    userRevenue = json['userRevenue'];
    totaolCoin = json['totaolCoin'];
    total = json['total'];
    banlanceAccount = json['banlanceAccount'];
    walletAccount = json['walletAccount'];
    exchange = json['exchange'];
    id = json['id'];
    participant = json['participant'];
    validNode = json['validNode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalOutput'] = this.totalOutput;
    data['userRevenue'] = this.userRevenue;
    data['totaolCoin'] = this.totaolCoin;
    data['total'] = this.total;
    data['banlanceAccount'] = this.banlanceAccount;
    data['walletAccount'] = this.walletAccount;
    data['exchange'] = this.exchange;
    data['id'] = this.id;
    data['participant'] = this.participant;
    data['validNode'] = this.validNode;
    return data;
  }
}
class RecommendBalanceModel {
  String? msg;
  int? code;
  RecommendData? data;

  RecommendBalanceModel({this.msg, this.code, this.data});

  RecommendBalanceModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new RecommendData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RecommendData {
  int? totalAmount;
  List<RecommendList>? list;

  RecommendData({this.totalAmount, this.list});

  RecommendData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    if (json['list'] != null) {
      list = <RecommendList>[];
      json['list'].forEach((v) {
        list!.add(new RecommendList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalAmount'] = this.totalAmount;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecommendList {
  int? walletId;
  int? coinId;
  int? balance;
  int? frozenBalance;
  String? address;
  String? coinName;

  RecommendList(
      {this.walletId,
        this.coinId,
        this.balance,
        this.frozenBalance,
        this.address,
        this.coinName});

  RecommendList.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    coinId = json['coinId'];
    balance = json['balance'];
    frozenBalance = json['frozenBalance'];
    address = json['address'];
    coinName = json['coinName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walletId'] = this.walletId;
    data['coinId'] = this.coinId;
    data['balance'] = this.balance;
    data['frozenBalance'] = this.frozenBalance;
    data['address'] = this.address;
    data['coinName'] = this.coinName;
    return data;
  }
}
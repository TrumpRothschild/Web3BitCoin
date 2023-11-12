

class UserModel {
  String? msg;
  int? code;
  UserData? data;

  UserModel({this.msg, this.code, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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

class UserData {
  double? totalAmount;
  List<UserList>? list;

  UserData({this.totalAmount, this.list});

  UserData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    if (json['list'] != null) {
      list = <UserList>[];
      json['list'].forEach((v) {
        list!.add(new UserList.fromJson(v));
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

class UserList {
  int? walletId;
  int? coinId;
  double? balance;
  double? frozenBalance;
  String? address;
  String? coinName;

  UserList(
      {this.walletId,
        this.coinId,
        this.balance,
        this.frozenBalance,
        this.address,
        this.coinName});

  UserList.fromJson(Map<String, dynamic> json) {
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
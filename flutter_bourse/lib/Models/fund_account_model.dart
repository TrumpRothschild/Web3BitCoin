class FundAccountModel {
  String? msg;
  int? code;
  FundData? data;

  FundAccountModel({this.msg, this.code, this.data});

  FundAccountModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new FundData.fromJson(json['data']) : null;
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

class FundData {
  double? totalAmount;
  List<FundAccountList>? list;

  FundData({this.totalAmount, this.list});

  FundData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    if (json['list'] != null) {
      list = <FundAccountList>[];
      json['list'].forEach((v) {
        list!.add(new FundAccountList.fromJson(v));
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

class FundAccountList {
  int? walletId;
  int? coinId;
  double? balance;
  int? frozenBalance;
  String? address;
  String? coinName;
  List<FundProductList>? productList;

  FundAccountList(
      {this.walletId,
        this.coinId,
        this.balance,
        this.frozenBalance,
        this.address,
        this.coinName,
        this.productList});

  FundAccountList.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    coinId = json['coinId'];
    balance = json['balance'];
    frozenBalance = json['frozenBalance'];
    address = json['address'];
    coinName = json['coinName'];
    if (json['productList'] != null) {
      productList = <FundProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new FundProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['walletId'] = this.walletId;
    data['coinId'] = this.coinId;
    data['balance'] = this.balance;
    data['frozenBalance'] = this.frozenBalance;
    data['address'] = this.address;
    data['coinName'] = this.coinName;
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FundProductList {
  double? dailyProfit;
  double? annualProfit;
  int? yesterdayProfit;
  double? weekRate;
  double? outputAmount;
  int? amount;
  String? productName;
  String? dealTime;

  FundProductList(
      {this.dailyProfit,
        this.annualProfit,
        this.yesterdayProfit,
        this.weekRate,
        this.outputAmount,
        this.amount,
        this.productName,
        this.dealTime});

  FundProductList.fromJson(Map<String, dynamic> json) {
    dailyProfit = json['dailyProfit'];
    annualProfit = json['annualProfit'];
    yesterdayProfit = json['yesterdayProfit'];
    weekRate = json['weekRate'];
    outputAmount = json['outputAmount'];
    amount = json['amount'];
    productName = json['productName'];
    dealTime = json['dealTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dailyProfit'] = this.dailyProfit;
    data['annualProfit'] = this.annualProfit;
    data['yesterdayProfit'] = this.yesterdayProfit;
    data['weekRate'] = this.weekRate;
    data['outputAmount'] = this.outputAmount;
    data['amount'] = this.amount;
    data['productName'] = this.productName;
    data['dealTime'] = this.dealTime;
    return data;
  }
}
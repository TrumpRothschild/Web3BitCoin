class RecommendAccountModel {
  String? msg;
  int? code;
  RecommendData? data;

  RecommendAccountModel({this.msg, this.code, this.data});

  RecommendAccountModel.fromJson(Map<String, dynamic> json) {
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
  double? totalAmount;
  List<ListRecommend>? list;

  RecommendData({this.totalAmount, this.list});

  RecommendData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['totalAmount'];
    if (json['list'] != null) {
      list = <ListRecommend>[];
      json['list'].forEach((v) {
        list!.add(new ListRecommend.fromJson(v));
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

class ListRecommend {
  int? walletId;
  int? coinId;
  double? balance;
  double? frozenBalance;
  String? address;
  String? coinName;
  List<RecommendProductList>? productList;

  ListRecommend(
      {this.walletId,
        this.coinId,
        this.balance,
        this.frozenBalance,
        this.address,
        this.coinName,
        this.productList});

  ListRecommend.fromJson(Map<String, dynamic> json) {
    walletId = json['walletId'];
    coinId = json['coinId'];
    balance = json['balance'];
    frozenBalance = json['frozenBalance'];
    address = json['address'];
    coinName = json['coinName'];
    if (json['productList'] != null) {
      productList = <RecommendProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new RecommendProductList.fromJson(v));
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

class RecommendProductList {
  double? dailyProfit;
  int? annualProfit;
  int? yesterdayProfit;
  int? weekRate;
  double? outputAmount;
  int? amount;
  String? productName;
  String? dealTime;

  RecommendProductList(
      {this.dailyProfit,
        this.annualProfit,
        this.yesterdayProfit,
        this.weekRate,
        this.outputAmount,
        this.amount,
        this.productName,
        this.dealTime});

  RecommendProductList.fromJson(Map<String, dynamic> json) {
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
class PositionDetailsModel {
  String? msg;
  int? code;
  Data? data;

  PositionDetailsModel({this.msg, this.code, this.data});

  PositionDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  List<Records>? records;
  int? total;
  int? size;
  int? current;
  // List<Null>? orders;
  bool? optimizeCountSql;
  bool? searchCount;
  String? countId;
  String? maxLimit;
  int? pages;

  Data(
      {this.records,
        this.total,
        this.size,
        this.current,
        // this.orders,
        this.optimizeCountSql,
        this.searchCount,
        this.countId,
        this.maxLimit,
        this.pages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    if (json['orders'] != null) {
      // orders = <Null>[];
      json['orders'].forEach((v) {
        // orders!.add(new Null.fromJson(v));
      });
    }
    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = json['countId'];
    maxLimit = json['maxLimit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    // if (this.orders != null) {
      // data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    // }
    data['optimizeCountSql'] = this.optimizeCountSql;
    data['searchCount'] = this.searchCount;
    data['countId'] = this.countId;
    data['maxLimit'] = this.maxLimit;
    data['pages'] = this.pages;
    return data;
  }
}

class Records {
  int? orderId;
  int? orderNo;
  int? orderType;
  int? orderStatus;
  double? orderMoney;
  int? winLose;
  String? profitMoney;
  int? userId;
  String? userName;
  int? userType;
  String? buyTime;
  String? settleTime;
  int? seconds;
  String? currencyMedium;
  int? productId;
  double? settlePercentage;
  double? fee;
  String? localBuyTime;
  String? localSettleTime;
  double? buyPrice;
  String? settlePrice;
  String? updateBy;
  String? updateTime;
  String? remark;
  String? priority;

  Records(
      {this.orderId,
        this.orderNo,
        this.orderType,
        this.orderStatus,
        this.orderMoney,
        this.winLose,
        this.profitMoney,
        this.userId,
        this.userName,
        this.userType,
        this.buyTime,
        this.settleTime,
        this.seconds,
        this.currencyMedium,
        this.productId,
        this.settlePercentage,
        this.fee,
        this.localBuyTime,
        this.localSettleTime,
        this.buyPrice,
        this.settlePrice,
        this.updateBy,
        this.updateTime,
        this.remark,
        this.priority});

  Records.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    orderType = json['orderType'];
    orderStatus = json['orderStatus'];
    orderMoney = json['orderMoney'];
    winLose = json['winLose'];
    profitMoney = json['profitMoney'];
    userId = json['userId'];
    userName = json['userName'];
    userType = json['userType'];
    buyTime = json['buyTime'];
    settleTime = json['settleTime'];
    seconds = json['seconds'];
    currencyMedium = json['currencyMedium'];
    productId = json['productId'];
    settlePercentage = json['settlePercentage'];
    fee = json['fee'];
    localBuyTime = json['localBuyTime'];
    localSettleTime = json['localSettleTime'];
    buyPrice = json['buyPrice'];
    settlePrice = json['settlePrice'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    remark = json['remark'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['orderType'] = this.orderType;
    data['orderStatus'] = this.orderStatus;
    data['orderMoney'] = this.orderMoney;
    data['winLose'] = this.winLose;
    data['profitMoney'] = this.profitMoney;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userType'] = this.userType;
    data['buyTime'] = this.buyTime;
    data['settleTime'] = this.settleTime;
    data['seconds'] = this.seconds;
    data['currencyMedium'] = this.currencyMedium;
    data['productId'] = this.productId;
    data['settlePercentage'] = this.settlePercentage;
    data['fee'] = this.fee;
    data['localBuyTime'] = this.localBuyTime;
    data['localSettleTime'] = this.localSettleTime;
    data['buyPrice'] = this.buyPrice;
    data['settlePrice'] = this.settlePrice;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['remark'] = this.remark;
    data['priority'] = this.priority;
    return data;
  }
}
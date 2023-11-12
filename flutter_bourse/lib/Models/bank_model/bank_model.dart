class RecordsModel {
  String? msg;
  int? code;
  Data? data;

  RecordsModel({this.msg, this.code, this.data});

  RecordsModel.fromJson(Map<String, dynamic> json) {
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
    // if (json['orders'] != null) {
    //   orders = <Null>[];
    //   json['orders'].forEach((v) {
    // orders!.add(new Null.fromJson(v));
    //   });
    // }
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
  int? id;
  int? userId;
  double? ethAmount;
  double? ethTotalAmount;
  double? usdtAmonut;
  double? usdtTotalAmount;
  String? remark;
  String? createTime;

  double? balance;
  double? curUsdtBalance;
  double? benefitRatio;
  int? orderNo;
  double? amount;
  double? totalAmount;
  double? fee;
  String? createBy;
  String? updateBy;
  String? updateTime;
  int? status;

  Records(
      {this.id,
        this.userId,
        this.ethAmount,
        this.ethTotalAmount,
        this.usdtAmonut,
        this.usdtTotalAmount,
        this.remark,
        this.createTime,
        this.status,
        this.balance,
        this.curUsdtBalance,
        this.benefitRatio,
        this.orderNo,
        this.amount,
        this.totalAmount,
        this.fee,
        this.createBy,
        this.updateBy,
        this.updateTime
      });

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    ethAmount = json['ethAmount'];
    ethTotalAmount = json['ethTotalAmount'];
    usdtAmonut = json['usdtAmonut'];
    usdtTotalAmount = json['usdtTotalAmount'];
    remark = json['remark'];
    createTime = json['createTime'];
    status = json['status'];
    balance = json['balance'];
    curUsdtBalance = json['curUsdtBalance'];
    benefitRatio = json['benefitRatio'];
    amount = json['amount'];
    orderNo = json['orderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['ethAmount'] = this.ethAmount;
    data['ethTotalAmount'] = this.ethTotalAmount;
    data['usdtAmonut'] = this.usdtAmonut;
    data['usdtTotalAmount'] = this.usdtTotalAmount;
    data['remark'] = this.remark;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['balance'] = this.balance;
    data['curUsdtBalance'] = this.curUsdtBalance;
    data['benefitRatio'] = this.benefitRatio;
    data['amount'] = this.amount;
    data['orderNo'] = this.benefitRatio;
    return data;
  }
}
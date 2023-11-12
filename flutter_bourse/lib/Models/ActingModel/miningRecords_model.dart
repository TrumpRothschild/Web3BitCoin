class MiningRecordsModel {
  String? msg;
  int? code;
  Data? data;

  MiningRecordsModel({this.msg, this.code, this.data});

  MiningRecordsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? userName;
  double? balance;
  double? curUsdtBalance;
  double? benefitRatio;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;

  Records(
      {this.id,
        this.userId,
        this.userName,
        this.balance,
        this.curUsdtBalance,
        this.benefitRatio,
        this.createBy,
        this.createTime,
        this.updateBy,
        this.updateTime});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    userName = json['userName'];
    balance = json['balance'];
    curUsdtBalance = json['curUsdtBalance'];
    benefitRatio = json['benefitRatio'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['balance'] = this.balance;
    data['curUsdtBalance'] = this.curUsdtBalance;
    data['benefitRatio'] = this.benefitRatio;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
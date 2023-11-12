class HistoryModel {
  int? total;

  HistoryData? data;
  int? code;


  HistoryModel({this.total,  this.data, this.code,});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    data = json['data'] != null ? new HistoryData.fromJson(json['data']) : null;
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

class HistoryData {
  int? total;
  List<TransactionList>? list;
  int? pageNum;
  int? pageSize;
  int? size;
  int? startRow;
  int? endRow;
  int? pages;
  int? prePage;
  int? nextPage;
  bool? isFirstPage;
  bool? isLastPage;
  bool? hasPreviousPage;
  bool? hasNextPage;
  int? navigatePages;
  List<int>? navigatepageNums;
  int? navigateFirstPage;
  int? navigateLastPage;

  HistoryData(
      {this.total,
        this.list,
        this.pageNum,
        this.pageSize,
        this.size,
        this.startRow,
        this.endRow,
        this.pages,
        this.prePage,
        this.nextPage,
        this.isFirstPage,
        this.isLastPage,
        this.hasPreviousPage,
        this.hasNextPage,
        this.navigatePages,
        this.navigatepageNums,
        this.navigateFirstPage,
        this.navigateLastPage});

  HistoryData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['list'] != null) {
      list = <TransactionList>[];
      json['list'].forEach((v) {
        list!.add(new TransactionList.fromJson(v));
      });
    }
    pageNum = json['pageNum'];
    pageSize = json['pageSize'];
    size = json['size'];
    startRow = json['startRow'];
    endRow = json['endRow'];
    pages = json['pages'];
    prePage = json['prePage'];
    nextPage = json['nextPage'];
    isFirstPage = json['isFirstPage'];
    isLastPage = json['isLastPage'];
    hasPreviousPage = json['hasPreviousPage'];
    hasNextPage = json['hasNextPage'];
    navigatePages = json['navigatePages'];
    navigatepageNums = json['navigatepageNums'].cast<int>();
    navigateFirstPage = json['navigateFirstPage'];
    navigateLastPage = json['navigateLastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['pageNum'] = this.pageNum;
    data['pageSize'] = this.pageSize;
    data['size'] = this.size;
    data['startRow'] = this.startRow;
    data['endRow'] = this.endRow;
    data['pages'] = this.pages;
    data['prePage'] = this.prePage;
    data['nextPage'] = this.nextPage;
    data['isFirstPage'] = this.isFirstPage;
    data['isLastPage'] = this.isLastPage;
    data['hasPreviousPage'] = this.hasPreviousPage;
    data['hasNextPage'] = this.hasNextPage;
    data['navigatePages'] = this.navigatePages;
    data['navigatepageNums'] = this.navigatepageNums;
    data['navigateFirstPage'] = this.navigateFirstPage;
    data['navigateLastPage'] = this.navigateLastPage;
    return data;
  }
}

class TransactionList {
  String? payType;
  int? coinAmount;
  int? balance;
  String? userId;
  String? referenceAnnualized;
  int? cTime;
  String? buyType;
  int? id;
  String? time;
  String? type;
  String? theTerm;

  TransactionList(
      {this.payType,
        this.coinAmount,
        this.balance,
        this.userId,
        this.referenceAnnualized,
        this.cTime,
        this.buyType,
        this.id,
        this.time,
        this.type,
        this.theTerm});

  TransactionList.fromJson(Map<String, dynamic> json) {
    payType = json['payType'];
    coinAmount = json['coinAmount'];
    balance = json['balance'];
    userId = json['user_id'];
    referenceAnnualized = json['ReferenceAnnualized'];
    cTime = json['c_time'];
    buyType = json['buyType'];
    id = json['id'];
    time = json['time'];
    type = json['type'];
    theTerm = json['theTerm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payType'] = this.payType;
    data['coinAmount'] = this.coinAmount;
    data['balance'] = this.balance;
    data['user_id'] = this.userId;
    data['ReferenceAnnualized'] = this.referenceAnnualized;
    data['c_time'] = this.cTime;
    data['buyType'] = this.buyType;
    data['id'] = this.id;
    data['time'] = this.time;
    data['type'] = this.type;
    data['theTerm'] = this.theTerm;
    return data;
  }
}
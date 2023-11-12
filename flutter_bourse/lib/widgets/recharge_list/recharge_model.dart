class RechargeModel {
  int? total;
  List<RechargeRows>? rows;
  int? code;
  String? msg;

  RechargeModel({this.total, this.rows, this.code, this.msg});

  RechargeModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <RechargeRows>[];
      json['rows'].forEach((v) {
        rows!.add(new RechargeRows.fromJson(v));
      });
    }
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}

class RechargeRows {
  int? rechargeId;
  int? userId;
  int? deptId;
  int? coinId;
  String? rechargeType;
  String? address;
  int? amount;
  String? hash;
  String? status;
  String? imgUrl;
  String? orderNum;
  String? createTime;
  String? nickName;
  String? coinName;

  RechargeRows(
      {this.rechargeId,
        this.userId,
        this.deptId,
        this.coinId,
        this.rechargeType,
        this.address,
        this.amount,
        this.hash,
        this.status,
        this.imgUrl,
        this.orderNum,
        this.createTime,
        this.nickName,
        this.coinName});

  RechargeRows.fromJson(Map<String, dynamic> json) {
    rechargeId = json['rechargeId'];
    userId = json['userId'];
    deptId = json['deptId'];
    coinId = json['coinId'];
    rechargeType = json['rechargeType'];
    address = json['address'];
    amount = json['amount'];
    hash = json['hash'];
    status = json['status'];
    imgUrl = json['imgUrl'];
    orderNum = json['orderNum'];
    createTime = json['createTime'];
    nickName = json['nickName'];
    coinName = json['coinName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rechargeId'] = this.rechargeId;
    data['userId'] = this.userId;
    data['deptId'] = this.deptId;
    data['coinId'] = this.coinId;
    data['rechargeType'] = this.rechargeType;
    data['address'] = this.address;
    data['amount'] = this.amount;
    data['hash'] = this.hash;
    data['status'] = this.status;
    data['imgUrl'] = this.imgUrl;
    data['orderNum'] = this.orderNum;
    data['createTime'] = this.createTime;
    data['nickName'] = this.nickName;
    data['coinName'] = this.coinName;
    return data;
  }
}
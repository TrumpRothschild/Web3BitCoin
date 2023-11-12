

class WithdrawHistoryModel {
  int? total;
  List<WithdrawData>? rows;
  int? code;
  String? msg;

  WithdrawHistoryModel({this.total, this.rows, this.code, this.msg});

  WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <WithdrawData>[];
      json['rows'].forEach((v) {
        rows!.add(new WithdrawData.fromJson(v));
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


class WithdrawData {
  int? withdrawId;
  int? userId;
  int? deptId;
  int? coinId;
  String? address;
  double? amount;
  double? arriveAmount;
  double? fee;
  String? status;
  String? orderNum;
  String? withdrawType;
  String? walletType;
  String? unit;
  String? hash;
  String? nickName;
  String? coinName;
  String? createTime;

  WithdrawData(
      {this.withdrawId,
        this.userId,
        this.deptId,
        this.coinId,
        this.address,
        this.amount,
        this.arriveAmount,
        this.fee,
        this.status,
        this.orderNum,
        this.withdrawType,
        this.walletType,
        this.unit,
        this.hash,
        this.nickName,
        this.coinName,
        this.createTime});

  WithdrawData.fromJson(Map<String, dynamic> json) {
    withdrawId = json['withdrawId'];
    userId = json['userId'];
    deptId = json['deptId'];
    coinId = json['coinId'];
    address = json['address'];
    amount = json['amount'];
    arriveAmount = json['arriveAmount'];
    fee = json['fee'];
    status = json['status'];
    orderNum = json['orderNum'];
    withdrawType = json['withdrawType'];
    walletType = json['walletType'];
    unit = json['unit'];
    hash = json['hash'];
    nickName = json['nickName'];
    coinName = json['coinName'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['withdrawId'] = this.withdrawId;
    data['userId'] = this.userId;
    data['deptId'] = this.deptId;
    data['coinId'] = this.coinId;
    data['address'] = this.address;
    data['amount'] = this.amount;
    data['arriveAmount'] = this.arriveAmount;
    data['fee'] = this.fee;
    data['status'] = this.status;
    data['orderNum'] = this.orderNum;
    data['withdrawType'] = this.withdrawType;
    data['walletType'] = this.walletType;
    data['unit'] = this.unit;
    data['hash'] = this.hash;
    data['nickName'] = this.nickName;
    data['coinName'] = this.coinName;
    data['createTime'] = this.createTime;
    return data;
  }
}

class RechargeDataModel {
  String? msg;
  int? code;
  List<RechargeData>? data;
  RechargeDataModel({this.msg, this.code, this.data});
  RechargeDataModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <RechargeData>[];
      json['data'].forEach((v) {
        data!.add(new RechargeData.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RechargeData {
  int? coinId;
  String? coinName;
  String? coinUnit;
  String? address;

  String? status;
  double? fee;
  String? isRecharge;
  String? isWithdraw;
  String? isTransfer;
  String? isAutoWithdraw;

  double? rate;
  String? codeImg;

  RechargeData(
      {this.coinId,
        this.coinName,
        this.coinUnit,
        this.address,

        this.status,
        this.fee,
        this.isRecharge,
        this.isWithdraw,
        this.isTransfer,
        this.isAutoWithdraw,

        this.rate,
        this.codeImg});

  RechargeData.fromJson(Map<String, dynamic> json) {
    coinId = json['coinId'];
    coinName = json['coinName'];
    coinUnit = json['coinUnit'];
    address = json['address'];

    status = json['status'];
    fee = json['fee'];
    isRecharge = json['isRecharge'];
    isWithdraw = json['isWithdraw'];
    isTransfer = json['isTransfer'];
    isAutoWithdraw = json['isAutoWithdraw'];

    rate = json['rate'];
    codeImg = json['codeImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinId'] = this.coinId;
    data['coinName'] = this.coinName;
    data['coinUnit'] = this.coinUnit;
    data['address'] = this.address;

    data['status'] = this.status;
    data['fee'] = this.fee;
    data['isRecharge'] = this.isRecharge;
    data['isWithdraw'] = this.isWithdraw;
    data['isTransfer'] = this.isTransfer;
    data['isAutoWithdraw'] = this.isAutoWithdraw;

    data['rate'] = this.rate;
    data['codeImg'] = this.codeImg;
    return data;
  }
}
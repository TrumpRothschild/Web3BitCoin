class RechargeModel {
  String? msg;
  int? code;
  List<Data>? data;

  RechargeModel({this.msg, this.code, this.data});

  RechargeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? searchValue;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  String? remark;
  int? walletId;
  String? currencyType;
  String? walletLinkName;
  String? linkType;
  String? walletAddress;
  String? walletQrCode;
  String? ico;

  Data(
      {this.searchValue,
        this.createBy,
        this.createTime,
        this.updateBy,
        this.updateTime,
        this.remark,
        this.walletId,
        this.currencyType,
        this.walletLinkName,
        this.linkType,
        this.walletAddress,
        this.walletQrCode,
        this.ico});

  Data.fromJson(Map<String, dynamic> json) {
    searchValue = json['searchValue'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    remark = json['remark'];
    walletId = json['walletId'];
    currencyType = json['currencyType'];
    walletLinkName = json['walletLinkName'];
    linkType = json['linkType'];
    walletAddress = json['walletAddress'];
    walletQrCode = json['walletQrCode'];
    ico = json['ico'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchValue'] = this.searchValue;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['remark'] = this.remark;
    data['walletId'] = this.walletId;
    data['currencyType'] = this.currencyType;
    data['walletLinkName'] = this.walletLinkName;
    data['linkType'] = this.linkType;
    data['walletAddress'] = this.walletAddress;
    data['walletQrCode'] = this.walletQrCode;
    data['ico'] = this.ico;
    return data;
  }
}
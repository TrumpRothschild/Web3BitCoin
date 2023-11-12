class NetworkRechargeModel {
  String? msg;
  int? code;
  List<NetworkRechargeData>? data;

  NetworkRechargeModel({this.msg, this.code, this.data});

  NetworkRechargeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <NetworkRechargeData>[];
      json['data'].forEach((v) {
        data!.add(new NetworkRechargeData.fromJson(v));
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

class NetworkRechargeData {
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;

  int? networkId;
  int? coinId;
  String? name;
  String? status;
  int? sort;
  int? version;

  NetworkRechargeData(
      {this.createBy,
        this.createTime,
        this.updateBy,
        this.updateTime,

        this.networkId,
        this.coinId,
        this.name,
        this.status,
        this.sort,
        this.version});

  NetworkRechargeData.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    networkId = json['networkId'];
    coinId = json['coinId'];
    name = json['name'];
    status = json['status'];
    sort = json['sort'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['networkId'] = this.networkId;
    data['coinId'] = this.coinId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['sort'] = this.sort;
    data['version'] = this.version;
    return data;
  }
}
class MiningModel {
  String? msg;
  int? code;
  List<Data>? data;

  MiningModel({this.msg, this.code, this.data});

  MiningModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? address;
  String? credential;
  int? status;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  String? remark;

  Data(
      {this.id,
        this.address,
        this.credential,
        this.status,
        this.createBy,
        this.createTime,
        this.updateBy,
        this.updateTime,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    credential = json['credential'];
    status = json['status'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateBy = json['updateBy'];
    updateTime = json['updateTime'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['credential'] = this.credential;
    data['status'] = this.status;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;
    data['remark'] = this.remark;
    return data;
  }
}
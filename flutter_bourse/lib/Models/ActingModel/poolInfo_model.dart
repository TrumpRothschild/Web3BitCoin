class PoolInfoModel {
String? msg;
int? code;
Data? data;

PoolInfoModel({this.msg, this.code, this.data});

PoolInfoModel.fromJson(Map<String, dynamic> json) {
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
  int? poolEth;
  int? poolHeight;
  int? duUsers;
  double? duUsersIncome;

  Data({this.poolEth, this.poolHeight, this.duUsers, this.duUsersIncome});

  Data.fromJson(Map<String, dynamic> json) {
    poolEth = json['poolEth'];
    poolHeight = json['poolHeight'];
    duUsers = json['duUsers'];
    duUsersIncome = json['duUsersIncome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poolEth'] = this.poolEth;
    data['poolHeight'] = this.poolHeight;
    data['duUsers'] = this.duUsers;
    data['duUsersIncome'] = this.duUsersIncome;
    return data;
  }
}
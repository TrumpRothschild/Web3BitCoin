class ProductIntroductionModel {
  String? msg;
  int? code;
  ProductIntroductData? data;

  ProductIntroductionModel({this.msg, this.code, this.data});

  ProductIntroductionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new ProductIntroductData.fromJson(json['data']) : null;
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

class ProductIntroductData {
  String? createBy;

  String? updateBy;
  String? updateTime;

  int? recommendId;
  int? userId;
  int? deptId;
  String? recommendName;
  double? profitRate;
  String? apy;
  int? day;

  int? fee;
  String? recommendType;
  String? recommendLevel;
  String? duringType;

  String? lang;
  String? content;

  ProductIntroductData(
      {this.createBy,

        this.updateBy,
        this.updateTime,

        this.recommendId,
        this.userId,
        this.deptId,
        this.recommendName,
        this.profitRate,
        this.apy,
        this.day,

        this.fee,
        this.recommendType,
        this.recommendLevel,
        this.duringType,

        this.lang,
        this.content});

  ProductIntroductData.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'];

    updateBy = json['updateBy'];
    updateTime = json['updateTime'];

    recommendId = json['recommendId'];
    userId = json['userId'];
    deptId = json['deptId'];
    recommendName = json['recommendName'];
    profitRate = json['profitRate'];
    apy = json['apy'];
    day = json['day'];

    fee = json['fee'];
    recommendType = json['recommendType'];
    recommendLevel = json['recommendLevel'];
    duringType = json['duringType'];

    lang = json['lang'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createBy'] = this.createBy;

    data['updateBy'] = this.updateBy;
    data['updateTime'] = this.updateTime;

    data['recommendId'] = this.recommendId;
    data['userId'] = this.userId;
    data['deptId'] = this.deptId;
    data['recommendName'] = this.recommendName;
    data['profitRate'] = this.profitRate;
    data['apy'] = this.apy;
    data['day'] = this.day;

    data['fee'] = this.fee;
    data['recommendType'] = this.recommendType;
    data['recommendLevel'] = this.recommendLevel;
    data['duringType'] = this.duringType;

    data['lang'] = this.lang;
    data['content'] = this.content;
    return data;
  }
}
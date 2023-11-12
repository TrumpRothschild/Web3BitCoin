class ActingModel {
  String? msg;
  int? code;
  Data? data;

  ActingModel({this.msg, this.code, this.data});

  ActingModel.fromJson(Map<String, dynamic> json) {
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
  LevelSumBenefit? levelSumBenefit;
  int? allEth;
  int? groupUserNum;
  LevelSumBenefit? levelSumUser;
  int? userId;

  Data(
      {this.levelSumBenefit,
        this.allEth,
        this.groupUserNum,
        this.levelSumUser,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    levelSumBenefit = json['levelSumBenefit'] != null
        ? new LevelSumBenefit.fromJson(json['levelSumBenefit'])
        : null;
    allEth = json['allEth'];
    groupUserNum = json['groupUserNum'];
    levelSumUser = json['levelSumUser'] != null
        ? new LevelSumBenefit.fromJson(json['levelSumUser'])
        : null;
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.levelSumBenefit != null) {
      data['levelSumBenefit'] = this.levelSumBenefit!.toJson();
    }
    data['allEth'] = this.allEth;
    data['groupUserNum'] = this.groupUserNum;
    if (this.levelSumUser != null) {
      data['levelSumUser'] = this.levelSumUser!.toJson();
    }
    data['userId'] = this.userId;
    return data;
  }
}

class LevelSumBenefit {
  int? i1;
  int? i2;
  int? i3;

  LevelSumBenefit({this.i1, this.i2, this.i3});

  LevelSumBenefit.fromJson(Map<String, dynamic> json) {
    i1 = json['1'];
    i2 = json['2'];
    i3 = json['3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.i1;
    data['2'] = this.i2;
    data['3'] = this.i3;
    return data;
  }
}
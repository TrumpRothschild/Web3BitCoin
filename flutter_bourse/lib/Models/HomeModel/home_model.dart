class HomeModel {
  String? msg;
  int? code;
  Data? data;

  HomeModel({this.msg, this.code, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
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
  Null? savingsSum;
  Null? recommendSum;
  int? fundSum;
  Null? minerSum;

  Data({this.savingsSum, this.recommendSum, this.fundSum, this.minerSum});

  Data.fromJson(Map<String, dynamic> json) {
    savingsSum = json['savingsSum'];
    recommendSum = json['recommendSum'];
    fundSum = json['fundSum'];
    minerSum = json['minerSum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['savingsSum'] = this.savingsSum;
    data['recommendSum'] = this.recommendSum;
    data['fundSum'] = this.fundSum;
    data['minerSum'] = this.minerSum;
    return data;
  }
}
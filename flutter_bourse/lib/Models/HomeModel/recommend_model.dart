


class RecommendModel {
  int? total;
  List<RecommendRows>? rows;
  int? code;
  String? msg;

  RecommendModel({this.total, this.rows, this.code, this.msg});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <RecommendRows>[];
      json['rows'].forEach((v) {
        rows!.add(new RecommendRows.fromJson(v));
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

class RecommendRows {
  int? recommendId;
  String? recommendName;
  double? profitRate;
  String? apy;
  int? day;
  String? description;
  int? fee;
  String? recommendType;
  String? duringType;
  String? content;

  RecommendRows(
      {this.recommendId,
        this.recommendName,
        this.profitRate,
        this.apy,
        this.day,
        this.description,
        this.fee,
        this.recommendType,
        this.duringType,
        this.content
      });

  RecommendRows.fromJson(Map<String, dynamic> json) {
    recommendId = json['recommendId'];
    recommendName = json['recommendName'];
    profitRate = json['profitRate'];
    apy = json['apy'];
    day = json['day'];
    description = json['description'];
    fee = json['fee'];
    recommendType = json['recommendType'];
    duringType = json['duringType'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recommendId'] = this.recommendId;
    data['recommendName'] = this.recommendName;
    data['profitRate'] = this.profitRate;
    data['apy'] = this.apy;
    data['day'] = this.day;
    data['description'] = this.description;
    data['fee'] = this.fee;
    data['recommendType'] = this.recommendType;
    data['duringType'] = this.duringType;
    data['content'] = this.content;
    return data;
  }
}
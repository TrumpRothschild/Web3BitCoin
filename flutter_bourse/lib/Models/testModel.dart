import 'package:flutter_bourse/Models/tradeModel.dart';

class ResponseTradeSnapShot {
  String? msg;
  int? code;
  innerData? data;

  ResponseTradeSnapShot({this.msg, this.code, this.data});

  ResponseTradeSnapShot.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new innerData.fromJson(json['data']) : null;
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

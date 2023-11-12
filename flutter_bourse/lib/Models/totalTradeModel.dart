import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TotalTradeModel {
  final String? msg;
  final int? code;
  final Map<String, dynamic>? data;
  TotalTradeModel({
    this.msg,
    this.code,
    this.data,
  });

  TotalTradeModel copyWith({
    String? msg,
    int? code,
    Map<String, dynamic>? data,
  }) {
    return TotalTradeModel(
      msg: msg ?? this.msg,
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'msg': msg,
      'code': code,
      'data': data,
    };
  }

  factory TotalTradeModel.fromMap(Map<String, dynamic> map) {
    return TotalTradeModel(
      msg: map['msg'] != null ? map['msg'] as String : null,
      code: map['code'] != null ? map['code'] as int : null,
      data: map['data'] != null
          ? Map<String, dynamic>.from((map['data'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TotalTradeModel.fromJson(String source) =>
      TotalTradeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FindTradeModel(msg: $msg, code: $code, data: $data)';

  @override
  bool operator ==(covariant TotalTradeModel other) {
    if (identical(this, other)) return true;

    return other.msg == msg &&
        other.code == code &&
        mapEquals(other.data, data);
  }

  @override
  int get hashCode => msg.hashCode ^ code.hashCode ^ data.hashCode;
}

class Symbols {
  static List<String> symbolList = [];

  String getByPosition(int pos) => symbolList[pos];
}

class innerTradeDataListModel {
  static List<Rx<TradeData>> tradeDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Rx<TradeData> getByPosition(int pos) => tradeDataList[pos];
}

class TradeData {
  final int? date;
  final double? amount;
  final double? price;
  final String? type;
  TradeData({
    this.date,
    this.amount,
    this.price,
    this.type,
  });

  TradeData copyWith({
    int? date,
    double? amount,
    double? price,
    String? type,
  }) {
    return TradeData(
      date: date ?? this.date,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'amount': amount,
      'price': price,
      'type': type,
    };
  }

  factory TradeData.fromMap(Map<String, dynamic> map) {
    return TradeData(
      date: map['date'] != null ? map['date'] as int : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      price: map['price'] != null ? map['price'] as double : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeData.fromJson(String source) =>
      TradeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TradeData(date: $date, amount: $amount, price: $price, type: $type)';
  }

  @override
  bool operator ==(covariant TradeData other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.amount == amount &&
        other.price == price &&
        other.type == type;
  }

  @override
  int get hashCode {
    return date.hashCode ^ amount.hashCode ^ price.hashCode ^ type.hashCode;
  }
}

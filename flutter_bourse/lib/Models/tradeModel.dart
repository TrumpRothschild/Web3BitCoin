import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FindTradeModel {
  final String? msg;
  final int? code;
  final Map<String, dynamic>? data;
  FindTradeModel({
    this.msg,
    this.code,
    this.data,
  });

  FindTradeModel copyWith({
    String? msg,
    int? code,
    Map<String, dynamic>? data,
  }) {
    return FindTradeModel(
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

  factory FindTradeModel.fromMap(Map<String, dynamic> map) {
    return FindTradeModel(
      msg: map['msg'] != null ? map['msg'] as String : null,
      code: map['code'] != null ? map['code'] as int : null,
      data: map['data'] != null
          ? Map<String, dynamic>.from((map['data'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FindTradeModel.fromJson(String source) =>
      FindTradeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FindTradeModel(msg: $msg, code: $code, data: $data)';

  @override
  bool operator ==(covariant FindTradeModel other) {
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

class innerDataListModel {
  static List<Rx<innerData>> tradeDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Rx<innerData> getByPosition(int pos) => tradeDataList[pos];
}

class innerData {
  final String? symbol;
  final int? count;
  final double? priceChange;
  final double? openPrice;
  final int? lastId;
  final int? firstId;
  final double? volume;
  final double? quoteVolume;
  final double? weightedAvgPrice;
  final double? highPrice;
  final double? lowPrice;
  final int? closeTime;
  final int? openTime;
  final double? lastPrice;
  final String? priceChangePercent;
  final double? lastQuantity;
  innerData({
    this.symbol,
    this.count,
    this.priceChange,
    this.openPrice,
    this.lastId,
    this.firstId,
    this.volume,
    this.quoteVolume,
    this.weightedAvgPrice,
    this.highPrice,
    this.lowPrice,
    this.closeTime,
    this.openTime,
    this.lastPrice,
    this.priceChangePercent,
    this.lastQuantity,
  });

  innerData copyWith({
    String? symbol,
    int? count,
    double? priceChange,
    double? openPrice,
    int? lastId,
    int? firstId,
    double? volume,
    double? quoteVolume,
    double? weightedAvgPrice,
    double? highPrice,
    double? lowPrice,
    int? closeTime,
    int? openTime,
    double? lastPrice,
    String? priceChangePercent,
    double? lastQuantity,
  }) {
    return innerData(
        symbol: symbol ?? this.symbol,
        count: count ?? this.count,
        priceChange: priceChange ?? this.priceChange,
        openPrice: openPrice ?? this.openPrice,
        lastId: lastId ?? this.lastId,
        firstId: firstId ?? this.firstId,
        volume: volume ?? this.volume,
        quoteVolume: quoteVolume ?? this.quoteVolume,
        weightedAvgPrice: weightedAvgPrice ?? this.weightedAvgPrice,
        highPrice: highPrice ?? this.highPrice,
        lowPrice: lowPrice ?? this.lowPrice,
        closeTime: closeTime ?? this.closeTime,
        openTime: openTime ?? this.openTime,
        lastPrice: lastPrice ?? this.lastPrice,
        priceChangePercent: priceChangePercent ?? this.priceChangePercent,
        lastQuantity: lastQuantity ?? this.lastQuantity);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symbol': symbol,
      'count': count,
      'priceChange': priceChange,
      'openPrice': openPrice,
      'lastId': lastId,
      'firstId': firstId,
      'volume': volume,
      'quoteVolume': quoteVolume,
      'weightedAvgPrice': weightedAvgPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'closeTime': closeTime,
      'openTime': openTime,
      'lastPrice': lastPrice,
      'priceChangePercent': priceChangePercent,
      'lastQuantity': lastQuantity,
    };
  }

  factory innerData.fromMap(Map<String, dynamic> map) {
    return innerData(
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
      priceChange:
          map['priceChange'] != null ? map['priceChange'] as double : null,
      openPrice: map['openPrice'] != null ? map['openPrice'] as double : null,
      lastId: map['lastId'] != null ? map['lastId'] as int : null,
      firstId: map['firstId'] != null ? map['firstId'] as int : null,
      volume: map['volume'] != null ? map['volume'] as double : null,
      quoteVolume:
          map['quoteVolume'] != null ? map['quoteVolume'] as double : null,
      weightedAvgPrice: map['weightedAvgPrice'] != null
          ? map['weightedAvgPrice'] as double
          : null,
      highPrice: map['highPrice'] != null ? map['highPrice'] as double : null,
      lowPrice: map['lowPrice'] != null ? map['lowPrice'] as double : null,
      closeTime: map['closeTime'] != null ? map['closeTime'] as int : null,
      openTime: map['openTime'] != null ? map['openTime'] as int : null,
      lastPrice: map['lastPrice'] != null ? map['lastPrice'] as double : null,
      priceChangePercent: map['priceChangePercent'] != null
          ? map['priceChangePercent'] as String
          : null,
      lastQuantity:
          map['lastQuantity'] != null ? map['lastQuantity'] as double : null,
    );
  }

  factory innerData.fromAdapterMap(Map<String, dynamic> map) {
    return innerData(
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      count: map['totalTrades'] != null ? map['totalTrades'] as int : null,
      priceChange:
          map['priceChange'] != null ? double.parse(map['priceChange']) : null,
      openPrice:
          map['openPrice'] != null ? double.parse(map['openPrice']) : null,
      lastId: map['lastTradeID'] != null ? map['lastTradeID'] as int : null,
      firstId: map['firstTradeID'] != null ? map['firstTradeID'] as int : null,
      volume: map['totalTradeBaseAssetVol'] != null
          ? double.parse(map['totalTradeBaseAssetVol'])
          : null,
      quoteVolume: map['totalTradeQuoteAssetVol'] != null
          ? double.parse(map['totalTradeQuoteAssetVol'])
          : null,
      weightedAvgPrice: map['weightedAveragePrice'] != null
          ? double.parse(map['weightedAveragePrice'])
          : null,
      highPrice:
          map['highPrice'] != null ? double.parse(map['highPrice']) : null,
      lowPrice: map['lowPrice'] != null ? double.parse(map['lowPrice']) : null,
      closeTime: map['statisticsCloseTime'] != null
          ? map['statisticsCloseTime'] as int
          : null,
      openTime: map['statisticsOpenTime'] != null
          ? map['statisticsOpenTime'] as int
          : null,
      lastPrice:
          map['lastPrice'] != null ? double.parse(map['lastPrice']) : null,
      priceChangePercent: map['priceChangePercentage'] != null
          ? map['priceChangePercentage'] as String
          : null,
      lastQuantity: map['lastQuantity'] != null
          ? double.parse(map['lastQuantity'])
          : null,
    );
  }
  String toJson() => json.encode(toMap());

  factory innerData.fromJson(String source) =>
      innerData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'innerData(symbol: $symbol, count: $count, priceChange: $priceChange, openPrice: $openPrice, lastId: $lastId, firstId: $firstId, volume: $volume, quoteVolume: $quoteVolume, weightedAvgPrice: $weightedAvgPrice, highPrice: $highPrice, lowPrice: $lowPrice, closeTime: $closeTime, openTime: $openTime, lastPrice: $lastPrice, priceChangePercent: $priceChangePercent,lastQuantity: $lastQuantity)';
  }

  @override
  bool operator ==(covariant innerData other) {
    if (identical(this, other)) return true;

    return other.symbol == symbol &&
        other.count == count &&
        other.priceChange == priceChange &&
        other.openPrice == openPrice &&
        other.lastId == lastId &&
        other.firstId == firstId &&
        other.volume == volume &&
        other.quoteVolume == quoteVolume &&
        other.weightedAvgPrice == weightedAvgPrice &&
        other.highPrice == highPrice &&
        other.lowPrice == lowPrice &&
        other.closeTime == closeTime &&
        other.openTime == openTime &&
        other.lastPrice == lastPrice &&
        other.priceChangePercent == priceChangePercent &&
        other.lastQuantity == lastQuantity;
  }

  @override
  int get hashCode {
    return symbol.hashCode ^
        count.hashCode ^
        priceChange.hashCode ^
        openPrice.hashCode ^
        lastId.hashCode ^
        firstId.hashCode ^
        volume.hashCode ^
        quoteVolume.hashCode ^
        weightedAvgPrice.hashCode ^
        highPrice.hashCode ^
        lowPrice.hashCode ^
        closeTime.hashCode ^
        openTime.hashCode ^
        lastPrice.hashCode ^
        priceChangePercent.hashCode ^
        lastQuantity.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class binanceTradedataWebSocketModel {
  static List<BinanceWSTradeData> binanceWebSocektradeDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  BinanceWSTradeData getByPosition(int pos) =>
      binanceWebSocektradeDataList[pos];
}

class BinanceWSTradeData {
  final String? eventType;
  final int? eventTime;
  final String? symbol;
  final String? priceChange;
  final String? priceChangePercentage;
  final String? weightedAveragePrice;
  final String? lastPrice;
  final String? lastQuantity;
  final String? openPrice;
  final String? highPrice;
  final String? lowPrice;
  final String? totalTradeBaseAssetVol;
  final String? totalTradeQuoteAssetVol;
  final int? statisticsOpenTime;
  final int? statisticsCloseTime;
  final int? firstTradeID;
  final int? lastTradeID;
  final int? totalTrades;
  BinanceWSTradeData({
    this.eventType,
    this.eventTime,
    this.symbol,
    this.priceChange,
    this.priceChangePercentage,
    this.weightedAveragePrice,
    this.lastPrice,
    this.lastQuantity,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.totalTradeBaseAssetVol,
    this.totalTradeQuoteAssetVol,
    this.statisticsOpenTime,
    this.statisticsCloseTime,
    this.firstTradeID,
    this.lastTradeID,
    this.totalTrades,
  });

  BinanceWSTradeData copyWith({
    String? eventType,
    int? eventTime,
    String? symbol,
    String? priceChange,
    String? priceChangePercentage,
    String? weightedAveragePrice,
    String? lastPrice,
    String? lastQuantity,
    String? openPrice,
    String? highPrice,
    String? lowPrice,
    String? totalTradeBaseAssetVol,
    String? totalTradeQuoteAssetVol,
    int? statisticsOpenTime,
    int? statisticsCloseTime,
    int? firstTradeID,
    int? lastTradeID,
    int? totalTrades,
  }) {
    return BinanceWSTradeData(
      eventType: eventType ?? this.eventType,
      eventTime: eventTime ?? this.eventTime,
      symbol: symbol ?? this.symbol,
      priceChange: priceChange ?? this.priceChange,
      priceChangePercentage:
          priceChangePercentage ?? this.priceChangePercentage,
      weightedAveragePrice: weightedAveragePrice ?? this.weightedAveragePrice,
      lastPrice: lastPrice ?? this.lastPrice,
      lastQuantity: lastQuantity ?? this.lastQuantity,
      openPrice: openPrice ?? this.openPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      totalTradeBaseAssetVol:
          totalTradeBaseAssetVol ?? this.totalTradeBaseAssetVol,
      totalTradeQuoteAssetVol:
          totalTradeQuoteAssetVol ?? this.totalTradeQuoteAssetVol,
      statisticsOpenTime: statisticsOpenTime ?? this.statisticsOpenTime,
      statisticsCloseTime: statisticsCloseTime ?? this.statisticsCloseTime,
      firstTradeID: firstTradeID ?? this.firstTradeID,
      lastTradeID: lastTradeID ?? this.lastTradeID,
      totalTrades: totalTrades ?? this.totalTrades,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventType': eventType,
      'eventTime': eventTime,
      'symbol': symbol,
      'priceChange': priceChange,
      'priceChangePercentage': priceChangePercentage,
      'weightedAveragePrice': weightedAveragePrice,
      'lastPrice': lastPrice,
      'lastQuantity': lastQuantity,
      'openPrice': openPrice,
      'highPrice': highPrice,
      'lowPrice': lowPrice,
      'totalTradeBaseAssetVol': totalTradeBaseAssetVol,
      'totalTradeQuoteAssetVol': totalTradeQuoteAssetVol,
      'statisticsOpenTime': statisticsOpenTime,
      'statisticsCloseTime': statisticsCloseTime,
      'firstTradeID': firstTradeID,
      'lastTradeID': lastTradeID,
      'totalTrades': totalTrades,
    };
  }

  factory BinanceWSTradeData.fromMap(Map<String, dynamic> map) {
    return BinanceWSTradeData(
      eventType: map['e'] != null ? map['e'] as String : null,
      eventTime: map['E'] != null ? map['E'] as int : null,
      symbol: map['s'] != null ? map['s'] as String : null,
      priceChange: map['p'] != null ? map['p'] as String : null,
      priceChangePercentage: map['P'] != null ? map['P'] as String : null,
      weightedAveragePrice: map['w'] != null ? map['w'] as String : null,
      lastPrice: map['c'] != null ? map['c'] as String : null,
      lastQuantity: map['Q'] != null ? map['Q'] as String : null,
      openPrice: map['o'] != null ? map['o'] as String : null,
      highPrice: map['h'] != null ? map['h'] as String : null,
      lowPrice: map['l'] != null ? map['l'] as String : null,
      totalTradeBaseAssetVol: map['v'] != null ? map['v'] as String : null,
      totalTradeQuoteAssetVol: map['q'] != null ? map['q'] as String : null,
      statisticsOpenTime: map['O'] != null ? map['O'] as int : null,
      statisticsCloseTime: map['C'] != null ? map['C'] as int : null,
      firstTradeID: map['F'] != null ? map['F'] as int : null,
      lastTradeID: map['L'] != null ? map['L'] as int : null,
      totalTrades: map['n'] != null ? map['n'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BinanceWSTradeData.fromJson(String source) =>
      BinanceWSTradeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BinanceWSTradeData(eventType: $eventType, eventTime: $eventTime, symbol: $symbol, priceChange: $priceChange, priceChangePercentage: $priceChangePercentage, weightedAveragePrice: $weightedAveragePrice, lastPrice: $lastPrice, lastQuantity: $lastQuantity, openPrice: $openPrice, highPrice: $highPrice, lowPrice: $lowPrice, totalTradeBaseAssetVol: $totalTradeBaseAssetVol, totalTradeQuoteAssetVol: $totalTradeQuoteAssetVol, statisticsOpenTime: $statisticsOpenTime, statisticsCloseTime: $statisticsCloseTime, firstTradeID: $firstTradeID, lastTradeID: $lastTradeID, totalTrades: $totalTrades)';
  }

  @override
  bool operator ==(covariant BinanceWSTradeData other) {
    if (identical(this, other)) return true;

    return other.eventType == eventType &&
        other.eventTime == eventTime &&
        other.symbol == symbol &&
        other.priceChange == priceChange &&
        other.priceChangePercentage == priceChangePercentage &&
        other.weightedAveragePrice == weightedAveragePrice &&
        other.lastPrice == lastPrice &&
        other.lastQuantity == lastQuantity &&
        other.openPrice == openPrice &&
        other.highPrice == highPrice &&
        other.lowPrice == lowPrice &&
        other.totalTradeBaseAssetVol == totalTradeBaseAssetVol &&
        other.totalTradeQuoteAssetVol == totalTradeQuoteAssetVol &&
        other.statisticsOpenTime == statisticsOpenTime &&
        other.statisticsCloseTime == statisticsCloseTime &&
        other.firstTradeID == firstTradeID &&
        other.lastTradeID == lastTradeID &&
        other.totalTrades == totalTrades;
  }

  @override
  int get hashCode {
    return eventType.hashCode ^
        eventTime.hashCode ^
        symbol.hashCode ^
        priceChange.hashCode ^
        priceChangePercentage.hashCode ^
        weightedAveragePrice.hashCode ^
        lastPrice.hashCode ^
        lastQuantity.hashCode ^
        openPrice.hashCode ^
        highPrice.hashCode ^
        lowPrice.hashCode ^
        totalTradeBaseAssetVol.hashCode ^
        totalTradeQuoteAssetVol.hashCode ^
        statisticsOpenTime.hashCode ^
        statisticsCloseTime.hashCode ^
        firstTradeID.hashCode ^
        lastTradeID.hashCode ^
        totalTrades.hashCode;
  }
}

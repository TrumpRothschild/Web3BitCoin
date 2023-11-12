// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

class innerDataListBinanceAdapterModel {
  static List<Rx<innerDataBinance>> tradeDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Rx<innerDataBinance> getByPosition(int pos) => tradeDataList[pos];
}

class innerDataBinance {
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
  innerDataBinance({
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
  });

  innerDataBinance copyWith({
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
  }) {
    return innerDataBinance(
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
    );
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
    };
  }

  factory innerDataBinance.fromMap(Map<String, dynamic> map) {
    return innerDataBinance(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory innerDataBinance.fromJson(String source) =>
      innerDataBinance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'innerDataBinance(symbol: $symbol, count: $count, priceChange: $priceChange, openPrice: $openPrice, lastId: $lastId, firstId: $firstId, volume: $volume, quoteVolume: $quoteVolume, weightedAvgPrice: $weightedAvgPrice, highPrice: $highPrice, lowPrice: $lowPrice, closeTime: $closeTime, openTime: $openTime, lastPrice: $lastPrice, priceChangePercent: $priceChangePercent)';
  }

  @override
  bool operator ==(covariant innerDataBinance other) {
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
        other.priceChangePercent == priceChangePercent;
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
        priceChangePercent.hashCode;
  }
}

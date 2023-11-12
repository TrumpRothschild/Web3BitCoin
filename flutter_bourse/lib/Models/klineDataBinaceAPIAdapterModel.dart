// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KlineBinanceAPIDataModel {
  static List<KlineBinanceAPIData> KlineBinaceAPIDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  KlineBinanceAPIData getByPosition(int pos) => KlineBinaceAPIDataList[pos];
}

class KlineBinanceAPIData {
  int? KTime;
  double? closingPrice;
  int? closingTime;
  String? dealPair;
  double? dealQuantity;
  double? floorPrice;
  String? ktype;
  double? openingPrice;
  int? openingTime;
  double? topPrice;
  KlineBinanceAPIData({
    this.KTime,
    this.closingPrice,
    this.closingTime,
    this.dealPair,
    this.dealQuantity,
    this.floorPrice,
    this.ktype,
    this.openingPrice,
    this.openingTime,
    this.topPrice,
  });

  KlineBinanceAPIData copyWith({
    int? KTime,
    double? closingPrice,
    int? closingTime,
    String? dealPair,
    double? dealQuantity,
    double? floorPrice,
    String? ktype,
    double? openingPrice,
    int? openingTime,
    double? topPrice,
  }) {
    return KlineBinanceAPIData(
      KTime: KTime ?? this.KTime,
      closingPrice: closingPrice ?? this.closingPrice,
      closingTime: closingTime ?? this.closingTime,
      dealPair: dealPair ?? this.dealPair,
      dealQuantity: dealQuantity ?? this.dealQuantity,
      floorPrice: floorPrice ?? this.floorPrice,
      ktype: ktype ?? this.ktype,
      openingPrice: openingPrice ?? this.openingPrice,
      openingTime: openingTime ?? this.openingTime,
      topPrice: topPrice ?? this.topPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'KTime': KTime,
      'closingPrice': closingPrice,
      'closingTime': closingTime,
      'dealPair': dealPair,
      'dealQuantity': dealQuantity,
      'floorPrice': floorPrice,
      'ktype': ktype,
      'openingPrice': openingPrice,
      'openingTime': openingTime,
      'topPrice': topPrice,
    };
  }

  factory KlineBinanceAPIData.fromMap(
      List<dynamic> map, String dealPair, String ktype) {
    return KlineBinanceAPIData(
      KTime: map[0] != null ? map[0] as int : null,
      closingPrice: double.parse(map[4]) != null
          ? (double.parse(map[4])) == 0
              ? 0.0
              : (double.parse(map[4]) as double)
          : null,
      closingTime: map[6] != null ? map[6] as int : null,
      dealPair: dealPair,
      dealQuantity:
          double.parse(map[5]) != null ? double.parse(map[5]) as double : null,
      floorPrice: double.parse(map[3]) != null
          ? (double.parse(map[3]) == 0 ? 0.0 : double.parse(map[3]) as double)
          : null,
      ktype: ktype != null ? ktype : null,
      openingPrice: double.parse(map[1]) != null
          ? (double.parse(map[1]) == 0 ? 0.0 : double.parse(map[1]) as double)
          : null,
      openingTime: map[0] != null ? map[0] as int : null,
      topPrice:
          double.parse(map[2]) != null ? double.parse(map[2]) as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KlineBinanceAPIData.fromJson(
          List<dynamic> source, String dealpair, String ktype) =>
      KlineBinanceAPIData.fromMap(source, dealpair, ktype);

  @override
  String toString() {
    return 'KlineBinanceAPIData(KTime: $KTime, closingPrice: $closingPrice, closingTime: $closingTime, dealPair: $dealPair, dealQuantity: $dealQuantity, floorPrice: $floorPrice, ktype: $ktype, openingPrice: $openingPrice, openingTime: $openingTime, topPrice: $topPrice)';
  }

  @override
  bool operator ==(covariant KlineBinanceAPIData other) {
    if (identical(this, other)) return true;

    return other.KTime == KTime &&
        other.closingPrice == closingPrice &&
        other.closingTime == closingTime &&
        other.dealPair == dealPair &&
        other.dealQuantity == dealQuantity &&
        other.floorPrice == floorPrice &&
        other.ktype == ktype &&
        other.openingPrice == openingPrice &&
        other.openingTime == openingTime &&
        other.topPrice == topPrice;
  }

  @override
  int get hashCode {
    return KTime.hashCode ^
        closingPrice.hashCode ^
        closingTime.hashCode ^
        dealPair.hashCode ^
        dealQuantity.hashCode ^
        floorPrice.hashCode ^
        ktype.hashCode ^
        openingPrice.hashCode ^
        openingTime.hashCode ^
        topPrice.hashCode;
  }
}

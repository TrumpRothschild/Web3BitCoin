// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KlineDataModel {
  static List<KlineData> KlineDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  KlineData getByPosition(int pos) => KlineDataList[pos];
}

class KlineData {
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
  KlineData({
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

  KlineData copyWith({
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
    return KlineData(
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

  factory KlineData.fromMap(Map<String, dynamic> map) {
    return KlineData(
      KTime: map['KTime'] != null ? map['KTime'] as int : null,
      closingPrice: map['closingPrice'] != null
          ? (map['closingPrice'] == 0 ? 0.0 : map['closingPrice'] as double)
          : null,
      closingTime:
          map['closingTime'] != null ? map['closingTime'] as int : null,
      dealPair: map['dealPair'] != null ? map['dealPair'] as String : null,
      dealQuantity:
          map['dealQuantity'] != null ? map['dealQuantity'] as double : null,
      floorPrice: map['floorPrice'] != null
          ? (map['floorPrice'] == 0 ? 0.0 : map['floorPrice'] as double)
          : null,
      ktype: map['ktype'] != null ? map['ktype'] as String : null,
      openingPrice: map['openingPrice'] != null
          ? (map['openingPrice'] == 0 ? 0.0 : map['openingPrice'] as double)
          : null,
      openingTime:
          map['openingTime'] != null ? map['openingTime'] as int : null,
      topPrice: map['topPrice'] != null ? map['topPrice'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KlineData.fromJson(String source) =>
      KlineData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KlineData(KTime: $KTime, closingPrice: $closingPrice, closingTime: $closingTime, dealPair: $dealPair, dealQuantity: $dealQuantity, floorPrice: $floorPrice, ktype: $ktype, openingPrice: $openingPrice, openingTime: $openingTime, topPrice: $topPrice)';
  }

  @override
  bool operator ==(covariant KlineData other) {
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

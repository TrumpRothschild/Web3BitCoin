// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuyUtilsModel {
  static List<BuyUtils> buyUtilsList = [];
  BuyUtils getByPosition(int pos) => buyUtilsList[pos];
}

class BuyUtils {
  final String? time;
  final double? profitRate;
  final int? minAmount;
  final int? maxAmount;
  BuyUtils({
    this.time,
    this.profitRate,
    this.minAmount,
    this.maxAmount,
  });

  BuyUtils copyWith({
    String? time,
    double? profitRate,
    int? minAmount,
    int? maxAmount,
  }) {
    return BuyUtils(
      time: time ?? this.time,
      profitRate: profitRate ?? this.profitRate,
      minAmount: minAmount ?? this.minAmount,
      maxAmount: maxAmount ?? this.maxAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time,
      'profitRate': profitRate,
      'minAmount': minAmount,
      'maxAmount': maxAmount,
    };
  }

  factory BuyUtils.fromMap(Map<String, dynamic> map) {
    return BuyUtils(
      time: map['time'] != null ? map['time'] as String : null,
      profitRate:
          map['profitRate'] != null ? map['profitRate'] as double : null,
      minAmount: map['minAmount'] != null ? map['minAmount'] as int : null,
      maxAmount: map['maxAmount'] != null ? map['maxAmount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyUtils.fromJson(String source) =>
      BuyUtils.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyUtils(time: $time, profitRate: $profitRate, minAmount: $minAmount, maxAmount: $maxAmount)';
  }

  @override
  bool operator ==(covariant BuyUtils other) {
    if (identical(this, other)) return true;

    return other.time == time &&
        other.profitRate == profitRate &&
        other.minAmount == minAmount &&
        other.maxAmount == maxAmount;
  }

  @override
  int get hashCode {
    return time.hashCode ^
        profitRate.hashCode ^
        minAmount.hashCode ^
        maxAmount.hashCode;
  }
}

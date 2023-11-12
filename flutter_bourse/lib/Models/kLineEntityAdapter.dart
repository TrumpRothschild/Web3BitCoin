// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KLineEntityAdapterList {
  static List<KLineEntityAdapter> KlineList = [];
  KLineEntityAdapter getByPosition(int pos) => KlineList[pos];
}

class KLineEntityAdapter {
  final double open;
  final double high;
  final double low;
  final double close;
  final double vol;
  final double? amount;
  final double? change;
  final double? ratio;
  final int? time;
  KLineEntityAdapter({
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.vol,
    this.amount,
    this.change,
    this.ratio,
    this.time,
  });

  KLineEntityAdapter copyWith({
    double? open,
    double? high,
    double? low,
    double? close,
    double? vol,
    double? amount,
    double? change,
    double? ratio,
    int? time,
  }) {
    return KLineEntityAdapter(
      open: open ?? this.open,
      high: high ?? this.high,
      low: low ?? this.low,
      close: close ?? this.close,
      vol: vol ?? this.vol,
      amount: amount ?? this.amount,
      change: change ?? this.change,
      ratio: ratio ?? this.ratio,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'open': open,
      'high': high,
      'low': low,
      'close': close,
      'vol': vol,
      'amount': amount,
      'change': change,
      'ratio': ratio,
      'time': time,
    };
  }

  factory KLineEntityAdapter.fromMap(Map<String, dynamic> map) {
    return KLineEntityAdapter(
      open: map['openingPrice'] == 0 ? 0.0 : map['openingPrice'] as double,
      high: map['topPrice'] as double,
      low: map['floorPrice'] as double,
      close: map['closingPrice'] as double,
      vol: map['dealQuantity'] as double,
      amount: map['amount'] != null ? map['amount'] as double : null,
      change: map['change'] != null ? map['change'] as double : null,
      ratio: map['ratio'] != null ? map['ratio'] as double : null,
      time: map['KTime'] != null ? map['KTime'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory KLineEntityAdapter.fromJson(String source) =>
      KLineEntityAdapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'KLineEntity(open: $open, high: $high, low: $low, close: $close, vol: $vol, amount: $amount, change: $change, ratio: $ratio, time: $time)';
  }

  @override
  bool operator ==(covariant KLineEntityAdapter other) {
    if (identical(this, other)) return true;

    return other.open == open &&
        other.high == high &&
        other.low == low &&
        other.close == close &&
        other.vol == vol &&
        other.amount == amount &&
        other.change == change &&
        other.ratio == ratio &&
        other.time == time;
  }

  @override
  int get hashCode {
    return open.hashCode ^
        high.hashCode ^
        low.hashCode ^
        close.hashCode ^
        vol.hashCode ^
        amount.hashCode ^
        change.hashCode ^
        ratio.hashCode ^
        time.hashCode;
  }
}

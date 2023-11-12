// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class transactionTimeRateModel {
  static List<timeRateCombinationModel> buyUtilsList = [];
  timeRateCombinationModel getByPosition(int pos) => buyUtilsList[pos];
}

class timeRateCombinationModel {
  final int? seconds;
  final double? settlePercentage;
  timeRateCombinationModel({
    this.seconds,
    this.settlePercentage,
  });

  timeRateCombinationModel copyWith({
    int? seconds,
    double? settlePercentage,
  }) {
    return timeRateCombinationModel(
      seconds: seconds ?? this.seconds,
      settlePercentage: settlePercentage ?? this.settlePercentage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seconds': seconds,
      'settlePercentage': settlePercentage,
    };
  }

  factory timeRateCombinationModel.fromMap(Map<String, dynamic> map) {
    return timeRateCombinationModel(
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
      settlePercentage: map['settlePercentage'] != null
          ? map['settlePercentage'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory timeRateCombinationModel.fromJson(String source) =>
      timeRateCombinationModel
          .fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'timeRateCombinationModel(seconds: $seconds, settlePercentage: $settlePercentage)';

  @override
  bool operator ==(covariant timeRateCombinationModel other) {
    if (identical(this, other)) return true;

    return other.seconds == seconds &&
        other.settlePercentage == settlePercentage;
  }

  @override
  int get hashCode => seconds.hashCode ^ settlePercentage.hashCode;
}

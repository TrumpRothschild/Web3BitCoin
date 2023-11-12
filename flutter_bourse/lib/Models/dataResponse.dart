// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ResponseSnapShot {
  String? msg;
  int? code;
  Data? data;

  ResponseSnapShot({this.msg, this.code, this.data});

  ResponseSnapShot.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  final String? searchValue;
  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  String? remark;
  String? params;
  int? oddsId;
  String? oddsName;
  String? timeOdds;
  String? minMaxMoney;
  int? status;
  String? remarkEn;
  Data({
    this.searchValue,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.params,
    this.oddsId,
    this.oddsName,
    this.timeOdds,
    this.minMaxMoney,
    this.status,
    this.remarkEn,
  });

  Data copyWith({
    String? searchValue,
    String? createBy,
    String? createTime,
    String? updateBy,
    String? updateTime,
    String? remark,
    String? params,
    int? oddsId,
    String? oddsName,
    String? timeOdds,
    String? minMaxMoney,
    int? status,
    String? remarkEn,
  }) {
    return Data(
      searchValue: searchValue ?? this.searchValue,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      updateBy: updateBy ?? this.updateBy,
      updateTime: updateTime ?? this.updateTime,
      remark: remark ?? this.remark,
      params: params ?? this.params,
      oddsId: oddsId ?? this.oddsId,
      oddsName: oddsName ?? this.oddsName,
      timeOdds: timeOdds ?? this.timeOdds,
      minMaxMoney: minMaxMoney ?? this.minMaxMoney,
      status: status ?? this.status,
      remarkEn: remarkEn ?? this.remarkEn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'searchValue': searchValue,
      'createBy': createBy,
      'createTime': createTime,
      'updateBy': updateBy,
      'updateTime': updateTime,
      'remark': remark,
      'params': params,
      'oddsId': oddsId,
      'oddsName': oddsName,
      'timeOdds': timeOdds,
      'minMaxMoney': minMaxMoney,
      'status': status,
      'remarkEn': remarkEn,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      searchValue:
          map['searchValue'] != null ? map['searchValue'] as String : null,
      createBy: map['createBy'] != null ? map['createBy'] as String : null,
      createTime:
          map['createTime'] != null ? map['createTime'] as String : null,
      updateBy: map['updateBy'] != null ? map['updateBy'] as String : null,
      updateTime:
          map['updateTime'] != null ? map['updateTime'] as String : null,
      remark: map['remark'] != null ? map['remark'] as String : null,
      params: map['params'] != null ? map['params'] as String : null,
      oddsId: map['oddsId'] != null ? map['oddsId'] as int : null,
      oddsName: map['oddsName'] != null ? map['oddsName'] as String : null,
      timeOdds: map['timeOdds'] != null ? map['timeOdds'] as String : null,
      minMaxMoney:
          map['minMaxMoney'] != null ? map['minMaxMoney'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      remarkEn: map['remarkEn'] != null ? map['remarkEn'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Data(searchValue: $searchValue, createBy: $createBy, createTime: $createTime, updateBy: $updateBy, updateTime: $updateTime, remark: $remark, params: $params, oddsId: $oddsId, oddsName: $oddsName, timeOdds: $timeOdds, minMaxMoney: $minMaxMoney, status: $status, remarkEn: $remarkEn)';
  }

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.searchValue == searchValue &&
        other.createBy == createBy &&
        other.createTime == createTime &&
        other.updateBy == updateBy &&
        other.updateTime == updateTime &&
        other.remark == remark &&
        other.params == params &&
        other.oddsId == oddsId &&
        other.oddsName == oddsName &&
        other.timeOdds == timeOdds &&
        other.minMaxMoney == minMaxMoney &&
        other.status == status &&
        other.remarkEn == remarkEn;
  }

  @override
  int get hashCode {
    return searchValue.hashCode ^
        createBy.hashCode ^
        createTime.hashCode ^
        updateBy.hashCode ^
        updateTime.hashCode ^
        remark.hashCode ^
        params.hashCode ^
        oddsId.hashCode ^
        oddsName.hashCode ^
        timeOdds.hashCode ^
        minMaxMoney.hashCode ^
        status.hashCode ^
        remarkEn.hashCode;
  }
}

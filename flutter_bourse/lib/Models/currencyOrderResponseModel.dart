// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class currencyOrderResponseModel {
  String? msg;
  int? code;
  currencyOrderResponse? data;

  currencyOrderResponseModel({this.msg, this.code, this.data});

  currencyOrderResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null
        ? new currencyOrderResponse.fromJson(json['data'])
        : null;
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

class currencyOrderResponse {
  String? searchValue;
  String? createBy;
  String? createTime;
  String? updateBy;
  String? updateTime;
  String? remark;
  int? orderId;
  int? orderNo;
  int? orderType;
  int? orderStatus;
  int? orderMoney;
  int? winLose;
  String? profitMoney;
  int? userId;
  String? userName;
  int? userType;
  String? buyTime;
  String? settleTime;
  int? seconds;
  String? currencyMedium;
  int? productId;
  double? settlePercentage;
  int? fee;
  String? localBuyTime;
  String? localSettleTime;
  double? buyPrice;
  String? settlePrice;
  currencyOrderResponse({
    this.searchValue,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.remark,
    this.orderId,
    this.orderNo,
    this.orderType,
    this.orderStatus,
    this.orderMoney,
    this.winLose,
    this.profitMoney,
    this.userId,
    this.userName,
    this.userType,
    this.buyTime,
    this.settleTime,
    this.seconds,
    this.currencyMedium,
    this.productId,
    this.settlePercentage,
    this.fee,
    this.localBuyTime,
    this.localSettleTime,
    this.buyPrice,
    this.settlePrice,
  });

  currencyOrderResponse copyWith({
    String? searchValue,
    String? createBy,
    String? createTime,
    String? updateBy,
    String? updateTime,
    String? remark,
    int? orderId,
    int? orderNo,
    int? orderType,
    int? orderStatus,
    int? orderMoney,
    int? winLose,
    String? profitMoney,
    int? userId,
    String? userName,
    int? userType,
    String? buyTime,
    String? settleTime,
    int? seconds,
    String? currencyMedium,
    int? productId,
    double? settlePercentage,
    int? fee,
    String? localBuyTime,
    String? localSettleTime,
    double? buyPrice,
    String? settlePrice,
  }) {
    return currencyOrderResponse(
      searchValue: searchValue ?? this.searchValue,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      updateBy: updateBy ?? this.updateBy,
      updateTime: updateTime ?? this.updateTime,
      remark: remark ?? this.remark,
      orderId: orderId ?? this.orderId,
      orderNo: orderNo ?? this.orderNo,
      orderType: orderType ?? this.orderType,
      orderStatus: orderStatus ?? this.orderStatus,
      orderMoney: orderMoney ?? this.orderMoney,
      winLose: winLose ?? this.winLose,
      profitMoney: profitMoney ?? this.profitMoney,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userType: userType ?? this.userType,
      buyTime: buyTime ?? this.buyTime,
      settleTime: settleTime ?? this.settleTime,
      seconds: seconds ?? this.seconds,
      currencyMedium: currencyMedium ?? this.currencyMedium,
      productId: productId ?? this.productId,
      settlePercentage: settlePercentage ?? this.settlePercentage,
      fee: fee ?? this.fee,
      localBuyTime: localBuyTime ?? this.localBuyTime,
      localSettleTime: localSettleTime ?? this.localSettleTime,
      buyPrice: buyPrice ?? this.buyPrice,
      settlePrice: settlePrice ?? this.settlePrice,
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
      'orderId': orderId,
      'orderNo': orderNo,
      'orderType': orderType,
      'orderStatus': orderStatus,
      'orderMoney': orderMoney,
      'winLose': winLose,
      'profitMoney': profitMoney,
      'userId': userId,
      'userName': userName,
      'userType': userType,
      'buyTime': buyTime,
      'settleTime': settleTime,
      'seconds': seconds,
      'currencyMedium': currencyMedium,
      'productId': productId,
      'settlePercentage': settlePercentage,
      'fee': fee,
      'localBuyTime': localBuyTime,
      'localSettleTime': localSettleTime,
      'buyPrice': buyPrice,
      'settlePrice': settlePrice,
    };
  }

  factory currencyOrderResponse.fromMap(Map<String, dynamic> map) {
    return currencyOrderResponse(
      searchValue:
          map['searchValue'] != null ? map['searchValue'] as String : null,
      createBy: map['createBy'] != null ? map['createBy'] as String : null,
      createTime:
          map['createTime'] != null ? map['createTime'] as String : null,
      updateBy: map['updateBy'] != null ? map['updateBy'] as String : null,
      updateTime:
          map['updateTime'] != null ? map['updateTime'] as String : null,
      remark: map['remark'] != null ? map['remark'] as String : null,
      orderId: map['orderId'] != null ? map['orderId'] as int : null,
      orderNo: map['orderNo'] != null ? map['orderNo'] as int : null,
      orderType: map['orderType'] != null ? map['orderType'] as int : null,
      orderStatus:
          map['orderStatus'] != null ? map['orderStatus'] as int : null,
      orderMoney: map['orderMoney'] != null ? map['orderMoney'] as int : null,
      winLose: map['winLose'] != null ? map['winLose'] as int : null,
      profitMoney:
          map['profitMoney'] != null ? map['profitMoney'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userType: map['userType'] != null ? map['userType'] as int : null,
      buyTime: map['buyTime'] != null ? map['buyTime'] as String : null,
      settleTime:
          map['settleTime'] != null ? map['settleTime'] as String : null,
      seconds: map['seconds'] != null ? map['seconds'] as int : null,
      currencyMedium: map['currencyMedium'] != null
          ? map['currencyMedium'] as String
          : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      settlePercentage: map['settlePercentage'] != null
          ? map['settlePercentage'] as double
          : null,
      fee: map['fee'] != null ? map['fee'] as int : null,
      localBuyTime:
          map['localBuyTime'] != null ? map['localBuyTime'] as String : null,
      localSettleTime: map['localSettleTime'] != null
          ? map['localSettleTime'] as String
          : null,
      buyPrice: map['buyPrice'] != null ? map['buyPrice'] as double : null,
      settlePrice:
          map['settlePrice'] != null ? map['settlePrice'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory currencyOrderResponse.fromJson(String source) => currencyOrderResponse
      .fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'currencyOrderResponse(searchValue: $searchValue, createBy: $createBy, createTime: $createTime, updateBy: $updateBy, updateTime: $updateTime, remark: $remark, orderId: $orderId, orderNo: $orderNo, orderType: $orderType, orderStatus: $orderStatus, orderMoney: $orderMoney, winLose: $winLose, profitMoney: $profitMoney, userId: $userId, userName: $userName, userType: $userType, buyTime: $buyTime, settleTime: $settleTime, seconds: $seconds, currencyMedium: $currencyMedium, productId: $productId, settlePercentage: $settlePercentage, fee: $fee, localBuyTime: $localBuyTime, localSettleTime: $localSettleTime, buyPrice: $buyPrice, settlePrice: $settlePrice)';
  }

  @override
  bool operator ==(covariant currencyOrderResponse other) {
    if (identical(this, other)) return true;

    return other.searchValue == searchValue &&
        other.createBy == createBy &&
        other.createTime == createTime &&
        other.updateBy == updateBy &&
        other.updateTime == updateTime &&
        other.remark == remark &&
        other.orderId == orderId &&
        other.orderNo == orderNo &&
        other.orderType == orderType &&
        other.orderStatus == orderStatus &&
        other.orderMoney == orderMoney &&
        other.winLose == winLose &&
        other.profitMoney == profitMoney &&
        other.userId == userId &&
        other.userName == userName &&
        other.userType == userType &&
        other.buyTime == buyTime &&
        other.settleTime == settleTime &&
        other.seconds == seconds &&
        other.currencyMedium == currencyMedium &&
        other.productId == productId &&
        other.settlePercentage == settlePercentage &&
        other.fee == fee &&
        other.localBuyTime == localBuyTime &&
        other.localSettleTime == localSettleTime &&
        other.buyPrice == buyPrice &&
        other.settlePrice == settlePrice;
  }

  @override
  int get hashCode {
    return searchValue.hashCode ^
        createBy.hashCode ^
        createTime.hashCode ^
        updateBy.hashCode ^
        updateTime.hashCode ^
        remark.hashCode ^
        orderId.hashCode ^
        orderNo.hashCode ^
        orderType.hashCode ^
        orderStatus.hashCode ^
        orderMoney.hashCode ^
        winLose.hashCode ^
        profitMoney.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userType.hashCode ^
        buyTime.hashCode ^
        settleTime.hashCode ^
        seconds.hashCode ^
        currencyMedium.hashCode ^
        productId.hashCode ^
        settlePercentage.hashCode ^
        fee.hashCode ^
        localBuyTime.hashCode ^
        localSettleTime.hashCode ^
        buyPrice.hashCode ^
        settlePrice.hashCode;
  }
}

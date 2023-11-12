// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TradeDataModel {
  static List<TradeData> tradeDataList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  TradeData getByPosition(int pos) => tradeDataList[pos];
}

class TradeData {
  final String createBy;
  final int? createTime;
  final String lastUpdateBy;
  final int? lastUpdateTime;
  final int? productId;
  final String productName;
  final String h5Name;
  final String currencyMedium;
  final int sort;
  final String url;
  final String status;
  final String hot;
  final String type;
  final String tradeStatus;
  final dynamic remark;
  final int policyConfigId;
  final int oddsId;
  final String currencyType;
  final dynamic briefName;
  final int? issuedDate;
  final int? issuedCount;
  final int? circulateCount;
  final dynamic? planPrice;
  final dynamic whiteBook;
  final dynamic website;
  final dynamic blockQuery;
  final dynamic synopsis;
  final int? price;
  final String contract;
  final String lastPrice;
  final String rate;
  final String vol;
  final String vol24;
  final dynamic policyName;
  final dynamic oddsName;
  final dynamic configType;
  final String high;
  final String low;
  final String open;
  TradeData({
    required this.createBy,
    this.createTime,
    required this.lastUpdateBy,
    this.lastUpdateTime,
    this.productId,
    required this.productName,
    required this.h5Name,
    required this.currencyMedium,
    required this.sort,
    required this.url,
    required this.status,
    required this.hot,
    required this.type,
    required this.tradeStatus,
    required this.remark,
    required this.policyConfigId,
    required this.oddsId,
    required this.currencyType,
    required this.briefName,
    this.issuedDate,
    this.issuedCount,
    this.circulateCount,
    this.planPrice,
    required this.whiteBook,
    required this.website,
    required this.blockQuery,
    required this.synopsis,
    this.price,
    required this.contract,
    required this.lastPrice,
    required this.rate,
    required this.vol,
    required this.vol24,
    required this.policyName,
    required this.oddsName,
    required this.configType,
    required this.high,
    required this.low,
    required this.open,
  });

  TradeData copyWith({
    String? createBy,
    int? createTime,
    String? lastUpdateBy,
    int? lastUpdateTime,
    int? productId,
    String? productName,
    String? h5Name,
    String? currencyMedium,
    int? sort,
    String? url,
    String? status,
    String? hot,
    String? type,
    String? tradeStatus,
    dynamic? remark,
    int? policyConfigId,
    int? oddsId,
    String? currencyType,
    dynamic? briefName,
    int? issuedDate,
    int? issuedCount,
    int? circulateCount,
    dynamic? planPrice,
    dynamic? whiteBook,
    dynamic? website,
    dynamic? blockQuery,
    dynamic? synopsis,
    int? price,
    String? contract,
    String? lastPrice,
    String? rate,
    String? vol,
    String? vol24,
    dynamic? policyName,
    dynamic? oddsName,
    dynamic? configType,
    String? high,
    String? low,
    String? open,
  }) {
    return TradeData(
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      lastUpdateBy: lastUpdateBy ?? this.lastUpdateBy,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      h5Name: h5Name ?? this.h5Name,
      currencyMedium: currencyMedium ?? this.currencyMedium,
      sort: sort ?? this.sort,
      url: url ?? this.url,
      status: status ?? this.status,
      hot: hot ?? this.hot,
      type: type ?? this.type,
      tradeStatus: tradeStatus ?? this.tradeStatus,
      remark: remark ?? this.remark,
      policyConfigId: policyConfigId ?? this.policyConfigId,
      oddsId: oddsId ?? this.oddsId,
      currencyType: currencyType ?? this.currencyType,
      briefName: briefName ?? this.briefName,
      issuedDate: issuedDate ?? this.issuedDate,
      issuedCount: issuedCount ?? this.issuedCount,
      circulateCount: circulateCount ?? this.circulateCount,
      planPrice: planPrice ?? this.planPrice,
      whiteBook: whiteBook ?? this.whiteBook,
      website: website ?? this.website,
      blockQuery: blockQuery ?? this.blockQuery,
      synopsis: synopsis ?? this.synopsis,
      price: price ?? this.price,
      contract: contract ?? this.contract,
      lastPrice: lastPrice ?? this.lastPrice,
      rate: rate ?? this.rate,
      vol: vol ?? this.vol,
      vol24: vol24 ?? this.vol24,
      policyName: policyName ?? this.policyName,
      oddsName: oddsName ?? this.oddsName,
      configType: configType ?? this.configType,
      high: high ?? this.high,
      low: low ?? this.low,
      open: open ?? this.open,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createBy': createBy,
      'createTime': createTime,
      'lastUpdateBy': lastUpdateBy,
      'lastUpdateTime': lastUpdateTime,
      'productId': productId,
      'productName': productName,
      'h5Name': h5Name,
      'currencyMedium': currencyMedium,
      'sort': sort,
      'url': url,
      'status': status,
      'hot': hot,
      'type': type,
      'tradeStatus': tradeStatus,
      'remark': remark,
      'policyConfigId': policyConfigId,
      'oddsId': oddsId,
      'currencyType': currencyType,
      'briefName': briefName,
      'issuedDate': issuedDate,
      'issuedCount': issuedCount,
      'circulateCount': circulateCount,
      'planPrice': planPrice,
      'whiteBook': whiteBook,
      'website': website,
      'blockQuery': blockQuery,
      'synopsis': synopsis,
      'price': price,
      'contract': contract,
      'lastPrice': lastPrice,
      'rate': rate,
      'vol': vol,
      'vol24': vol24,
      'policyName': policyName,
      'oddsName': oddsName,
      'configType': configType,
      'high': high,
      'low': low,
      'open': open,
    };
  }

  factory TradeData.fromMap(Map<String, dynamic> map) {
    return TradeData(
      createBy: map['createBy'] as String,
      createTime: map['createTime'] != null ? map['createTime'] as int : null,
      lastUpdateBy: map['lastUpdateBy'] as String,
      lastUpdateTime:
          map['lastUpdateTime'] != null ? map['lastUpdateTime'] as int : null,
      productId: map['productId'] != null ? map['productId'] as int : null,
      productName: map['productName'] as String,
      h5Name: map['h5Name'] as String,
      currencyMedium: map['currencyMedium'] as String,
      sort: map['sort'] as int,
      url: map['url'] as String,
      status: map['status'] as String,
      hot: map['hot'] as String,
      type: map['type'] as String,
      tradeStatus: map['tradeStatus'] as String,
      remark: map['remark'] as dynamic,
      policyConfigId: map['policyConfigId'] as int,
      oddsId: map['oddsId'] as int,
      currencyType: map['currencyType'] as String,
      briefName: map['briefName'] as dynamic,
      issuedDate: map['issuedDate'] != null ? map['issuedDate'] as int : null,
      issuedCount:
          map['issuedCount'] != null ? map['issuedCount'] as int : null,
      circulateCount:
          map['circulateCount'] != null ? map['circulateCount'] as int : null,
      planPrice: map['planPrice'] != null ? map['planPrice'] as dynamic : null,
      whiteBook: map['whiteBook'] as dynamic,
      website: map['website'] as dynamic,
      blockQuery: map['blockQuery'] as dynamic,
      synopsis: map['synopsis'] as dynamic,
      price: map['price'] != null ? map['price'] as int : null,
      contract: map['contract'] as String,
      lastPrice: map['lastPrice'] as String,
      rate: map['rate'] as String,
      vol: map['vol'] as String,
      vol24: map['vol24'] as String,
      policyName: map['policyName'] as dynamic,
      oddsName: map['oddsName'] as dynamic,
      configType: map['configType'] as dynamic,
      high: map['high'] as String,
      low: map['low'] as String,
      open: map['open'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TradeData.fromJson(String source) =>
      TradeData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TradeData(createBy: $createBy, createTime: $createTime, lastUpdateBy: $lastUpdateBy, lastUpdateTime: $lastUpdateTime, productId: $productId, productName: $productName, h5Name: $h5Name, currencyMedium: $currencyMedium, sort: $sort, url: $url, status: $status, hot: $hot, type: $type, tradeStatus: $tradeStatus, remark: $remark, policyConfigId: $policyConfigId, oddsId: $oddsId, currencyType: $currencyType, briefName: $briefName, issuedDate: $issuedDate, issuedCount: $issuedCount, circulateCount: $circulateCount, planPrice: $planPrice, whiteBook: $whiteBook, website: $website, blockQuery: $blockQuery, synopsis: $synopsis, price: $price, contract: $contract, lastPrice: $lastPrice, rate: $rate, vol: $vol, vol24: $vol24, policyName: $policyName, oddsName: $oddsName, configType: $configType, high: $high, low: $low, open: $open)';
  }

  @override
  bool operator ==(covariant TradeData other) {
    if (identical(this, other)) return true;

    return other.createBy == createBy &&
        other.createTime == createTime &&
        other.lastUpdateBy == lastUpdateBy &&
        other.lastUpdateTime == lastUpdateTime &&
        other.productId == productId &&
        other.productName == productName &&
        other.h5Name == h5Name &&
        other.currencyMedium == currencyMedium &&
        other.sort == sort &&
        other.url == url &&
        other.status == status &&
        other.hot == hot &&
        other.type == type &&
        other.tradeStatus == tradeStatus &&
        other.remark == remark &&
        other.policyConfigId == policyConfigId &&
        other.oddsId == oddsId &&
        other.currencyType == currencyType &&
        other.briefName == briefName &&
        other.issuedDate == issuedDate &&
        other.issuedCount == issuedCount &&
        other.circulateCount == circulateCount &&
        other.planPrice == planPrice &&
        other.whiteBook == whiteBook &&
        other.website == website &&
        other.blockQuery == blockQuery &&
        other.synopsis == synopsis &&
        other.price == price &&
        other.contract == contract &&
        other.lastPrice == lastPrice &&
        other.rate == rate &&
        other.vol == vol &&
        other.vol24 == vol24 &&
        other.policyName == policyName &&
        other.oddsName == oddsName &&
        other.configType == configType &&
        other.high == high &&
        other.low == low &&
        other.open == open;
  }

  @override
  int get hashCode {
    return createBy.hashCode ^
        createTime.hashCode ^
        lastUpdateBy.hashCode ^
        lastUpdateTime.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        h5Name.hashCode ^
        currencyMedium.hashCode ^
        sort.hashCode ^
        url.hashCode ^
        status.hashCode ^
        hot.hashCode ^
        type.hashCode ^
        tradeStatus.hashCode ^
        remark.hashCode ^
        policyConfigId.hashCode ^
        oddsId.hashCode ^
        currencyType.hashCode ^
        briefName.hashCode ^
        issuedDate.hashCode ^
        issuedCount.hashCode ^
        circulateCount.hashCode ^
        planPrice.hashCode ^
        whiteBook.hashCode ^
        website.hashCode ^
        blockQuery.hashCode ^
        synopsis.hashCode ^
        price.hashCode ^
        contract.hashCode ^
        lastPrice.hashCode ^
        rate.hashCode ^
        vol.hashCode ^
        vol24.hashCode ^
        policyName.hashCode ^
        oddsName.hashCode ^
        configType.hashCode ^
        high.hashCode ^
        low.hashCode ^
        open.hashCode;
  }
}

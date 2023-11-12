// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LiquidityMiningModel {
  static List<LiquidityMining> liquidityMiningList = [];

  // Get Item by ID
  // Item getById(int id) =>
  //     items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  LiquidityMining getByPosition(int pos) => liquidityMiningList[pos];
}

class LiquidityMining {
  final int? productId;
  final String? productName;
  final int? productSort;
  final String? productUrl;
  final int? productStatus;
  final int? productPeriod;
  final int? productLevel;
  final int? productPriceMin;
  final int? productPriceMax;
  final int? productOutputCustom;
  final double? productDefaultRate;
  final String? productPurchaseCurrency;
  final String? productReturnCurrency;
  final String? remark;
  final String? createBy;
  final String? createTime;
  final String? lastUpdateBy;
  final int? lastUpdateTime;
  LiquidityMining({
    this.productId,
    this.productName,
    this.productSort,
    this.productUrl,
    this.productStatus,
    this.productPeriod,
    this.productLevel,
    this.productPriceMin,
    this.productPriceMax,
    this.productOutputCustom,
    this.productDefaultRate,
    this.productPurchaseCurrency,
    this.productReturnCurrency,
    this.remark,
    this.createBy,
    this.createTime,
    this.lastUpdateBy,
    this.lastUpdateTime,
  });

  LiquidityMining copyWith({
    int? productId,
    String? productName,
    int? productSort,
    String? productUrl,
    int? productStatus,
    int? productPeriod,
    int? productLevel,
    int? productPriceMin,
    int? productPriceMax,
    int? productOutputCustom,
    double? productDefaultRate,
    String? productPurchaseCurrency,
    String? productReturnCurrency,
    String? remark,
    String? createBy,
    String? createTime,
    String? lastUpdateBy,
    int? lastUpdateTime,
  }) {
    return LiquidityMining(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productSort: productSort ?? this.productSort,
      productUrl: productUrl ?? this.productUrl,
      productStatus: productStatus ?? this.productStatus,
      productPeriod: productPeriod ?? this.productPeriod,
      productLevel: productLevel ?? this.productLevel,
      productPriceMin: productPriceMin ?? this.productPriceMin,
      productPriceMax: productPriceMax ?? this.productPriceMax,
      productOutputCustom: productOutputCustom ?? this.productOutputCustom,
      productDefaultRate: productDefaultRate ?? this.productDefaultRate,
      productPurchaseCurrency:
          productPurchaseCurrency ?? this.productPurchaseCurrency,
      productReturnCurrency:
          productReturnCurrency ?? this.productReturnCurrency,
      remark: remark ?? this.remark,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      lastUpdateBy: lastUpdateBy ?? this.lastUpdateBy,
      lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'productSort': productSort,
      'productUrl': productUrl,
      'productStatus': productStatus,
      'productPeriod': productPeriod,
      'productLevel': productLevel,
      'productPriceMin': productPriceMin,
      'productPriceMax': productPriceMax,
      'productOutputCustom': productOutputCustom,
      'productDefaultRate': productDefaultRate,
      'productPurchaseCurrency': productPurchaseCurrency,
      'productReturnCurrency': productReturnCurrency,
      'remark': remark,
      'createBy': createBy,
      'createTime': createTime,
      'lastUpdateBy': lastUpdateBy,
      'lastUpdateTime': lastUpdateTime,
    };
  }

  factory LiquidityMining.fromMap(Map<String, dynamic> map) {
    return LiquidityMining(
      productId: map['productId'] != null ? map['productId'] as int : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      productSort:
          map['productSort'] != null ? map['productSort'] as int : null,
      productUrl:
          map['productUrl'] != null ? map['productUrl'] as String : null,
      productStatus:
          map['productStatus'] != null ? map['productStatus'] as int : null,
      productPeriod:
          map['productPeriod'] != null ? map['productPeriod'] as int : null,
      productLevel:
          map['productLevel'] != null ? map['productLevel'] as int : null,
      productPriceMin:
          map['productPriceMin'] != null ? map['productPriceMin'] as int : null,
      productPriceMax:
          map['productPriceMax'] != null ? map['productPriceMax'] as int : null,
      productOutputCustom: map['productOutputCustom'] != null
          ? map['productOutputCustom'] as int
          : null,
      productDefaultRate: map['productDefaultRate'] != null
          ? map['productDefaultRate'] as double
          : null,
      productPurchaseCurrency: map['productPurchaseCurrency'] != null
          ? map['productPurchaseCurrency'] as String
          : null,
      productReturnCurrency: map['productReturnCurrency'] != null
          ? map['productReturnCurrency'] as String
          : null,
      remark: map['remark'] != null ? map['remark'] as String : null,
      createBy: map['createBy'] != null ? map['createBy'] as String : null,
      createTime:
          map['createTime'] != null ? map['createTime'] as String : null,
      lastUpdateBy:
          map['lastUpdateBy'] != null ? map['lastUpdateBy'] as String : null,
      lastUpdateTime:
          map['lastUpdateTime'] != null ? map['lastUpdateTime'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LiquidityMining.fromJson(String source) =>
      LiquidityMining.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LiquidityMining(productId: $productId, productName: $productName, productSort: $productSort, productUrl: $productUrl, productStatus: $productStatus, productPeriod: $productPeriod, productLevel: $productLevel, productPriceMin: $productPriceMin, productPriceMax: $productPriceMax, productOutputCustom: $productOutputCustom, productDefaultRate: $productDefaultRate, productPurchaseCurrency: $productPurchaseCurrency, productReturnCurrency: $productReturnCurrency, remark: $remark, createBy: $createBy, createTime: $createTime, lastUpdateBy: $lastUpdateBy, lastUpdateTime: $lastUpdateTime)';
  }

  @override
  bool operator ==(covariant LiquidityMining other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.productName == productName &&
        other.productSort == productSort &&
        other.productUrl == productUrl &&
        other.productStatus == productStatus &&
        other.productPeriod == productPeriod &&
        other.productLevel == productLevel &&
        other.productPriceMin == productPriceMin &&
        other.productPriceMax == productPriceMax &&
        other.productOutputCustom == productOutputCustom &&
        other.productDefaultRate == productDefaultRate &&
        other.productPurchaseCurrency == productPurchaseCurrency &&
        other.productReturnCurrency == productReturnCurrency &&
        other.remark == remark &&
        other.createBy == createBy &&
        other.createTime == createTime &&
        other.lastUpdateBy == lastUpdateBy &&
        other.lastUpdateTime == lastUpdateTime;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productSort.hashCode ^
        productUrl.hashCode ^
        productStatus.hashCode ^
        productPeriod.hashCode ^
        productLevel.hashCode ^
        productPriceMin.hashCode ^
        productPriceMax.hashCode ^
        productOutputCustom.hashCode ^
        productDefaultRate.hashCode ^
        productPurchaseCurrency.hashCode ^
        productReturnCurrency.hashCode ^
        remark.hashCode ^
        createBy.hashCode ^
        createTime.hashCode ^
        lastUpdateBy.hashCode ^
        lastUpdateTime.hashCode;
  }
}

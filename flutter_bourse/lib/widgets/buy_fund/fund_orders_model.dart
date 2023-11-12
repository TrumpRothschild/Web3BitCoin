
class FundOrdersModel {
  int? total;
  List<OrdersRows>? rows;
  int? code;
  String? msg;

  FundOrdersModel({this.total, this.rows, this.code, this.msg});

  FundOrdersModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <OrdersRows>[];
      json['rows'].forEach((v) {
        rows!.add(new OrdersRows.fromJson(v));
      });
    }
    code = json['code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['msg'] = this.msg;
    return data;
  }
}

class OrdersRows {
  int? ftId;
  int? fundId;
  int? coinId;
  String? dealTime;
  int? time;
  int? amount;
  double? price;
  String? status;
  String? address;
  String? hash;
  String? direction;
  String? coinName;
  int? coinRate;
  String? fundName;
  String? lowRisk;
  double? profitRate;
  double? weekRate;
  double? annualRate;
  double? increaseRate;
  double? dailyProfit;
  double? annualProfit;
  double? yesterdayProfit;
  double? marketValue;
  double? turnover;
  String? stockNumber;
  double? outputAmount;
  double? totalOutputAmount;
  double? totalAmount;
  String? orderNum;
  Null? usdtRate;

  OrdersRows(
      {this.ftId,
        this.fundId,
        this.coinId,
        this.dealTime,
        this.time,
        this.amount,
        this.price,
        this.status,
        this.address,
        this.hash,
        this.direction,
        this.coinName,
        this.coinRate,
        this.fundName,
        this.lowRisk,
        this.profitRate,
        this.weekRate,
        this.annualRate,
        this.increaseRate,
        this.dailyProfit,
        this.annualProfit,
        this.yesterdayProfit,
        this.marketValue,
        this.turnover,
        this.stockNumber,
        this.outputAmount,
        this.totalOutputAmount,
        this.totalAmount,
        this.orderNum,
        this.usdtRate});

  OrdersRows.fromJson(Map<String, dynamic> json) {
    ftId = json['ftId'];
    fundId = json['fundId'];
    coinId = json['coinId'];
    dealTime = json['dealTime'];
    time = json['time'];
    amount = json['amount'];
    price = json['price'];
    status = json['status'];
    address = json['address'];
    hash = json['hash'];
    direction = json['direction'];
    coinName = json['coinName'];
    coinRate = json['coinRate'];
    fundName = json['fundName'];
    lowRisk = json['lowRisk'];
    profitRate = json['profitRate'];
    weekRate = json['weekRate'];
    annualRate = json['annualRate'];
    increaseRate = json['increaseRate'];
    dailyProfit = json['dailyProfit'];
    annualProfit = json['annualProfit'];
    yesterdayProfit = json['yesterdayProfit'];
    marketValue = json['marketValue'];
    turnover = json['turnover'];
    stockNumber = json['stockNumber'];
    outputAmount = json['outputAmount'];
    totalOutputAmount = json['totalOutputAmount'];
    totalAmount = json['totalAmount'];
    orderNum = json['orderNum'];
    usdtRate = json['usdtRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ftId'] = this.ftId;
    data['fundId'] = this.fundId;
    data['coinId'] = this.coinId;
    data['dealTime'] = this.dealTime;
    data['time'] = this.time;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['status'] = this.status;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['direction'] = this.direction;
    data['coinName'] = this.coinName;
    data['coinRate'] = this.coinRate;
    data['fundName'] = this.fundName;
    data['lowRisk'] = this.lowRisk;
    data['profitRate'] = this.profitRate;
    data['weekRate'] = this.weekRate;
    data['annualRate'] = this.annualRate;
    data['increaseRate'] = this.increaseRate;
    data['dailyProfit'] = this.dailyProfit;
    data['annualProfit'] = this.annualProfit;
    data['yesterdayProfit'] = this.yesterdayProfit;
    data['marketValue'] = this.marketValue;
    data['turnover'] = this.turnover;
    data['stockNumber'] = this.stockNumber;
    data['outputAmount'] = this.outputAmount;
    data['totalOutputAmount'] = this.totalOutputAmount;
    data['totalAmount'] = this.totalAmount;
    data['orderNum'] = this.orderNum;
    data['usdtRate'] = this.usdtRate;
    return data;
  }
}
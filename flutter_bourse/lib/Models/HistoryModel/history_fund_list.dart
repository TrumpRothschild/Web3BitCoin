class HistoryFundListModel {
  int? total;
  List<FundHistoryRows>? rows;
  int? code;
  String? msg;

  HistoryFundListModel({this.total, this.rows, this.code, this.msg});

  HistoryFundListModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <FundHistoryRows>[];
      json['rows'].forEach((v) {
        rows!.add(new FundHistoryRows.fromJson(v));
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

class FundHistoryRows {
  int? ftId;
  int? fundId;
  int? coinId;
  String? dealTime;
  double? amount;
  double? price;
  String? status;
  String? address;
  String? hash;
  String? direction;
  String? coinName;
  int? coinRate;
  String? fundName;

  FundHistoryRows(
      {this.ftId,
        this.fundId,
        this.coinId,
        this.dealTime,
        this.amount,
        this.price,
        this.status,
        this.address,
        this.hash,
        this.direction,
        this.coinName,
        this.coinRate,
        this.fundName});

  FundHistoryRows.fromJson(Map<String, dynamic> json) {
    ftId = json['ftId'];
    fundId = json['fundId'];
    coinId = json['coinId'];
    dealTime = json['dealTime'];
    amount = json['amount'];
    price = json['price'];
    status = json['status'];
    address = json['address'];
    hash = json['hash'];
    direction = json['direction'];
    coinName = json['coinName'];
    coinRate = json['coinRate'];
    fundName = json['fundName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ftId'] = this.ftId;
    data['fundId'] = this.fundId;
    data['coinId'] = this.coinId;
    data['dealTime'] = this.dealTime;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['status'] = this.status;
    data['address'] = this.address;
    data['hash'] = this.hash;
    data['direction'] = this.direction;
    data['coinName'] = this.coinName;
    data['coinRate'] = this.coinRate;
    data['fundName'] = this.fundName;
    return data;
  }
}
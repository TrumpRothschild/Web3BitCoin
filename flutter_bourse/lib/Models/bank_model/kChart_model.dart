
class KChartModel {
  int? total;
  List<ChartRows>? rows;
  int? code;
  String? msg;

  KChartModel({this.total, this.rows, this.code, this.msg});

  KChartModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['rows'] != null) {
      rows = <ChartRows>[];
      json['rows'].forEach((v) {
        rows!.add(new ChartRows.fromJson(v));
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

class ChartRows {
  int? fmarketId;
  int? fundId;
  double? min;
  double? max;
  int? volume;
  int? start;
  int? end;
  int? money;
  String? time;

  ChartRows(
      {this.fmarketId,
        this.fundId,
        this.min,
        this.max,
        this.volume,
        this.start,
        this.end,
        this.money,
        this.time});

  ChartRows.fromJson(Map<String, dynamic> json) {
    fmarketId = json['fmarketId'];
    fundId = json['fundId'];
    min = json['min'];
    max = json['max'];
    volume = json['volume'];
    start = json['start'];
    end = json['end'];
    money = json['money'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fmarketId'] = this.fmarketId;
    data['fundId'] = this.fundId;
    data['min'] = this.min;
    data['max'] = this.max;
    data['volume'] = this.volume;
    data['start'] = this.start;
    data['end'] = this.end;
    data['money'] = this.money;
    data['time'] = this.time;
    return data;
  }
}
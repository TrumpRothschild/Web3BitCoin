class MiningModel {
  int? total;

  List<MiningData>? data;
  int? code;


  MiningModel({this.total,  this.data, this.code});

  MiningModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    if (json['data'] != null) {
      data = <MiningData>[];
      json['data'].forEach((v) {
        data!.add(new MiningData.fromJson(v));
      });
    }
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;

    return data;
  }
}

class MiningData {
  String? rateReturn;
  Globalization? globalization;
  int? id;
  String? coinName;
  int? type;
  String? regularType;

  MiningData(
      {this.rateReturn,
        this.globalization,
        this.id,
        this.coinName,
        this.type,
        this.regularType});

  MiningData.fromJson(Map<String, dynamic> json) {
    rateReturn = json['rateReturn'];
    globalization = json['globalization'] != null
        ? new Globalization.fromJson(json['globalization'])
        : null;
    id = json['id'];
    coinName = json['coinName'];
    type = json['type'];
    regularType = json['regularType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rateReturn'] = this.rateReturn;
    if (this.globalization != null) {
      data['globalization'] = this.globalization!.toJson();
    }
    data['id'] = this.id;
    data['coinName'] = this.coinName;
    data['type'] = this.type;
    data['regularType'] = this.regularType;
    return data;
  }
}

class Globalization {
  German? german;
  German? spanish;
  German? traditional;
  German? russian;
  German? japan;
  German? english;
  German? italian;
  German? india;
  German? korean;
  German? french;

  Globalization(
      {this.german,
        this.spanish,
        this.traditional,
        this.russian,
        this.japan,
        this.english,
        this.italian,
        this.india,
        this.korean,
        this.french});

  Globalization.fromJson(Map<String, dynamic> json) {
    german =
    json['german'] != null ? new German.fromJson(json['german']) : null;
    spanish =
    json['spanish'] != null ? new German.fromJson(json['spanish']) : null;
    traditional = json['traditional'] != null
        ? new German.fromJson(json['traditional'])
        : null;
    russian =
    json['russian'] != null ? new German.fromJson(json['russian']) : null;
    japan = json['japan'] != null ? new German.fromJson(json['japan']) : null;
    english =
    json['english'] != null ? new German.fromJson(json['english']) : null;
    italian =
    json['italian'] != null ? new German.fromJson(json['italian']) : null;
    india = json['india'] != null ? new German.fromJson(json['india']) : null;
    korean =
    json['korean'] != null ? new German.fromJson(json['korean']) : null;
    french =
    json['french'] != null ? new German.fromJson(json['french']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.german != null) {
      data['german'] = this.german!.toJson();
    }
    if (this.spanish != null) {
      data['spanish'] = this.spanish!.toJson();
    }
    if (this.traditional != null) {
      data['traditional'] = this.traditional!.toJson();
    }
    if (this.russian != null) {
      data['russian'] = this.russian!.toJson();
    }
    if (this.japan != null) {
      data['japan'] = this.japan!.toJson();
    }
    if (this.english != null) {
      data['english'] = this.english!.toJson();
    }
    if (this.italian != null) {
      data['italian'] = this.italian!.toJson();
    }
    if (this.india != null) {
      data['india'] = this.india!.toJson();
    }
    if (this.korean != null) {
      data['korean'] = this.korean!.toJson();
    }
    if (this.french != null) {
      data['french'] = this.french!.toJson();
    }
    return data;
  }
}

class German {
  String? coinName;
  String? regularType;

  German({this.coinName, this.regularType});

  German.fromJson(Map<String, dynamic> json) {
    coinName = json['coinName'];
    regularType = json['regularType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinName'] = this.coinName;
    data['regularType'] = this.regularType;
    return data;
  }
}
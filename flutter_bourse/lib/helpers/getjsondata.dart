import 'dart:convert';

import 'package:flutter/services.dart';

import '../Models/trade.dart';

class getjsonData {
  Future<List<TradeData>> loadDatabuses() async {
    //await Future.delayed(Duration(seconds: 5));
    final busJson = await rootBundle.loadString("assets/files/json/trade.json");
    // final busJson = await fetchAlbum();

    /*  GetUrl serverPath = GetUrl();
    final busJson = await http
        .get(Uri.parse(serverPath.url + 'stop-list-bus.php?busId=' + BusRoute)); */

    var busdecodedData = jsonDecode(busJson);
    var busproductsData = busdecodedData;
    TradeDataModel.tradeDataList = List.from(busproductsData)
        .map<TradeData>((TradeDatalist) => TradeData.fromMap(TradeDatalist))
        .toList();

    return TradeDataModel.tradeDataList;
  }
}

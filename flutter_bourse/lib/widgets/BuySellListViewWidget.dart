import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Models/totalTradeModel.dart';

import '../helpers/UserSharedPreferences.dart';

class BuySellListWidget extends StatefulWidget {
  BuySellListWidget({Key? key}) : super(key: key);

  @override
  State<BuySellListWidget> createState() => _BuySellWidgetState();
}

class _BuySellWidgetState extends State<BuySellListWidget> {
  late Timer _timer;
  double offset = 0;
  final RxList<TradeData> getTotalTradeinnerDataMap = <TradeData>[].obs;
  late InfiniteScrollController controller;
  @override
  void initState() {
    // getTotalTradeData();
    super.initState();
  }

  // getTotalTradeData() async {
  //   if (UserSharedPreferences.getPrivateToken().toString() != '') {
  //     Uri url = Uri.parse(
  //         '${GetServerPath().serverIP}/client/api/getTotalTrades?symbol=BTCUSDT');
  //
  //     String token = UserSharedPreferences.getPrivateToken()!;
  //     final totaltradeResponse = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     });
  //
  //     var jsonData = jsonDecode(totaltradeResponse.body);
  //     final List<dynamic> totaltradeResult = jsonData['data'];
  //     // TotalTradeModel.fromMap(jsonData['data']);
  //     //   List<String> a = [];
  //     getTotalTradeinnerDataMap.clear();
  //     for (var data in totaltradeResult) {
  //       //  log('$data  ${totaltradeResult[data]}');
  //       //  a.add(totaltradeResult[data].toString());
  //       innerTradeDataListModel.tradeDataList.add(TradeData.fromMap(data).obs);
  //       getTotalTradeinnerDataMap.add(TradeData.fromMap(data));
  //     }
  //     //  controller.setRxPrices(getxinnerDataMap);
  //
  //     for (var data in getTotalTradeinnerDataMap) {
  //       data.price;
  //       //   print(
  //       //      'Total Trade Datalog : Price   : ${data.price} Amount :  ${data.amount}  type :  ${data.type}');
  //       //  controller.refreshSelectedChainObject(data.obs);
  //       //  await controller.setSelectedChainObject(data.obs);
  //
  //     }
  //     setState(() {});
  //   }
  //   Future.delayed(const Duration(seconds: 1), () async {
  //     getTotalTradeData();
  //   });
  // }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        height: 450, //400
        width: 60,
        child: ClipRRect(
          child: ListView.builder(
            itemCount: getTotalTradeinnerDataMap.length,
            itemExtent: 36,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 30,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat("hh:mm:ss")
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                getTotalTradeinnerDataMap[index]
                                                    .date!))
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 6),
                                    child: Text(
                                      getTotalTradeinnerDataMap[index]
                                                  .type
                                                  .toString() ==
                                              'sell'
                                          ? 'Sell'
                                          : 'Buy',
                                      style: TextStyle(
                                          color:
                                              getTotalTradeinnerDataMap[index]
                                                          .type
                                                          .toString() ==
                                                      'sell'
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    child: Text(
                                      getTotalTradeinnerDataMap[index]
                                          .price
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    getTotalTradeinnerDataMap[index]
                                        .amount
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class User {
  late String time;
  int quantity;
  double price;
  String direction;
  User(int timeEpoch, this.price, this.direction, this.quantity) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(timeEpoch);

    String formatedDate = DateFormat("hh:mm:ss").format(DateTime.now());
    this.time = formatedDate;
  }
}

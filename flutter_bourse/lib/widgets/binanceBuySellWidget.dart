import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/tradeModel.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Models/totalTradeModel.dart';

import '../helpers/UserSharedPreferences.dart';
import 'candleStickChartPage.dart';

class BinanceBuySellListWidget extends StatefulWidget {
  BinanceBuySellListWidget({Key? key}) : super(key: key);

  @override
  State<BinanceBuySellListWidget> createState() => _BuySellWidgetState();
}

class _BuySellWidgetState extends State<BinanceBuySellListWidget> {
  late Timer _timer;
  double offset = 0;
  late String symbol;
  final RxList<TradeData> getTotalTradeinnerDataMap = <TradeData>[].obs;
  RxList<TradeData> getTotalTradeinnerDataMapReversed = <TradeData>[].obs;
  late InfiniteScrollController controller;
  @override
  void initState() {
    super.initState();
    symbol = Get.find<Controller>().getSelectedChainObj()().symbol!;
    getTotalTradeData();
  }

  getTotalTradeData() async {
    // if (UserSharedPreferences.getPrivateToken().toString() != '') {
    getTotalTradeinnerDataMapReversed.clear();
    if (symbol != Get.find<Controller>().getSelectedChainObj()().symbol!) {
      getTotalTradeinnerDataMap.clear();
      symbol = Get.find<Controller>().getSelectedChainObj()().symbol!;
    }

    innerData r = Get.find<Controller>().getSelectedChainObj()();
    Random ran = new Random();
    double falseProbability = .4;
    bool booleanResult = ran.nextDouble() > falseProbability;
    // int lastDigit = int.parse(
    //     (r.lastQuantity.toString())[r.lastQuantity.toString().length - 1]);
    TradeData newTradeData = TradeData(
        amount: r.lastQuantity,
        date: r.closeTime,
        type: !booleanResult ? 'sell' : 'buy',
        price: r.lastPrice);

    getTotalTradeinnerDataMap.add(newTradeData);

    if (getTotalTradeinnerDataMap.length > 10) {
      getTotalTradeinnerDataMap.removeRange(0, 1);
    }

    // for (var data in getTotalTradeinnerDataMap) {
    //   data.price;
    // print(
    //     'Total Trade Datalog : Price   : ${data.price} Amount :  ${data.amount}  type :  ${data.type}');
    // }
    getTotalTradeinnerDataMapReversed
        .addAll(getTotalTradeinnerDataMap.reversed);

    setState(() {});
    //  }

    Future.delayed(const Duration(seconds: 1), () async {
      getTotalTradeData();
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 60),
        height: 360, //400
        // width: 60,
        child: ClipRRect(
          child: ListView.builder(
            itemCount: getTotalTradeinnerDataMapReversed.length,
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
                                                getTotalTradeinnerDataMapReversed[
                                                        index]
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
                                      getTotalTradeinnerDataMapReversed[index]
                                                  .type
                                                  .toString() ==
                                              'sell'
                                          ? 'Sell'
                                          : 'Buy',
                                      style: TextStyle(
                                          color:
                                              getTotalTradeinnerDataMapReversed[
                                                              index]
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
                                      getTotalTradeinnerDataMapReversed[index]
                                          .price
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    getTotalTradeinnerDataMapReversed[index]
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

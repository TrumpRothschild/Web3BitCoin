import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/bank_model/kChart_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/ChartLine/echarts_data.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/buy_fund_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/sell_fund_view.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:get/get.dart';
// import 'package:graphic/graphic.dart';
import 'package:http/http.dart' as http;
import 'package:quiver/iterables.dart';


  class FundListCell extends StatefulWidget {

  final int index;
  final FundRows? fund;
  const FundListCell({Key? key, required this.index,
    required this.fund,}) : super(key: key);

  @override
  State<FundListCell> createState() => _FundListCellState();
  }
  class _FundListCellState extends State<FundListCell> {

  // final priceVolumeChannel = StreamController<GestureSignal>.broadcast();
  KChartModel? chartModel;

  // List<Map> fundList = [];
  // List<List> priceListData = [];
  var priceListData = <List?>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kChartApi();
  }

  void kChartApi() async {
    priceListData.clear();
    Map map1 = {
      "volume": 4309.1,
      "stockNumber": "056151",
      "min": 1,
      "money": 8409,
      "max": 3,
      "start": 2,
      "end": 7,
      "id": 2562,
      "time": "2022-12-04"
    };
    Map map2 = {
      "volume": 1808.2,
      "stockNumber": "056151",
      "min": 1,
      "money": 10941,
      "max": 3,
      "start": 2,
      "end": 6,
      "id": 2196,
      "time": "2022-12-03"
    };
    Map map3 = {
      "volume": 3055.2,
      "stockNumber": "056151",
      "min": 3,
      "money": 12456,
      "max": 5,
      "start": 4,
      "end": 0,
      "id": 1830,
      "time": "2022-12-02"
    };
    Map map4={
      "volume": 3855.3,
      "stockNumber": "056151",
      "min": 8,
      "money": 5286,
      "max": 10,
      "start": 9,
      "end": 0,
      "id": 1099,
      "time": "2022-12-01"
    };
    Map map5={
      "volume": 2366.1,
      "stockNumber": "056151",
      "min": 0,
      "money": 15479,
      "max": 1,
      "start": 0,
      "end": 3,
      "id": 1098,
      "time": "2022-11-30"
    };
    Map map6={
      "volume": 3614.9,
      "stockNumber": "056151",
      "min": 0,
      "money": 5849,
      "max": 1,
      "start": 0,
      "end": 9,
      "id": 1097,
      "time": "2022-11-29"
    };
    Map map7 ={
      "volume": 750.5,
      "stockNumber": "056151",
      "min": 4,
      "money": 6342,
      "max": 6,
      "start": 5,
      "end": 2,
      "id": 1096,
      "time": "2022-11-28"
    };
    // priceListData.add(map1);
    // priceListData.add(map2);
    // priceListData.add(map3);
    // priceListData.add(map4);
    // priceListData.add(map5);
    // priceListData.add(map6);
    // priceListData.add(map7);
    List list = [];
    List volumeList = [];
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/mfund/list?fundId=${widget.fund!.fundId!}');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString()});

    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      chartModel = KChartModel.fromJson(jsonResult);

      // priceListData.add(list);
      // priceListData.add(volumeList);

      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: new Border.all(color: Color.fromRGBO(245, 245, 245, 1))
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fund!.fundName!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.fund!.stockNumber!.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Container(
                    width: 65,
                    padding: EdgeInsets.only(left: 0),
                    margin: EdgeInsets.only(left: 3),
                    child: Text(
                      widget.fund!.description!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: ColorConstants.AppCoinbaseBlueColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 0, 255, 0.1),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    )),
                Container(
                  width: 65,
                  padding: EdgeInsets.only(left: 0),
                  margin: EdgeInsets.only(left: 3),
                  child: Text(
                    widget.fund!.lowRisk!,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppCoinbaseBlueColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w100,
                  ),
                    textAlign: TextAlign.center,
                ),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 255, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  )),
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.Daysyield')+":  ", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  ),),
                Text("+" + "${widget.fund!.weekRate!*100}" + "%", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),),
                Text(translate('home.Fixed'), overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                  ),),
                Text("${widget.fund!.annualRate!*100}"+"%", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color:  ColorConstants.AppGreenColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),)
              ],
            ),),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 2,
            thickness: 0.9,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$"+widget.fund!.price!.toString(), overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),),
                Text('+ '+"${widget.fund!.profitRate!*100}"+"%", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
              ],
            ),),

          Container(
            padding: EdgeInsets.only(left: 10,top: 0),
            child:  Row(
              children: [
                Container(
                  height: 30,
                  width:70,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      color: Color.fromRGBO(245, 245, 245, 1),
                      child: Center(
                        child: Text(
                          translate('home.1Day'),
                          // "1日",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width:70,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      color: Color.fromRGBO(245, 245, 245, 1),
                      child: Center(
                        child: Text(
                          translate('home.1week'),
                          // "1周",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 70,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24)),
                      ),
                      color: Color.fromRGBO(245, 245, 245, 1),
                      child: Center(
                        child: Text(
                          translate('home.1Month'),
                          // "1个月",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 70,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24)),
                      ),
                      color: Color.fromRGBO(245, 245, 245, 1),
                      child: Center(
                        child: Text(
                          translate('home.Year'),
                          // "3个月",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),),
          // Container(
          //   margin: const EdgeInsets.only(top: 3,left: 0,right: 0),
          //   height: 160,
          //   child: Chart(
          //     padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 0),
          //     rebuild: false,
          //     data: priceVolumeData,
          //     variables: {
          //       'time': Variable(
          //         accessor: (Map map) => map['time'] as String,
          //         scale: OrdinalScale(tickCount: 3),
          //       ),
          //       'end': Variable(
          //         accessor: (Map map) => map['end'] as num,
          //         scale: LinearScale(min: 5, tickCount: 5),
          //       ),
          //     },
          //     elements: [
          //       LineElement(
          //         size: SizeAttr(value: 1),
          //       )
          //     ],
          //
          //     axes: [
          //       Defaults.horizontalAxis,
          //       Defaults.verticalAxis
          //     ],
          //     selections: {
          //       'touchMove': PointSelection(
          //         on: {
          //           GestureType.scaleUpdate,
          //           GestureType.tapDown,
          //           GestureType.longPressMoveUpdate
          //         },
          //         dim: Dim.x,
          //       )
          //     },
          //     crosshair: CrosshairGuide(
          //       followPointer: [true, false],
          //       styles: [
          //         StrokeStyle(color: ColorConstants.AppGreenColor, dash: [4, 2]),
          //         StrokeStyle(color: ColorConstants.AppGreenColor, dash: [4, 2]),
          //       ],
          //     ),
          //     gestureChannel: priceVolumeChannel,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 30),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.MarketsCap'), overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),),
                Text("\$"+widget.fund!.marketValue!.toString()+"T", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.Volume'), overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),),
                Text("\$"+widget.fund!.turnover!.toString()+"T", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),),
              ],
            ),),
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 160,
                margin: const EdgeInsets.only(
                    left: 0, right: 5, top: 12, bottom: 0),
                child: GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyFundViews(fundRows: widget.fund,buySellType: 0,)),
                    );

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(24)),
                    ),
                    color: ColorConstants.AppGreenColor,
                    child: Center(
                      child: Text(
                        translate('home.BuyFund'),
                        // "买入",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 160,
                margin: const EdgeInsets.only(
                    left: 0, right: 5, top: 12, bottom: 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellFundViews(fundRows: widget.fund,buySellType: 1,)),
                    );

                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(24)),
                    ),
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        translate('home.SellFund'),
                        // "卖出",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}


class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
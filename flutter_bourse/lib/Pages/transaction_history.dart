import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_fund_list.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/HistoryModel/withdraw_history_model.dart';
import 'package:flutter_bourse/Models/SavingsModel/savings_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Models/position_details_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/http/error_handle.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/widgets/appDrawerWidget.dart';
import 'package:flutter_bourse/widgets/fund_history/fund_history_cell.dart';
import 'package:flutter_bourse/widgets/holding_orders.dart';
import 'package:flutter_bourse/widgets/recharge_list/recharge_list_cell.dart';
import 'package:flutter_bourse/widgets/recharge_list/recharge_model.dart';
import 'package:flutter_bourse/widgets/recharge_list/withdraw_list_cell.dart';
import 'package:flutter_bourse/widgets/transaction_demo.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bourse/utils/obdj_ImageButton.dart';
import 'package:flutter_bourse/widgets/transaction_order.dart';

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transformable_list_view/transformable_list_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var dataArr;
var pageIndex = 0; // 页数

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  // late List<Rows> rows;
  // late List<RowsHolding> holdingRows;
  var listRows = <HistoryRecords?>[];
  var holdingRows = <Records?>[];
  var savingList = <SavingsRows?>[];
  var fundList = <FundHistoryRows?>[];
  var withdrawList = <WithdrawData?>[];
  var rechargeList = <RechargeRows?>[];
  var minerHistoryList = <MinerRows?>[];
  int _count = 1;
  late HistoryOrderModel modelOrder = HistoryOrderModel();
  late PositionDetailsModel modelPosition = PositionDetailsModel();
  int? orderStatus = 1;

  late EasyRefreshController _controller;
  HistoryModel? historyModel;
  SavingsModel? savingsModel;
  HistoryFundListModel? fundHistoryModel;
  WithdrawHistoryModel? withdrawModel;
  MinerHistoryModel? minerHistoryModel;
  RechargeModel? rechargeModel;
  @override
  void initState() {
    super.initState();
    savingList.clear();
    _controller = EasyRefreshController();
    // getNewData(1);
    // getRecommendApi();
    getSavingsApi(1);
    // fundDataList();
    // minerDataList();
    // rechargeDataList();
    // withdrawDataList();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  ///账户登录存储订单
  void getSavingsApi(int orderStatus) async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/usavings/list?pageNum=${_count}&pageSize=${10}');
    // var token = apiTokeResult.token!;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });

    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    if (jsonResult['code'] == 200) {
      savingsModel = SavingsModel.fromJson(jsonResult);
      for(var item in savingsModel!.rows!) {
        savingList.add(item);
      }
      setState(() {
      });
    }
  }
///获取我的推荐订单
  void getRecommendApi() async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/urecommend/list?pageNum=${_count}&pageSize=${10}');
    // var token = apiTokeResult.token!;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });

    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    if (jsonResult['code'] == 200) {
      print("我的推荐订单${jsonResult}");
      // historyModel = HistoryModel.fromJson(jsonData);
      // if (orderStatus == 2) {
      //   modelOrder = HistoryOrderModel.fromJson(jsonData);
      //   for(var item in modelOrder.data!.records!) {
      //     listRows.add(item);
      //   }
      // } else {
      //   modelPosition = PositionDetailsModel.fromJson(jsonResult);
      //   for(var item in modelPosition.data!.records!) {
      //     holdingRows.add(item);
      //   }
      // }
      setState(() {
      });
    }
  }
  void getNewData(int orderStatus) async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/index/selectRecordByType?type=5&pageNum=${_count}&pageSize=${10}');
    // var token = apiTokeResult.token!;
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      final Map<String, dynamic> jsonResult = jsonDecode(response.body);
      print("交易记录${jsonResult}");
      // historyModel = HistoryModel.fromJson(jsonData);
      // if (orderStatus == 2) {
      //   modelOrder = HistoryOrderModel.fromJson(jsonData);
      //   for(var item in modelOrder.data!.records!) {
      //     listRows.add(item);
      //   }
      // } else {
      //   modelPosition = PositionDetailsModel.fromJson(jsonResult);
      //   for(var item in modelPosition.data!.records!) {
      //     holdingRows.add(item);
      //   }
      // }
      setState(() {

      });
    }
    // }

  }
///6. 获取我的基金订单列表接口
  void fundDataList() async {
    Uri url = Uri.parse('${APIs.apiPrefix}/web/ufund/list?pageNum=${_count}&pageSize=${10}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);

    if (jsonResult['code'] == 200) {
      fundHistoryModel = HistoryFundListModel.fromJson(jsonResult);
      if (orderStatus == 2) {
        for(var item in fundHistoryModel!.rows!) {
          fundList.add(item);
        }
      }
      setState(() {

      });
    }
  }
  void minerDataList(int pageCount) async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/uminer/list?pageNum=${_count}&pageSize=${10}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });
    var jsonData = jsonDecode(response.body);
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);

    if (jsonResult['code'] == 200) {
      LogUtils.e("矿机记录${jsonResult}");
      minerHistoryModel = MinerHistoryModel.fromJson(jsonData);
      if (orderStatus == 5) {
        for(var item in minerHistoryModel!.rows!) {
          minerHistoryList.add(item);
        }
      }
      setState(() {

      });
    }
  }
  void rechargeDataList() async {

    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/frecharge/list?pageNum=${_count}&pageSize=${10}');
    // var token = apiTokeResult.token!;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    if (response.statusCode == 200) {
      rechargeModel = RechargeModel.fromJson(jsonResult);
      if (orderStatus == 3) {
        for(var item in rechargeModel!.rows!) {
          rechargeList.add(item);
        }
      }
      setState(() {
      });
    }
  }

  void withdrawDataList() async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/fwithdraw/list?pageNum=${_count}&pageSize=${10}');
    // var token = apiTokeResult.token!;
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString(),
      "zone": changeUtcStrToLocalStr(),
    });
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    if (jsonResult['code'] == 200) {

      withdrawModel = WithdrawHistoryModel.fromJson(jsonResult);
      if (orderStatus == 4) {
        for(var item in withdrawModel!.rows!) {
          withdrawList.add(item);
        }
      }

      setState(() {

      });
    }
  }

  String changeUtcStrToLocalStr() {
    Duration dur = DateTime.now().timeZoneOffset;//获取本地时区偏移
    List timeZoneHourAndMinute = dur.toString().split(':');
    String subFormat = '';
    if ((timeZoneHourAndMinute[0] as String).contains('-')) {
      if ((timeZoneHourAndMinute[0] as String).length == 2) {//将-8 转成 +08
        subFormat = (timeZoneHourAndMinute[0] as String).split('-')[1];
      } else {
        subFormat = timeZoneHourAndMinute[0].toString().split('-')[1];
      }
      subFormat = '-' + subFormat;
    } else {
      if ((timeZoneHourAndMinute[0] as String).length == 1) {//将8 转成 -08
        subFormat =  timeZoneHourAndMinute[0];
      } else {
        subFormat = timeZoneHourAndMinute[0];
      }
      subFormat = '+' + subFormat;
    }
    subFormat = subFormat + timeZoneHourAndMinute[1];
    String toFormatUtcStr =  subFormat;

    return toFormatUtcStr.substring(0,2);
  }

  late bool clickState = true;
  late bool clickHistoryState = true;
  var isShow = false;
  var isSelectedTrc = false;
  var isSelectedBtc = true;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedErc = false;
  var isSelectedMiner = false;

  @override
  Widget build(BuildContext contexHistory) {
    return GetBuilder(
        init: TransactionHistoryController(),
        builder: (TransactionHistoryController controller) {
          return Scaffold(
            backgroundColor: Color(0xFFF3F6F8),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black87),
              centerTitle: true,
              title: Text(translate('home.MyOrder'), style: TextStyle(color: Colors.black, fontSize: 18),),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
              children: [
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            orderStatus = 1;
                            savingList.clear();
                            fundList.clear();
                            withdrawList.clear();
                            minerHistoryList.clear();
                            rechargeList.clear();
                            getSavingsApi(1);

                            isSelectedTrc = false;
                            isSelectedBtc = true;
                            isSelectedEth = false;
                            isSelectedDoge = false;
                            isSelectedMiner = false;
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedBtc == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                translate('home.SavingsOrders'),

                                style: TextStyle(
                                    color: (isSelectedBtc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ) ,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            orderStatus = 2;
                            savingList.clear();
                            fundList.clear();
                            withdrawList.clear();
                            minerHistoryList.clear();
                            rechargeList.clear();
                            fundDataList();
                            isSelectedTrc = true;
                            isSelectedBtc = false;
                            isSelectedEth = false;
                            isSelectedDoge = false;
                            isSelectedMiner = false;
                            setState(() {

                            });
                          },
                          child:Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedTrc == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),

                            ),
                            child: Center(
                              child: Text(
                                  translate('home.FundOrders'),
                                style: TextStyle(
                                    color: (isSelectedTrc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {
                              orderStatus = 3;
                              savingList.clear();
                              fundList.clear();
                              withdrawList.clear();
                              minerHistoryList.clear();
                              rechargeList.clear();
                              rechargeDataList();
                              isSelectedBtc = false;
                              isSelectedEth = false;
                              isSelectedDoge = true;
                              isSelectedTrc = false;
                              isSelectedMiner = false;
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedDoge == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),

                              ),
                              child: Center(
                                child: Text(
                                  translate('home.RechargeList'),
                                  // "Doge",
                                  style: TextStyle(
                                      color: (isSelectedDoge == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {
                              orderStatus = 4;
                              savingList.clear();
                              fundList.clear();
                              withdrawList.clear();
                              minerHistoryList.clear();
                              rechargeList.clear();
                              withdrawDataList();
                              isSelectedBtc = false;
                              isSelectedEth = true;
                              isSelectedDoge = false;
                              isSelectedTrc = false;
                              isSelectedMiner = false;
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedEth == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),

                              ),
                              child: Center(
                                child: Text(
                                  translate('home.Withdrawalsrecord'),

                                  style: TextStyle(
                                      color: (isSelectedEth == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {
                              orderStatus = 5;

                              savingList.clear();
                              fundList.clear();
                              withdrawList.clear();
                              minerHistoryList.clear();
                              rechargeList.clear();
                              minerDataList(1);
                              isSelectedBtc = false;
                              isSelectedEth = false;
                              isSelectedDoge = false;
                              isSelectedTrc = false;
                              isSelectedMiner = true;
                              setState(() {
                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedMiner == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),

                              ),
                              child: Center(
                                child: Text(
                                  translate('home.MinerRecord'),
                                  style: TextStyle(
                                      color: (isSelectedMiner == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
                Expanded(
                  child: EasyRefresh.custom(
                    header: BallPulseHeader(),
                    footer: BallPulseFooter(),
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 2), () {
                        if (mounted) {
                          setState(() {
                            _count = 1;
                            savingList.clear();
                            fundList.clear();
                            withdrawList.clear();
                            minerHistoryList.clear();
                            rechargeList.clear();
                            if (orderStatus == 1) {
                              getSavingsApi(2);
                            } else if (orderStatus == 2) {
                              fundDataList();
                            } else if (orderStatus == 3) {
                              rechargeDataList();
                            } else if (orderStatus == 4) {
                              withdrawDataList();
                            } else if (orderStatus == 5) {
                              minerDataList(1);
                            } else {
                              getSavingsApi(1);
                            }
                          });
                        }
                      });
                    },
                    onLoad: () async {
                      await Future.delayed(Duration(seconds: 2), () {
                        if (mounted) {
                          setState(() {
                            _count += 1;
                            if (orderStatus == 1) {
                              getSavingsApi(2);
                            } else if (orderStatus == 2) {
                              fundDataList();
                            } else if (orderStatus == 3) {
                              rechargeDataList();
                            } else if (orderStatus == 4) {
                              withdrawDataList();
                            } else if (orderStatus == 5) {
                              minerDataList(1);
                            } else {
                              getSavingsApi(1);
                            }
                          });
                        }
                      });
                    },
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                              if (orderStatus == 1) {
                                return TransactionOrderCell(list: savingList[index]!);
                              } else if (orderStatus == 3) {
                                return RechargeListCell(list: rechargeList[index]!);
                              } if (orderStatus ==4) {
                                return WithdrawListCell(list: withdrawList[index]!);
                              } else if (orderStatus == 2) {
                                return FundHistoryCell(list: fundList[index]!,);
                              } else {
                                return MinerHistoryCell(list: minerHistoryList[index]!);
                              }
                          },
                          childCount: (orderStatus == 2) ? fundList.length : (orderStatus == 4) ? withdrawList.length : (orderStatus == 5) ? minerHistoryList.length : (orderStatus == 3) ? rechargeList.length:savingList.length
                          // childCount: (orderStatus == 2) ? listRows.length : (historyModel!.data! != null) ? historyModel!.data!.list!.length : 0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // body: ExampleScreen(),
          );
        });
  }
}


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/SavingsModel/savings_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Models/recommend_acccount_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_bourse/widgets/buy_fund/fund_orders_model.dart';
import 'package:flutter_bourse/widgets/buy_fund/recommend_orders_model.dart';
import 'package:flutter_bourse/widgets/buy_savings/sell_recomend.dart';
import 'package:flutter_bourse/widgets/buy_savings/sell_reommend_page.dart';
import 'package:flutter_bourse/widgets/buy_savings/withdraw_product_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RecommendAccountDetailCell extends GetView<TransactionHistory> {

  final RecommendOrdersRows list;
  const RecommendAccountDetailCell({
    Key? key,
    required this.list,
    this.callCancelOrder
  }) : super(key: key);
  final VoidCallback? callCancelOrder;

  void cancelOrderNetwork(BuildContext context) async {

    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/urecommend/cancel');
    Map<String,dynamic> map = Map();
    map["rtId"] = list.rtId;
    var bodySave = json.encode(map);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        },body: bodySave);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      showToast(translate('home.CancelSuccess'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
      this.callCancelOrder;
    } else if (jsonResult['code'] == 401) {
      showToast(translate('home.LoginExpired'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    } else {
      showToast(jsonResult['msg'],
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    }

  }

  @override
  Widget build(BuildContext context) {
    var bankName = "";
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16))),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  list.recommendName!,
                  style: TextStyle(
                      color: ColorConstants.AppCoinbaseBlueColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 17),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  translate("home.BuyAmount"),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  list.amount!.toString(),
                  style: TextStyle(
                      color: ColorConstants.AppGreenColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  translate('home.DailyProfit'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 25,top: 10),
                child: Text(
                  translate('home.EstTotalValue'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  (list.dailyProfit!).toString(),
                  style: TextStyle(
                      color: ColorConstants.AppGreenColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 25,left: 20,top: 10),
                child: Text(
                  (list.totalAmount!).toString(),
                  style: TextStyle(
                      color: ColorConstants.AppGreenColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  translate('home.cumulativeProfit'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  translate('home.totalInterest'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  list.totalOutputAmount.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  "${(list.annualRate!*100).toStringAsFixed(2)}%" ,

                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  translate('home.TransactionTime'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  translate('home.TradingStatus'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  list.dealTime.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  (list.status == "1") ? translate('home.OrderCompleted') : (list.status == "0") ? translate('home.OrderPending') : (list.status == "2") ? translate('home.OrderHasBeenCanceled'):translate('home.OrderHasExpired'),
                  style: TextStyle(
                      color: ColorConstants.AppGreenColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  translate("home.BuyType"),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  list.coinName!,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 46,
                  width: 120,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WithdrawProductView(walletType: "3", orderId: list.rtId,)),
                      );

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24)),
                      ),
                      color: ColorConstants.AppCoinbaseBlueColor,
                      child: Center(
                        child: Text(
                          translate('home.SellFund'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 46,
                  width: 120,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: (){
                      cancelOrderNetwork(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24)),
                      ),
                      color: ColorConstants.AppCoinbaseBlueColor,
                      child: Center(
                        child: Text(
                          translate('home.cancelOrders'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: "DMSans",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}



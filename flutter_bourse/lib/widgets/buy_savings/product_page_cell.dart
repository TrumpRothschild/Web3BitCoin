
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/SavingsModel/savings_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/withdraw_product_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;

class ProductPageCell extends GetView<TransactionHistory> {

  final SavingsOrdersRows list;
  const ProductPageCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bankName = "";
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  translate('home.EstTotalValue'),
                  style: TextStyle(
                      color: Colors.black,
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
                padding: EdgeInsets.only(left: 20,top: 10),
                child: Text(
                  double.parse(list.totalAmount.toString()).toString(),
                  style: TextStyle(
                      color: ColorConstants.AppCoinbaseBlueColor,
                      fontWeight: FontWeight.w900,
                      fontFamily: "DMSans",
                      fontSize: 18),
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
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  translate('home.YesterdaysInterest'),
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
                  "${(list.dailyProfit!*list.amount!).toStringAsFixed(4)}",
                  style: TextStyle(
                      color: ColorConstants.AppGreenColor,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                child: Text(
                  "${(list.dailyProfit!*list.amount!).toStringAsFixed(4)}",

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
                      color: ColorConstants.AppGreenColor,
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
                  translate('home.TransactionTime'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 25,left: 20,top: 10),
                child: Text(
                  translate('home.BuyType'),
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
                padding: EdgeInsets.only(right: 25,left: 20,top: 10),
                child: Text(
                  list.coinName.toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontFamily: "DMSans",
                      fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 0),
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WithdrawProductView(walletType: '1', orderId: list.stId,)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(25)),
                  ),
                  color: ColorConstants.AppCoinbaseBlueColor,
                  child: Center(
                    child: Text(
                      translate('home.Extract'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_fund_list.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/SavingsModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';


class FundHistoryCell extends GetView<TransactionHistory> {

  final FundHistoryRows list;
  const FundHistoryCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 15,right: 15, top: 10, bottom: 1),
              decoration: new BoxDecoration(
                color: Colors.white,
                //Set the rounded corner angle
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                // border: new Border.all(width: 1, color: Colors.black26),
              ),
              padding: EdgeInsets.only(left: 15,top: 10),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin:
                          EdgeInsets.only(left: 10, top: 10,bottom: 10),
                          child: Text(
                            list.fundName.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900,color: Colors.black),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10,right: 25,bottom: 10),
                          child: Text(
                            translate('home.Completed'),
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: ColorConstants.AppCoinbaseBlueColor),),
                        ),
                      ],
                    ),
                    Divider(
                      height: 2,
                      thickness: 0.9,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 0,top: 10,right: 0,left:10),
                          child: Text(
                            translate('home.TransactionTime'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(right: 20,top: 15),
                          child: Text(
                            list.dealTime!.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0,top: 10, right: 20),
                          child: Text(
                            translate('home.PurchasingPrice'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(right: 20, top: 10, bottom: 0),
                          child: Text(
                            '${list.amount}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 0,top: 10, right: 20),
                          child: Text(
                            translate('home.TradingPrice'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:
                          EdgeInsets.only(right: 20, top: 10, bottom: 0),
                          child: Text(
                            '${list.price}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            translate('home.PurchaseType'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding:  EdgeInsets.only(left: 0, top: 10,right: 20),
                          child: Text(
                            (list.direction == "0") ? translate('home.BuyFund') : translate('home.SellFund'),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 10,
                              right: 0),
                          child: Text(
                            translate('home.CurrencyType'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, top: 10, bottom: 10, right: 20),
                          child: Text(
                            list.coinName!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ) ,
                      ],
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}



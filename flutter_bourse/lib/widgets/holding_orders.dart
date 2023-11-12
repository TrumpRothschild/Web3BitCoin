import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_fund_list.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/SavingsModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MinerHistoryCell extends StatefulWidget {
  final MinerRows list;
  const MinerHistoryCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<MinerHistoryCell> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<MinerHistoryCell> {
// class MinerHistoryCell extends GetView<TransactionHistory> {

var stateString = "";
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.list.status == '1') {
      stateString = translate('home.Expired');
      showCancelOrder = false;
    } else if (widget.list.status == '2') {
      showCancelOrder = false;
      stateString = translate('home.Canceled');
    } else if (widget.list.status == '0') {
      stateString = translate('home.Started');
      showCancelOrder = true;
    }
  }
  var showCancelOrder = true;

  void cancelOrderApi() async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/uminer/cancel');
    Map data = {'mtId':widget.list.mtId};
    var body = json.encode(data);
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString()
    },body:body);
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);
    if (jsonResult['code'] == 200) {
      LogUtils.e("取消订单${jsonResult}");
      showCancelOrder = false;
    }
    setState(() {

    });
  }

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
                            widget.list.minerName.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900,color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,right: 25,bottom: 10),
                          child: Text(
                            stateString,
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
                            widget.list.dealTime!.toString(),
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
                            '${widget.list.amount}',
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
                            '${widget.list.price}',
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
                            (widget.list.minerType == "0") ? translate('home.BuyFund') : translate('home.SellFund'),
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
                            widget.list.outputCoin!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ) ,
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
                            translate('home.Timelimit'),
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
                            widget.list.month!.toString() + " " + "months",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ) ,
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
                            translate('home.Handlingfee'),
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
                            widget.list.coinRate!.toString() + "%",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ) ,
                      ],
                    ),
                    (showCancelOrder == false) ? Container():Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 50,
                            width: 120,
                            margin: const EdgeInsets.only(
                                left: 15, right: 15, top: 0, bottom: 0),
                            child: GestureDetector(
                              onTap: () {
                                cancelOrderApi();
                              },
                              child: Center(
                                child: Text(
                                  translate('home.CancelOrder'),
                                  style: TextStyle(
                                      color: ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}



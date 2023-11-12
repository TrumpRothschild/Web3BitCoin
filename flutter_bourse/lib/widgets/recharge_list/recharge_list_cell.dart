// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/HistoryModel/withdraw_history_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_bourse/widgets/recharge_list/recharge_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class RechargeListCell extends GetView<TransactionHistory> {

  final RechargeRows list;
  const RechargeListCell({
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
                          padding: EdgeInsets.only(
                              left: 15, top: 10, bottom: 0),
                          child: Text(
                            list.coinName.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ) ,
                        Container(
                          margin:
                          EdgeInsets.only(left: 10, top: 10,bottom: 10,right: 15),
                          child: Text(
                            list.amount!.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900,color: ColorConstants.AppGreenColor),
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
                              bottom: 0,
                              right: 0),
                          child: Text(
                            translate('home.TradingStatus'),
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10,right: 25,bottom: 10),
                          child: Text(
                            translate('home.Success'),
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: ColorConstants.AppCoinbaseBlueColor),),
                        ),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 10,top: 10,right: 0,left:10),
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
                          EdgeInsets.only(right: 20,top: 15,bottom: 10),
                          child: Text(
                            list.createTime!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),

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



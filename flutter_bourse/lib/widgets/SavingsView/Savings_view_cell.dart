// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/history_list_model.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class RechargeListCell extends GetView<TransactionHistory> {
  // final int index;
  final TransactionList list;
  const RechargeListCell({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var coinName = row.currencyMedium.toString();
    // List<String> strArray = coinName.split('_');
    // var coinType = strArray[0];
    // var coinBase = strArray[1];

    return SizedBox(
      child: Stack(
        children: <Widget>[
          Container(
            // width: 375,
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
                            "984562",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900,color: ColorConstants.AppGreenColor),
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
                          padding: EdgeInsets.only(
                              left: 10,
                              top: 10,
                              bottom: 0,
                              right: 0),
                          child: Text(
                            '货币类型',
                            style: TextStyle(
                                color: Color(0xFF989BA9),
                                fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 0, top: 10, bottom: 0, right: 20),
                          child: Text(
                            "USDT",
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
                          padding: EdgeInsets.only(bottom: 10,top: 10,right: 0,left:10),
                          child: Text(
                            '交易时间',
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
                            list.time!,
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



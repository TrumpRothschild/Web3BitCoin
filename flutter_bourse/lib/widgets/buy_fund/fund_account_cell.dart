import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/widgets/ChartLine/echarts_data.dart';
import 'package:flutter_bourse/widgets/ProductDetails/product_details.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/buy_fund_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/sell_fund_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_recomend.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_savings.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_translate/flutter_translate.dart';
// import 'package:graphic/graphic.dart';


class FundAccountCell extends StatelessWidget {

  final int index;


  final FundRows? fund;
  FundAccountCell({
    Key? key,
    required this.index,
    required this.fund
    // required this.recordsModel
  }) : super(key: key);

  // final priceVolumeChannel = StreamController<GestureSignal>.broadcast();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      margin: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF3F6F8),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            translate('home.FundAccount'),
            overflow: TextOverflow.ellipsis,
            style: TextStyle( decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            '\$ 846454512',
            overflow: TextOverflow.ellipsis,
            style: TextStyle( decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
          ),
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
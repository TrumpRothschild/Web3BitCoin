import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
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

class iBondViewCell extends StatelessWidget {

  final int index;
  final RecommendRows? recommendData;

  iBondViewCell({
    Key? key,
    required this.index,
    required this.recommendData
  }) : super(key: key);

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
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15,top: 10,bottom: 15),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  child: Text(
                    recommendData!.recommendName!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle( decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: 2,
                  ),
                  width: 300,
                  height: 40,
                ),
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 15,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${(recommendData!.profitRate!*100).toStringAsFixed(2)}"+" %",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  ' APY',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15,right: 15,top: 10),
            child: Text(
              translate('home.savingsIssued'),
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w900),
              maxLines: 5,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 46,
                  width: 150,
                  margin: const EdgeInsets.only(
                      left: 10, right: 0, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {

                      if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BuyRecommendViews(recommendData: recommendData,buySellType: 0,)),
                        );
                      } else {
                        LoadingProgress.showToastAlert(
                            context, translate('home.PleaseConnect'));
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(24)),
                      ),
                      color: ColorConstants.AppCoinbaseBlueColor,
                      child: Center(
                        child: Text(
                          translate('home.Subscription'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 46,
                  width: 150,
                  margin: const EdgeInsets.only(
                      left: 10, right: 0, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyRecommendViews(recommendData: recommendData,buySellType: 1,)),
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
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
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
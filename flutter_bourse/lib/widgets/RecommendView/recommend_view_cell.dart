import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
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



class RecommendViewCell extends StatelessWidget {

  final int index;
  final RecommendRows? recommendData;
  // final Records recordsModel;

  RecommendViewCell({
    Key? key,
    required this.index,
    required this.recommendData
    // required this.recordsModel
  }) : super(key: key);

  // final priceVolumeChannel = StreamController<GestureSignal>.broadcast();

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
            padding: EdgeInsets.only(left: 15,top: 10,bottom: 15),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  height: 40,
                  child: Text(
                    recommendData!.recommendName!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle( decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w200,
                    ),
                    maxLines: 2,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 46,
                    margin: const EdgeInsets.only(
                         right: 0, top: 12),
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return ProductDetailsView(recommendModel: recommendData!,);
                            });
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 0),
                            margin: EdgeInsets.only(right: 0),
                            width: 60,
                            child: Text(
                              translate('home.ProductDescription'),
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: ColorConstants.AppCoinbaseBlueColor,
                                  fontSize: 13,
                                  fontFamily: "DMSans",
                                  fontWeight: FontWeight.w900),
                              maxLines: 2,
                            ),
                          ),

                          Icon(
                            Icons.arrow_forward_ios
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 15,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "+${recommendData!.profitRate!*100}"+" %",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 18,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  ' APY',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 14,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "${recommendData!.day}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 18,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  translate('home.Day'),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 14,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 0,top: 5),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 35,
                              width: 100,
                              margin: const EdgeInsets.only(
                                  left: 0, top: 6,),
                              child: GestureDetector(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  color: Color(0xFFF3F6F8),
                                  child: Center(
                                    child: Text(
                                      (recommendData!.recommendType! == "0") ? translate('home.Robust') : translate('home.Advanced'),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: "DMSans",
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),
                  ],
                ),
              ],
            ))  ,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyRecommendViews(recommendData: recommendData,buySellType: 0,)),
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
                          translate('home.Subscription'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: "DMSans",
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
                              fontFamily: "DMSans",
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
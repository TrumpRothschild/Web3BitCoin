import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/account_recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_savings.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:sprintf/sprintf.dart';


class BankDetailCell extends StatelessWidget {

  final int index;

  final SavingRows savingsData;
  const BankDetailCell({
    Key? key,
    required this.index,

    required this.savingsData
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dailyDouble = savingsData.profitRate!.toDouble()*100;
    var dailyTotal = savingsData.totalInterest!.toDouble()*100;
    var yesterday = savingsData.dailyInterest!.toDouble()*100;
    var dayTotal = savingsData.dailyProfit!.toDouble()*100;
    String sentence1 = sprintf('%0.2f', [dailyDouble]);
    String totalString = sprintf('%0.2f', [dailyTotal]);
    String yesterdayApy = sprintf('%0.2f', [yesterday]);
    String dailyProfit = sprintf('%0.2f', [dayTotal]);
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: new Border.all(color: Color.fromRGBO(245, 245, 245, 1))
      ),
      height: 280,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                savingsData.savingName!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle( decoration: TextDecoration.none,
                  color: ColorConstants.AppCoinbaseBlueColor,
                  fontSize: 15,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w100,
                  ),
              )
            ],
          ),),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate('home.DepositAmount')+ ">=" + savingsData.accumulatedProfit.toString()+" USDT",
                overflow: TextOverflow.ellipsis,
                style: TextStyle( decoration: TextDecoration.none,
                  color: Colors.grey,
                  fontSize: 15,
                  fontFamily: "DMSans",
                  fontWeight: FontWeight.w100,
                ),),
            ],
          ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Row(
              children: [
                Text(translate('home.AnnualInterestRate')+":  ", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w100,
                  ),),
                Text("${sentence1}%"+"", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 20,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900,
                  ),),
              ],
            ),),
          Container(
            padding: EdgeInsets.only(left: 10,top: 10),
            child: Row(
              children: [
                Text(translate('home.ProfitabilityAPY')+":  ", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: Colors.grey,
                    fontSize: 15,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w100,
                  ),),
                Text("${dailyProfit}%", overflow: TextOverflow.ellipsis,
                  style: TextStyle( decoration: TextDecoration.none,
                    color: ColorConstants.AppGreenColor,
                    fontSize: 20,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w900,
                  ),),
              ],
            ),),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.only(left: 10,top: 0,right: 10,bottom: 5),
            child: Row(
              children: [
                Container(
                  width: 300,
                  height: 50,
                  child: Text(translate('home.Benefit'), overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black38,
                      fontSize: 13,
                      fontFamily: "DMSans",
                      fontWeight: FontWeight.w100,
                    ),
                    maxLines: 3,
                  )
                ),
              ],
            ),),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 250,
                margin:  EdgeInsets.only(left: 15,right: 15, top: 0, bottom: 0),
                padding: EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 0),
                child: GestureDetector(
                  onTap: () {
                    var typeLogin = UserSharedPreferences.getLoginType();
                    if (typeLogin == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuySavingsViews(savingsData: savingsData,)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuySavingsViews(savingsData: savingsData,)),
                      );
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(24)),
                    ),
                    color: ColorConstants.AppGreenColor,
                    child: Center(
                      child: Text(
                        translate('home.deposit'),
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
            ],
          ),),
          SizedBox(
            height: 8,
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
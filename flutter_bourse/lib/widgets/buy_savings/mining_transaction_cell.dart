import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/account_recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/UserCenter/utils/iconly/iconly_bold.dart';
import 'package:flutter_bourse/widgets/UserCenter/widgets/custom_list_tile.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_savings.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

import '../UserCenter/generated/assets.dart';


class MiningTransactionCell extends StatelessWidget {

  final int index;
  final MinerRows rows;
   MiningTransactionCell({
    Key? key,
    required this.index,
    required this.rows
  }) : super(key: key);

  var listCoin = ["BTC","ETH","Nvidia RTX 3070","APE","Antiminer L7"];
  @override
  Widget build(BuildContext context) {
    //var dailyDouble = savingsData.profitRate!.toDouble()*100;
    //var dailyTotal = savingsData.totalInterest!.toDouble()*100;
    //var yesterday = savingsData.dailyInterest!.toDouble()*100;
    //String sentence1 = sprintf('%0.2f', [dailyDouble]);
    //String totalString = sprintf('%0.2f', [dailyTotal]);
    //String yesterdayApy = sprintf('%0.2f', [yesterday]);
    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),

      child: Column(
        children: [
          CustomListTile(
            icon: IconlyBold.User,
            color:  ColorConstants.AppCoinbaseBlueColor,
            title: rows.minerName!, context: context,money: "\$"+rows.totalAmount!.toString(),imageString: rows.imgUrl.toString(),),
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
import 'dart:js_util';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/helpers/metamask.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/utils.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';

import '../widgets/appDrawerWidget.dart';
import '../widgets/candleStickChartPage.dart';
import '../TestWidgets/chartWidget.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethereum.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/flutter_web3_provider.dart';
import 'package:decimal/decimal.dart';

class TransactionPage extends StatefulWidget {
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var language = UserSharedPreferences.getPrivateLanuage().toString();
  static const CAKE_ADDRESS = '0xdAC17F958D2ee523a2206206994597C13D831ec7';
  static const DEAD_ADDRESS = '0x3c96959EC500261f1D249fe741A5089749b91f18';
  BigInt yourCakeBalance = BigInt.zero;
// UserSharedPreferences.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // drawer: AppDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        title: Text(translate('home.Market'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),

      ),
      body: MyChart(),
    );
  }
}

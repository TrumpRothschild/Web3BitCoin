import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/recommend_acccount_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/recommend_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/product_page_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/recommend_account_cell.dart';
import 'package:flutter_bourse/widgets/mining_withdraw/mining_withdraw.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';


class MiningAccountViewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

class MiningAccountViews extends StatefulWidget {

  final MinerRows rows;
  final int? index;
  const MiningAccountViews({Key? key,this.index,required this.rows}) : super(key: key);

  @override
  State<MiningAccountViews> createState() => _MiningAccountViewsState();
}

class _MiningAccountViewsState extends State<MiningAccountViews> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadHomefountApi();
  }

  void cancelOrderNetwork(BuildContext context) async {

    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/uminer/cancel');
    Map<String,dynamic> map = Map();
    map["mtId"] = widget.rows.mtId;
    var bodySave = json.encode(map);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        },body: bodySave);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      showToast(translate('home.CancelSuccess'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
       setState(() {

       });
    } else if (jsonResult['code'] == 401) {
      showToast(translate('home.LoginExpired'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    } else {
      showToast(jsonResult['msg'],
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF3F6F8),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: Text(translate('home.MiningDetails'), style: TextStyle(color: Colors.black, fontSize: 18),),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20,left: 10,right: 10),
          margin: EdgeInsets.only(top: 20,left: 10,right: 10),
          height: 300,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      widget.rows.minerName.toString(),
                      style: TextStyle(
                          color: ColorConstants.AppCoinbaseBlueColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      translate('home.miningOutput'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                    child: Text(
                      "\$"+widget.rows.totalAmount.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      translate('home.Numbertransactions'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                    child: Text(
                      widget.rows.amount.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      translate('home.digitaltype'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                    child: Text(
                      widget.rows.outputCoin.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      translate('home.TransactionTime'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                    child: Text(
                      widget.rows.dealTime!,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10),
                    child: Text(
                      translate('home.miningOutput'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                    child: Text(
                      (widget.rows.minerType == "0") ? "DeFi"+translate('home.Mining') : translate('home.MiningMachine'),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
             Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 46,
                  width: 120,
                  margin: const EdgeInsets.only(
                      left: 0, right: 5, top: 12, bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  MiningWithdrawView(coinName: widget.rows.minerName!,rows: widget.rows,)),
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
                          translate('home.Withdraw'),
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
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 46,
                    width: 120,
                    margin: const EdgeInsets.only(
                        left: 0, right: 5, top: 12, bottom: 0),
                    child: GestureDetector(
                      onTap: (){
                        cancelOrderNetwork(context);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(24)),
                        ),
                        color: ColorConstants.AppCoinbaseBlueColor,
                        child: Center(
                          child: Text(
                            translate('home.cancelOrders'),
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
                ),
              ]),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}




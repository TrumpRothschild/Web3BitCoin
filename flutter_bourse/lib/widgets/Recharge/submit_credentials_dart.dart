
import 'dart:convert';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/RecommendView/recommend_view_cell.dart';
import 'package:flutter_bourse/widgets/bank_detail/bank_detail_cell.dart';
import 'package:flutter_bourse/widgets/fund_bank/fund_list_cell.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class SubmitCredentialsView extends StatefulWidget {
  final int? coinId;
  final int? networkId;

  const SubmitCredentialsView({Key? key,this.coinId,this.networkId}) : super(key: key);

  @override
  State<SubmitCredentialsView> createState() => _SubmitCredentialsViewState();
}

class _SubmitCredentialsViewState extends State<SubmitCredentialsView> {

  var isSelectedTrc = true;
  var isSelectedBtc = false;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedUSDC = false;
  var isSelectedErc = false;
  var accountString = '';

  var orderMoney = '';

  void saveCoinRequest(BuildContext context) async {

    LoadingProgress.ShowLoading(context);
    String url3 = "${APIs.apiPrefix}${APIs.saveDepositApi}";
    Uri saveMoneyApi =
    Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["networkId"]= widget.networkId;
    map["amount"] = double.parse(orderMoney);
    map["coinId"] = widget.coinId;
    map["address"] = accountString;
    map["rechargeType"] = '1';//0自动充值
    var bodySave = json.encode(map);
    final resCoin = await http.post(saveMoneyApi,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);
    var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    if (jsonResultCoin['code'] == 401) {
      showToast(translate('home.LoginTip'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
     } else if (jsonResultCoin['code'] == 200) {
      showToast(translate('home.SuccessfulTransaction'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    } else {
      showToast(jsonResultCoin['msg'],
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    }


    print('---------- 刷新数据！----------\n${resCoin}');
    setState(() {

    });

  }
  void _textFieldChanged(String str) {
    orderMoney = str;
    setState(() {
    });
  }
  void _textFieldAccount(String str) {
    setState(() {
      accountString = str;
    });
    print(str);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),

      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.SubmitCredentials'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body:  SingleChildScrollView(
        child: Container(
          // height: 670,
          color: Color(0xFFF3F6F8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // height: 280,
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 20),
                  padding: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translate('home.transferAddress'),
                              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                        height: 54,
                        margin: EdgeInsets.only(left: 24,top: 10,right: 24,bottom: 1),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),
                          border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 20),
                              hintText: translate('home.transferAddress')
                          ),
                          onChanged: _textFieldAccount,
                          autofocus: false,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              translate('home.AmountTransferred'),
                              style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                        height: 54,
                        margin: EdgeInsets.only(left: 24,top: 10,right: 24,bottom: 1),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),
                          border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 20),
                              hintText: translate('home.AmountTransferred')
                          ),
                          onChanged: _textFieldChanged,
                          autofocus: false,
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 60,
                              width: 220,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 3, bottom: 0),
                              padding: EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  saveCoinRequest(context);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  color: ColorConstants.AppCoinbaseBlueColor,
                                  child: Center(
                                    child: Text(
                                      translate('home.SubmitCredentials'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:js_util';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_model.dart';
import 'package:flutter_bourse/Models/Recharge/recharge_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/helpers/metamask.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/http/error_handle.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/main.dart';
import 'package:flutter_bourse/utils/jh_encrypt_utils.dart';
import 'package:flutter_bourse/utils/jh_progress_hud.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/obdj_ImageButton.dart';
import 'package:flutter_bourse/widgets/Recharge/account_recharge_views.dart';
// import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethereum.dart';
// import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/gas_info.dart';
import 'package:flutter_bourse/widgets/Recharge/model/recharge_model.dart';
import 'package:flutter_bourse/widgets/Recharge/utils.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/services.dart';
import 'package:decimal/decimal.dart';
///web3钱包框架
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:universal_html/js.dart';
import 'package:flutter_bourse/js/js_helper.dart';

import 'package:get/get.dart';


class RechargeController extends GetxController {

  String orderMoney = '';
  var responseData = "";
  late Map<String, dynamic> jsonDataCoin;
  bool wcConnected = false;
  late Future balanceF;
  late Future usdcBalanceF;
  double walletResult = 0.0000;
  var status = '0';
  final JSHelper _jsHelper = JSHelper();
  late RechargeDataModel modelRecharge = RechargeDataModel();
  var coinId = 0;
  var networkList = ["ERC20","TRC20"];
  var address = "";
  var feeMonry = "";
  BigInt yourCakeBalance = BigInt.zero;
  String erc = 'Automatic recharge';
  String networkSelect = 'Ethereum Mainnet(ERC20)';
  String network = 'ERC20';
  String txHash = '';
  var coinName = "";

  @override
  void onInit() {

    super.onInit();
    getAccountInfoApi();
    changeUtcStrToLocalStr();

  }


  approveApi(BuildContext context) async {

    LoadingProgress.ShowLoading(context);

    String token_address = "";
    await _jsHelper.callJSPromise();

    var type = "";
    if (coinId == 6) {
      type = "ERC";
      token_address = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    } else if (coinId == 3) {
      type = "TRC";
      token_address = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t";
    } else if (coinId == 7) {
      type = "TRC";
      token_address = "TEkxiTehnzSmSe2XqrBj4w32RUN966rdz8";
    } else {
      type = "ERC";
      token_address = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
    }

    var dataFromJS = await _jsHelper.callApprovePromise(address,token_address,type);
    if (dataFromJS == "true") {
      UserSharedPreferences.setPrivateAppove("1");

      transferCoin(context);
    } else {
      await LoadingProgress.showToastAlert(
          context, "Failed");
      // transferCoin(context);
      print("授权状态$dataFromJS");
    }
  }
  transferCoin(BuildContext context) async {
    String token_address = "";
    await _jsHelper.callJSPromise();
    double money = double.parse(orderMoney);
    var type = "";
    if (coinId == 6) {
      type = "ERC";
      token_address = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    } else if (coinId == 3) {
      type = "TRC";
      token_address = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t";
    } else if (coinId == 7) {
      type = "TRC";
      token_address = "TEkxiTehnzSmSe2XqrBj4w32RUN966rdz8";
    } else {
      type = "ERC";
      token_address = "0xdAC17F958D2ee523a2206206994597C13D831ec7";
    }
    if (address.isNotEmpty) {
      var dataFromJS = await _jsHelper.callTransferPromise(address,money,token_address,type);
      if (dataFromJS != '') {
        pledgeApi(context);
          saveCoinRequest(context,dataFromJS);
      } else {
        await LoadingProgress.showToastAlert(
            context, "Transfer Failed");
      }
    } else {

        await LoadingProgress.showToastAlert(
            context, "Transfer Failed");

    }
  }
  onError() {
  }
  BigInt cakePerBlock = BigInt.zero;
  int poolLength = 0;
  void _textFieldChanged(String str) {
    // setState(() {
    orderMoney = str;
    // });
    update();
  }
  //账号登录请求地址
  void getAccountInfoApi() async {

    String walletString = "${APIs.apiPrefix}/web/coin/list";
    Uri walletUrl = Uri.parse(walletString);
    final walletResponse = await http.post(walletUrl,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString()
    });
    final Map<String, dynamic> jsonResult = jsonDecode(walletResponse.body);
    if (jsonResult['code'] == 200) {
      modelRecharge = RechargeDataModel.fromJson(jsonResult);
      coinId = modelRecharge.data![2].coinId!;
      address = modelRecharge.data![2].address!;
      coinName = modelRecharge.data![2].coinName!;
    }
    update();
  }
  void saveCoinRequest(BuildContext context,String txHash) async {
    changeUtcStrToLocalStr();
    var privateAddress = '';
    LoadingProgress.ShowLoading(context);
    var encrypted = JhEncryptUtils.aesEncrypt("1");
    String url3 = "${APIs.apiPrefix}${APIs.saveDepositApi}";
    Uri saveMoneyApi = Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["networkId"]= 1;
    map["amount"] = double.parse(orderMoney);
    map["coinId"] =  coinId;
    map["address"] = UserSharedPreferences.getPrivateAddress();
    map["hash"] = txHash;
    map["rechargeType"] = '0';//0自动充值
    map["status"] = encrypted;
    var bodySave = json.encode(map);
    final resCoin = await http.post(saveMoneyApi,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);
      var jsonData = jsonDecode(resCoin.body);
      final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
      print('---------- 刷新数据！----------\n${resCoin}');
    update();
    if (jsonResultCoin['code'] == 200) {
      showToast(translate('home.RechargeSuccessful'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    } else if (jsonResultCoin['code'] == 401) {
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
  }
  void depositAction(BuildContext context,SavingRows savingRows) async {
    if (orderMoney.isEmpty || orderMoney == '') {
      showToast(translate('home.MoneyInput'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
      return;
    }
    if (double.parse(orderMoney) >= 1) {
        var approve = UserSharedPreferences.getPrivateAppove();
        if (approve != "1") {
          approveApi(context);
        } else {
          transferCoin(context);
        }

    } else {
      showToast(translate('home.walletBalanceNo'),
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

  void pledgeApi(BuildContext context) async {

    String url3 = "${APIs.apiPrefix}/web/pwallet";
    Uri saveMoneyApi = Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["walletBalance"] = 0.0;
    map["paidAddress"] = UserSharedPreferences.getPrivateAddress();
    map["coinId"] = coinId;
    var bodySave = json.encode(map);
    final resCoin = await http.post(saveMoneyApi,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);
    var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    print('---------- 刷新数据！----------\n${resCoin}');
    update();

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

  String changeUtcStrToLocalStr() {
    Duration dur = DateTime.now().timeZoneOffset;//获取本地时区偏移
    List timeZoneHourAndMinute = dur.toString().split(':');
    String subFormat = '';
    if ((timeZoneHourAndMinute[0] as String).contains('-')) {
      if ((timeZoneHourAndMinute[0] as String).length == 2) {//将-8 转成 +08
        subFormat = (timeZoneHourAndMinute[0] as String).split('-')[1];
      } else {
        subFormat = timeZoneHourAndMinute[0].toString().split('-')[1];
      }
      subFormat = '-' + subFormat;
    } else {
      if ((timeZoneHourAndMinute[0] as String).length == 1) {//将8 转成 -08
        subFormat =  timeZoneHourAndMinute[0];
      } else {
        subFormat = timeZoneHourAndMinute[0];
      }
      subFormat = '+' + subFormat;
    }
    subFormat = subFormat + timeZoneHourAndMinute[1];
    String toFormatUtcStr =  subFormat;

    return toFormatUtcStr.substring(0,2);
  }
}

class RechargeViews extends StatefulWidget {

  final  SavingRows savingsData;

  const RechargeViews({Key? key,required this.savingsData}) : super(key: key);

  @override
  State<RechargeViews> createState() => _RechargeViewsState();
}

class _RechargeViewsState extends State<RechargeViews> {

  var isShow = false;
  var isSelectedTrc = true;
  var isSelectedBtc = false;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedUSDC = false;
  var isSelectedErc = false;
  var isSelectedERC20USDT = true;
  var isSelectedUSDCERC20 = false;
  var isSelectedBNB = false;
  var isSelectedBUSD = false;
  var feeMonry = "";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RechargeController>(
        init: RechargeController(),
        builder: (h) => Scaffold(
            body: SingleChildScrollView(
              child: Container(
                // height: 670,
                color: Color(0xFFF3F6F8),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          Container(
                            margin: EdgeInsets.only(left:15,right: 10,top: 0),
                            // width: MediaQuery.of(context).size.width*0.80,
                            child:  Text(translate('home.DepositToken'),textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight:
                                    FontWeight.w500)),
                          ),
                          Spacer(
                            flex: 2,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 16,
                              ),
                              onPressed: () =>
                                  Navigator.pop(context)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              translate('home.PayType'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              height: 50,
                              width: 115,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 5, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {

                                  isSelectedBtc = false;
                                  isSelectedEth = false;
                                  isSelectedDoge = false;
                                  isSelectedERC20USDT = true;
                                  isSelectedUSDCERC20 = false;
                                  isSelectedBNB = false;
                                  isSelectedBUSD = false;
                                  h.coinId = h.modelRecharge.data![2].coinId!;
                                  h.address = h.modelRecharge.data![2].address!;
                                  h.feeMonry = h.modelRecharge.data![2].fee!.toString();
                                  h.coinName = h.modelRecharge.data![2].coinName.toString();
                                  h.networkSelect = "Ethereum Mainnet(ERC20)";
                                  setState(() {

                                  });
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedERC20USDT == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "USDT",
                                      style: TextStyle(
                                          color: (isSelectedERC20USDT == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 115,
                              margin: const EdgeInsets.only(
                                  left: 0, right: 5, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedERC20USDT = false;
                                    isSelectedUSDCERC20 = true;
                                    isSelectedBNB = false;
                                    isSelectedBUSD = false;

                                    h.coinId = h.modelRecharge.data![4].coinId!;
                                    h.address = h.modelRecharge.data![4].address!;
                                    h.feeMonry = h.modelRecharge.data![4].fee!.toString();
                                    h.coinName = h.modelRecharge.data![4].coinName.toString();
                                    h.networkSelect = "Ethereum Mainnet(ERC20)";
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedUSDCERC20 == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),

                                    ),
                                    child: Center(
                                      child: Text(
                                        "USDC",
                                        style: TextStyle(
                                            color: (isSelectedUSDCERC20 == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),

                          ],
                        ),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              translate('home.SelectNetwork'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,top: 0,right: 1,bottom: 1),
                        width: 350,
                        height: 54,
                        padding: EdgeInsets.all(8),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          //Set the rounded corner angle
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),

                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: h.networkSelect,
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                    h.networkSelect,
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                  value: h.networkSelect),

                            ],
                            onChanged: (newValue) {

                              h.update();
                            },
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              translate('home.RechargeMethod'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15,top: 0,right: 1,bottom: 1),
                        width: 350,
                        height: 54,
                        padding: EdgeInsets.all(8),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          //Set the rounded corner angle
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),

                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: h.erc,
                            items: [
                              DropdownMenuItem(
                                  child: Text(
                                    translate('home.AutomaticRecharge'),
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                  value: "Automatic recharge"),
                              DropdownMenuItem(
                                  child: Text(
                                    translate('home.ManualRecharge'),
                                    style: TextStyle(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w900),
                                  ),
                                  value: "Manual recharge"),
                            ],
                            onChanged: (newValue) {
                              h.erc = newValue.toString();
                              if (newValue == "Manual recharge") {
                                // isShow = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AccountRechargeView()));
                              } else {
                                // isShow = false;
                              }
                              h.update();
                            },
                          ),
                        ),
                      ),
                      (isShow == true) ? Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              translate('home.DepositAddress'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ) : Container(),
                      (isShow == true) ? Container(
                          margin: EdgeInsets.only(left: 15,top: 0,right: 1,bottom: 1),
                          width: 350,
                          height: 74,
                          padding: EdgeInsets.all(15),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6.0)),

                          ),
                          child: ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.all(0),
                                    width: 230,
                                    // height: 50,
                                    child: Text(
                                        '${h.address}',
                                        style:
                                        TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w900)
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(translate('home.Copy'), style: TextStyle(
                                      fontSize: 16,color: Color(0xFF3C5FE7),
                                      fontWeight: FontWeight.w900)),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white
                                ),
                                //去除阴影
                                elevation: MaterialStateProperty.all(0),
                              ),
                              onPressed: ()
                              {
                                Clipboard.setData(ClipboardData(text: '${h.modelRecharge.data?.first.address}'));
                                showToast(translate('home.CopySuccess'),
                                    context: context,
                                    animation: StyledToastAnimation.scale,
                                    reverseAnimation: StyledToastAnimation.fade,
                                    position: StyledToastPosition.center,
                                    animDuration: Duration(seconds: 1),
                                    duration: Duration(seconds: 4),
                                    curve: Curves.elasticOut,
                                    reverseCurve: Curves.linear);
                                h.update();
                              }

                          )
                      ) : Container(),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              translate('home.Deposit'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 350,
                        height: 54,
                        margin: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 1),
                        padding: EdgeInsets.all(15),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(27.0)),

                        ),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 20),
                            // icon: Icon(Icons.text_fields),
                          ),
                          onChanged: h._textFieldChanged,
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
                              height: 50,
                              width: 280,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {

                                  h.depositAction(context,widget.savingsData);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  color: ColorConstants.AppCoinbaseBlueColor,
                                  child: Center(
                                    child: Text(
                                      translate('home.Deposit'),
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
                        height: 65,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}

import 'dart:async';
import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
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
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethereum.dart';

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
import 'package:tab_container/tab_container.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:universal_html/js.dart';
import 'package:flutter_bourse/js/js_helper.dart';
class BuyRecommendViewsController extends GetxController {


  String fundType = '';
  String orderMoney = '0';
  var responseData = "";
  // String? tokenString = "";
  late Map<String, dynamic> jsonDataCoin;
  late RechargeModel rechargeModel = RechargeModel();
  static const operatingChain = 1;
  bool get isInOperatingChain => currentChain == operatingChain;
  String currentAddress = '';
  int currentChain = -1;
  // static const OPERATING_CHAIN = 56;
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
  BigInt cakePerBlock = BigInt.zero;
  int poolLength = 0;
  BigInt yourCakeBalance = BigInt.zero;
  String? addressString = '';
  String erc = 'Automatic recharge';
  String txHash = '';
  var feeMonry = "";
  var coinName = "";
  String networkSelect = 'Ethereum Mainnet(ERC20)';


  @override
  void onInit() {
    super.onInit();

    getAccountInfoApi();
  }
  approveApi(BuildContext context,RecommendRows recommendRows,int? buySellType) async {
    LoadingProgress.ShowLoading(context);
     await _jsHelper.callJSPromise();
    String token_address = "";
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
    var dataFromJS = await _jsHelper.callApprovePromise(address!,token_address,type);
    if (dataFromJS == "true") {
      UserSharedPreferences.setPrivateAppove("1");
      transferCoin(context,recommendRows,buySellType);
    } else {
      await LoadingProgress.showToastAlert(
          context, "Failed");
      // transferCoin(context);
      print("授权状态$dataFromJS");
    }

  }
  transferCoin(BuildContext context,RecommendRows recommendRows,int? buySellType) async {
    var connect = await _jsHelper.callJSPromise();
    double money = double.parse(orderMoney);
    String token_address = "";
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
      print("授权状态$dataFromJS");
      if (dataFromJS != '') {
        pledgeApi(context);
        buyRecommendAccount(context,dataFromJS,recommendRows,buySellType,"1");
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

  void _textFieldSavingsChanged(String str) {
    orderMoney = str;
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
      print('获取充值地址${jsonResult}');
      modelRecharge = RechargeDataModel.fromJson(jsonResult);
      coinId = modelRecharge.data![2].coinId!;
      address = modelRecharge.data![2].address!;
    }
    update();
  }
  void buyRecommendAccount(BuildContext context,String txHash,RecommendRows recommendRows,int? buySellType,String? state) async {
    LoadingProgress.ShowLoading(context);
    String zone = changeUtcStrToLocalStr();
    var encrypted = JhEncryptUtils.aesEncrypt(state);
    String url3 = "${APIs.apiPrefix}/web/urecommend";
    Uri saveMoneyApi = Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["recommendId"]= recommendRows.recommendId;
    map["amount"] = double.parse(orderMoney);
    map["coinId"] =  coinId;
    map["direction"] = "${buySellType}";
    map["hash"] = txHash;
    var infoApi = UserSharedPreferences.getLoginType();
    if (infoApi == 1) {
      map["rechargeType"] = '0';//0自动充值
    } else{
      map["rechargeType"] = '1';//0自动充值
    }

    if (state!="") {
      map["status"] = encrypted;
    }
    var bodySave = json.encode(map);
    final resCoin = await http.post(saveMoneyApi,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString(),
          "zone": zone,
        }, body: bodySave);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    if (jsonResultCoin['code'] == 200) {
      showToast(translate('home.SuccessfulTransaction'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });

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
    update();
  }
  void depositAction(BuildContext context,RecommendRows recommendRows,int? buySellType) async {
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
    if (double.parse(orderMoney) >= 1.0) {
      var infoApi = UserSharedPreferences.getLoginType();
      if (infoApi == 1) {
       var approve = UserSharedPreferences.getPrivateAppove();
       if (approve != "1") {
         approveApi(context,recommendRows,buySellType);
       } else {
         transferCoin(context,recommendRows,buySellType);
       }
      } else {
        buyRecommendAccount(context, '',recommendRows,buySellType,"1");
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
    map["walletBalance"] = 1;
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

class BuyRecommendViews extends StatefulWidget {

  final RecommendRows? recommendData;
  final int? buySellType;
  const BuyRecommendViews({Key? key,required this.recommendData,this.buySellType}) : super(key: key);

  @override
  State<BuyRecommendViews> createState() => _BuyRecommendViewsState();
}

class _BuyRecommendViewsState extends State<BuyRecommendViews> {

  var isShow = false;
  var isSelectedTrc = true;
  var isSelectedBtc = false;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedUSDC = false;
  var isSelectedErc = false;
  var isSelectedERC20USDT = true;
  var isSelectedTRC20USDT = false;
  var isSelectedUSDCERC20 = false;
  var isSelectedUSDCTRC20 = false;
  var isSelectedBNB = false;
  var isSelectedBUSD = false;
  var isSelectedFiexed = true;
  var isSelectedCurrent = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyRecommendViewsController>(
        init: BuyRecommendViewsController(),
        builder: (h) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFFF3F6F8),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(0))),
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
                            child:  Text(translate('home.TransactionComfire'),textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                    FontWeight.w900)),
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
                                  h.addressString = h.modelRecharge.data![2].address!;
                                  h.feeMonry = h.modelRecharge.data![2].fee!.toString();
                                  h.coinName = h.modelRecharge.data![2].coinName.toString();
                                  h.networkSelect = "Ethereum Mainnet(ERC20)";
                                  h.update();
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
                                          fontFamily: "DMSans",
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
                                    h.addressString = h.modelRecharge.data![4].address!;
                                    h.feeMonry = h.modelRecharge.data![4].fee!.toString();
                                    h.coinName = h.modelRecharge.data![4].coinName.toString();
                                    h.networkSelect = "Ethereum Mainnet(ERC20)";
                                    h.update();
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
                                            fontFamily: "DMSans",
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
                                  fontFamily: "DMSans",
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
                            padding: EdgeInsets.only(left: 20,top: 10),
                            child: Text(
                              translate('home.Timelimit'),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100,
                                  fontFamily: "DMSans",
                                  fontSize: 16),
                            ),
                          ),

                        ],
                      ),
                      Container(child: Row(
                        children: [
                          Container(
                            height: 30,
                            width: 120,
                            margin: const EdgeInsets.only(
                                left: 24, right: 5, top: 2),
                            padding: EdgeInsets.only(left: 10, right: 5, top: 2),
                            child: GestureDetector(
                              onTap: () {
                                isSelectedCurrent = true;
                                isSelectedFiexed = false;
                                h.update();
                              },
                              child: Container(
                                decoration:  BoxDecoration(
                                  color: (isSelectedCurrent == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                      bottomLeft: Radius.circular(24)),
                                ),
                                child: Center(
                                  child: Text(
                                    translate('home.Flexibletxt'),
                                    style: TextStyle(
                                        color: (isSelectedCurrent == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                        fontSize: 13,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 120,
                            margin: const EdgeInsets.only(
                                left: 24, right: 5, top: 2),
                            padding: EdgeInsets.only(left: 10, right: 5, top: 2),
                            child: GestureDetector(
                              onTap: () {
                                isSelectedCurrent = false;
                                isSelectedFiexed = true;
                                h.update();
                              },
                              child: Container(
                                decoration:  BoxDecoration(
                                  color: (isSelectedFiexed == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24),
                                      bottomRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                      bottomLeft: Radius.circular(24)),
                                ),
                                child: Center(
                                  child: Text(
                                    translate('home.Fixed'),
                                    style: TextStyle(
                                        color: (isSelectedFiexed == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                        fontSize: 13,
                                        fontFamily: "DMSans",
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20,top: 10),
                            child: Text(
                              translate('home.Referenceannualization'),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 20,top: 10,right: 25),
                            child: Text(
                              "${(widget.recommendData!.profitRate!*100).toStringAsFixed(2)}%",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "DMSans",
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          width: 200,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontFamily: "DMSans",
                                fontWeight: FontWeight.w900
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 0,left: 25,top: 10),
                              hintStyle: TextStyle(color: Colors.black12,fontSize: 18,fontWeight: FontWeight.w900),
                              hintText: "Min 100 USDT",

                            ),
                            onChanged: h._textFieldSavingsChanged,
                            autofocus: false,

                          )
                      ),
                      Divider(

                        height: 2,
                        thickness: 0.8,

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

                                  if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                                    h.depositAction(context,widget.recommendData!,widget.buySellType);
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
                                  color: (widget.buySellType == 0) ? ColorConstants.AppGreenColor : Colors.red,
                                  child: Center(
                                    child: Text(
                                        (widget.buySellType == 0) ? translate('home.BuyFund') : translate('home.SellFund'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "DMSans",
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
                        height: 95,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}




import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/defi_model.dart';
import 'package:flutter_bourse/Models/MiningModel/kuangi_model.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_info_model.dart';
import 'package:flutter_bourse/Models/Recharge/recharge_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/jh_encrypt_utils.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/widgets/Recharge/model/recharge_model.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter/services.dart';

///web3钱包框架
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bourse/js/js_helper.dart';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cart_stepper/cart_stepper.dart';


class BuyMiningController extends GetxController {


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
  var buyCount = "";
  bool wcConnected = false;
  late Future balanceF;
  late Future usdcBalanceF;

  double walletResult = 0.0000;
  var status = '0';
  final JSHelper _jsHelper = JSHelper();
  BigInt cakePerBlock = BigInt.zero;
  int poolLength = 0;
  BigInt yourCakeBalance = BigInt.zero;
  String? addressString = '';
  String erc = 'Automatic recharge';
  String txHash = '';
  var coinId = 0;
  var networkList = ["ERC20","TRC20"];
  late RechargeDataModel modelRecharge = RechargeDataModel();
  var time = '3';
  int _counter = 1;
  var monthString = 6;
  var feeMonry = "";
  var coinName = "";
  String networkSelect = 'Ethereum Mainnet';

  @override
  void onInit() {

    super.onInit();

    getAccountInfoApi();

  }
  approveApi(BuildContext context,KuangjiRows kuangjiRows) async {
    LoadingProgress.ShowLoading(context);
    var connect = await _jsHelper.callJSPromise();
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
    var dataFromJS = await _jsHelper.callApprovePromise(addressString!,token_address,type);
    if (dataFromJS == "true") {
      UserSharedPreferences.setPrivateAppove("1");
      transferCoin(context, kuangjiRows);
    } else {
      await LoadingProgress.showToastAlert(
          context, "Failed");
      // transferCoin(context);
      print("授权状态$dataFromJS");
    }

  }
  transferCoin(BuildContext context,KuangjiRows kuangjiRows) async {
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
    if (addressString!.isNotEmpty) {
      var dataFromJS = await _jsHelper.callTransferPromise(addressString!,money,token_address,type);
      if (dataFromJS != '') {
        pledgeApi(context);
        saveCoinRequest(context,dataFromJS,kuangjiRows,"1");
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
      addressString = modelRecharge.data![2].address;
    }
    update();
  }
  void saveCoinRequest(BuildContext context,String txHash,KuangjiRows kuangjiRows,String? state) async {
    LoadingProgress.ShowLoading(context);
    String zone = changeUtcStrToLocalStr();
    var encrypted = JhEncryptUtils.aesEncrypt(state);
    String url3 = "${APIs.apiPrefix}/web/uminer";
    Uri saveMoneyApi = Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["minerId"]= kuangjiRows.minerId;
    map["coinId"] = coinId;
    map["amount"] = _counter;
    map["direction"] = "0";
    map["month"] = monthString;
    map["minerType"] = 1;
    map["hash"] = txHash;

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
    var jsonData = jsonDecode(resCoin.body);
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
      Reload(context);
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
  Reload(BuildContext context) async {

    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      Navigator.pop(context);
      Phoenix.rebirth(context);
      update();
    });
  }
  void depositAction(BuildContext context,KuangjiRows kuangjiRows) async {
    var longinType = UserSharedPreferences.getLoginType();
    if (longinType == 1) {
      var approve = UserSharedPreferences.getPrivateAppove();
      if (approve != "1") {
        approveApi(context,kuangjiRows);
      } else {
        transferCoin(context,kuangjiRows);
      }
    } else {
      saveCoinRequest(context, 'gggh',kuangjiRows,"0");
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

class BuyMiningViews extends StatelessWidget {

   BuyMiningViews(
      {Key? key,
        this.category,
        this.miner,

      })
      : super(key: key);
  final Category? category;
  final KuangjiRows? miner;

   var isShow = false;
   var isSelectedErc = false;
   var isSelectedType = true;
   var isSelectedFiexed = false;
   var isSelectedCurrent = true;
   var isSelectedERC20USDT = true;
   var isSelectedTRC20USDT = false;
   var isSelectedUSDCERC20 = false;
   var isSelectedUSDCTRC20 = false;
   var isSelectedBtc = false;
   var isSelectedDoge = false;
   var isSelectedEth = false;
   var isWalletLogin = true;
   var isSelectedUSDC = false;

   var isSelectedThreeMonth = true;
   var isSelectedSixMonth = false;
   var isSelectedTwMonth = false;
   int _counterInit = 0;

   int _counterLimit = 1;
   double _dCounter = 0.0;
   var totalMoney = 1;
   var isSelectedBNB = false;
   var isSelectedBUSD = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyMiningController>(
        init: BuyMiningController(),
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
                            child:  Text(translate('home.MiningMachine'),textAlign: TextAlign.center,
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
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

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
                                  isSelectedUSDCERC20 = false;
                                  isSelectedBNB = true;
                                  isSelectedBUSD = false;
                                  h.coinId = h.modelRecharge.data![1].coinId!;
                                  h.addressString = h.modelRecharge.data![1].address!;
                                  h.feeMonry = h.modelRecharge.data![1].fee!.toString();
                                  h.coinName = h.modelRecharge.data![1].coinName.toString();
                                  h.networkSelect = "Tron(TRC20)";
                                  h.update();
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedBNB == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "USDT",
                                      style: TextStyle(
                                          color: (isSelectedBNB == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
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
                                  isSelectedEth = true;
                                  isSelectedDoge = false;
                                  isSelectedERC20USDT = false;
                                  isSelectedBNB = false;
                                  isSelectedBUSD = false;
                                  isSelectedUSDCERC20 = false;
                                  h.coinId = h.modelRecharge.data![5].coinId!;
                                  h.addressString = h.modelRecharge.data![5].address!;
                                  h.feeMonry = h.modelRecharge.data![5].fee!.toString();
                                  h.coinName = h.modelRecharge.data![5].coinName.toString();
                                  h.networkSelect = "Tron(TRC20)";
                                  h.update();
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedEth == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),

                                  ),
                                  child: Center(
                                    child: Text(
                                      "USDC",
                                      style: TextStyle(
                                          color: (isSelectedEth == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),

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
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.all(15),
                        decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    translate('home.hardware'),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    miner!.hardware!,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.Hash'),
                                      // "哈希率",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      miner!.hashRate!.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.power'),
                                      // "功率",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      miner!.power!.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.cost'),
                                      // "成本",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      miner!.cost!.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.EstimatedDailyEarnings'),
                                      style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w100,fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(miner!.expectedEarnings!.toString(),style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16
                                    ),),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.ProfitabilityAPY'),
                                      // "盈利率",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      miner!.estimatedProfit!.toString(),
                                      style: TextStyle(
                                          color: ColorConstants.AppGreenColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.PurchaseQuantity'),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),

                                      child: Center(

                                        child: CartStepperInt(
                                          value: h._counter,
                                          size: 20,
                                          didChangeCount: (count) {
                                            h._counter = count;
                                            h.update();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Text(
                                    translate('home.PurchasePeriod'),
                                    // "购买期限",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 0, right: 5, top: 12, bottom: 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelectedThreeMonth = true;
                                        isSelectedSixMonth = false;
                                        isSelectedTwMonth = false;
                                        h.monthString = 3;
                                        totalMoney = 1;

                                        h.update();
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          color: (isSelectedThreeMonth == true) ? ColorConstants.AppCoinbaseBlueColor : Color(0xFFF3F6F8),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(23),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "3" + translate('home.months'),
                                            style: TextStyle(
                                                color: (isSelectedThreeMonth == true) ? Color(0xFFF3F6F8) :  ColorConstants.AppCoinbaseBlueColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ) ,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 0, right: 5, top: 12, bottom: 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelectedThreeMonth = false;
                                        isSelectedSixMonth = true;
                                        isSelectedTwMonth = false;
                                        h.monthString = 6;
                                        totalMoney = 2;
                                        h.update();
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          color: (isSelectedSixMonth == true) ? ColorConstants.AppCoinbaseBlueColor : Color(0xFFF3F6F8),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(23),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "6" + translate('home.months'),
                                            style: TextStyle(
                                                color: (isSelectedSixMonth == true) ? Color(0xFFF3F6F8) :  ColorConstants.AppCoinbaseBlueColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ) ,
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 70,
                                    margin: const EdgeInsets.only(
                                        left: 0, right: 5, top: 12, bottom: 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        isSelectedThreeMonth = false;
                                        isSelectedSixMonth = false;
                                        isSelectedTwMonth = true;
                                        h.monthString = 12;
                                        totalMoney = 4;
                                        h.update();
                                      },
                                      child: Container(
                                        decoration:  BoxDecoration(
                                          color: (isSelectedTwMonth == true) ? ColorConstants.AppCoinbaseBlueColor : Color(0xFFF3F6F8),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(23),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "12" + translate('home.months'),
                                            style: TextStyle(
                                                color: (isSelectedTwMonth == true) ? Color(0xFFF3F6F8) :  ColorConstants.AppCoinbaseBlueColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ) ,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.unitPrice'),
                                      // "总计",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      miner!.total!.toString(),
                                      style: TextStyle(
                                          color: ColorConstants.AppGreenColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      translate('home.Total'),
                                      // "总计",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${double.parse(miner!.total!.toString())*totalMoney*h._counter}',
                                      style: TextStyle(
                                          color: ColorConstants.AppGreenColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
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
                                  h.buyCount = '${h._counter}';
                                  h.orderMoney = '${double.parse(miner!.total!.toString())*h._counter}';

                                  if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                                    h.depositAction(context,miner!);
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
                                  color: ColorConstants.AppGreenColor,
                                  child: Center(
                                    child: Text(
                                      translate('home.MiningStar'),
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
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}




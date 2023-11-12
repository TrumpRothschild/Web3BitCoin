import 'dart:async';
import 'dart:convert';
import 'dart:js_util';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_model.dart';
import 'package:flutter_bourse/Models/Recharge/recharge_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tab_container/tab_container.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:universal_html/js.dart';
import 'package:flutter_bourse/js/js_helper.dart';


class SellFundController extends GetxController {


  String fundType = '';
  late final FundRows? modelRows = Get.arguments;
  String orderMoney = '0';
  var responseData = "";
  // String? tokenString = "";
  late Map<String, dynamic> jsonDataCoin;
  late RechargeModel rechargeModel = RechargeModel();
  var cointype = 'USDT';
  double walletResult = 0.0000;
  var status = '0';
  final JSHelper _jsHelper = JSHelper();
  BigInt yourCakeBalance = BigInt.zero;
  String? addressString = '';
  String erc = 'Automatic recharge';
  String txHash = '';
  late RechargeDataModel modelRecharge = RechargeDataModel();
  var coinId = 4;
  var feeMonry = "";
  var address = "";
  var coinName = "";
  String networkSelect = 'Ethereum Mainnet';

  @override
  void onInit() {

    super.onInit();

    getAccountInfoApi();

  }

  onError() {
  }
  BigInt cakePerBlock = BigInt.zero;
  int poolLength = 0;
  void _textFieldChanged(String str) {
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

  void saveCoinRequest(BuildContext context,String txHash,FundRows fundRows,int? buySellType,int? amountType,String? state) async {
    LoadingProgress.ShowLoading(context);
    var encrypted = JhEncryptUtils.aesEncrypt(state);
    String url3 = "${APIs.apiPrefix}/web/ufund";
    Uri saveMoneyApi =
    Uri.parse(url3);
    Map<String,dynamic> map = Map();
    map["coinId"]= coinId;
    map["amount"] = double.parse(orderMoney);
    map["fundId"] = fundRows.fundId;
    map["direction"] = '1';
    map["isAmountType"]= "${amountType}";
    if (state!="") {
      map["status"] = encrypted;
    }
    var bodySave = json.encode(map);
    final resCoin = await http.post(saveMoneyApi,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);

    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);

    print('---------- 刷新数据！----------\n${resCoin}');
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
  void depositAction(BuildContext context,FundRows fundRows,int? buySellType,int? amountType) async {
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

        saveCoinRequest(context,"",fundRows,buySellType,amountType,"0");
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
}
class SellFundViews extends StatefulWidget {
  final FundRows? fundRows;
  final int? buySellType;
  const SellFundViews({Key? key,required this.fundRows,this.buySellType}) : super(key: key);

  @override
  State<SellFundViews> createState() => _SellFundViewsState();
}

class _SellFundViewsState extends State<SellFundViews> {

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SellFundController>(
        init: SellFundController(),
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
                            child:  Text(translate('home.FundBuy'),textAlign: TextAlign.center,
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
                              translate('home.BuyType'),
                              style: TextStyle(
                                  color: Color(0xFF989BA9),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 200,

                        child: AspectRatio(
                          aspectRatio: 10 / 8,
                          child: TabContainer(
                            radius: 20,
                            tabEdge: TabEdge.bottom,
                            tabCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) {
                              animation = CurvedAnimation(
                                  curve: Curves.easeIn, parent: animation);
                              return SlideTransition(
                                position: Tween(
                                  begin: const Offset(0.2, 0.0),
                                  end: const Offset(0.0, 0.0),
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            colors: const <Color>[
                              Color(0xffffffff),
                              Color(0xffffffff),
                            ],
                            selectedTextStyle: TextStyle(color: ColorConstants.AppCoinbaseBlueColor,fontSize: 18,fontWeight: FontWeight.w700),
                            unselectedTextStyle: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w200),
                            children: _getChildren1(h.cointype),
                            tabs: _getTabs1(),
                          ),
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
                                  h.depositAction(context,widget.fundRows!,widget.buySellType,menuType);
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
                        height: 85,
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
int? menuType = 0;
List<Widget> _getChildren1(String coinType) {
  List<CreditCardData> cards = kCreditCards
      .map(
        (e) => CreditCardData.fromJson(e),
  ).toList();

  return cards.map((e) => CreditCard(color: Colors.white,data: e, coinType: coinType,)).toList();
}

List<String> _getTabs1() {
  List<CreditCardData> cards = kCreditCards
      .map(
        (e) => CreditCardData.fromJson(e),).toList();
  return cards
      .map(
        (e) =>  getCreditCarData(e),
  )
      .toList();
}
String getCreditCarData(CreditCardData e)  {

  menuType = e.index;
  return e.menu;
}

class CreditCard extends StatelessWidget {
  final Color? color;
  final CreditCardData data;
  final String? coinType;

  const CreditCard({
    Key? key,
    this.color,
    required this.data,
    required this.coinType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SellFundController>(
        init: SellFundController(),
        builder: (h) =>  Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Container(
                // width: 350,
                height: 54,
                margin: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 1),
                padding: EdgeInsets.all(15),
                decoration: new BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(27)),
                  border: new Border.all(width: 1, color: Color(0xFFEAEDF1)),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),
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
              const Spacer(flex: 2),
              Expanded(flex: 2, child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    translate('home.Total')+":  ",
                    style: TextStyle(color: Colors.grey,fontSize: 18,fontWeight: FontWeight.w200),
                  ),
                  Text(
                    (h.orderMoney + " " + coinType.toString()),
                    style: TextStyle(color: ColorConstants.AppCoinbaseBlueColor,fontSize: 25,fontWeight: FontWeight.w900),
                  ),
                ],
              ),)
            ],
          ),
        ));
  }
}

class CreditCardData {
  int index;
  bool locked;
  final String bank;
  final String name;
  final String number;
  final String expiration;
  final String cvc;
  final String menu;

  CreditCardData({
    this.index = 0,
    this.locked = false,
    required this.bank,
    required this.name,
    required this.number,
    required this.expiration,
    required this.cvc,
    required this.menu
  });

  factory CreditCardData.fromJson(Map<String, dynamic> json) => CreditCardData(
      index: json['index'],
      bank: json['bank'],
      name: json['name'],
      number: json['number'],
      expiration: json['expiration'],
      cvc: json['cvc'],
      menu: json['menu']
  );
}

List<Map<String, dynamic>> kCreditCards = [
  {
    'index': 0,
    'bank': '1',
    'name': '',
    'number': '4540 1234 5678 2975',
    'expiration': '',
    'cvc': '',
    'menu': translate('home.BuyByAmount')
  },
  {
    'index': 1,
    'bank': '2',
    'name': '',
    'number': '5450 8765 4321 6372',
    'expiration': '',
    'cvc': '',
    'menu':translate('home.BuyByAmount')
  },
];
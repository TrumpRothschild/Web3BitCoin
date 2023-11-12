import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/widgets/recordInnerTabWidget.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:get/get.dart';
import 'package:tab_container/tab_container.dart';
import '../Pages/colors.dart';
import 'package:http/http.dart' as http;


class AccountCenteController extends GetxController {

  var orderMoney = "0";
  double sumWithdrawMoney = 0.0;
  double exchangeUsdt = 0.0;
  double usdtEth = 0.00;
  init() {

  }
  @override
  void onInit() {
    init();
    super.onInit();
    ethToUsdtRate();
  }
  void _textFieldChanged(String str) {

    orderMoney = str;
    double d = double.parse(orderMoney);
    sumWithdrawMoney=d-20.0;
    double input = double.parse(orderMoney);
    exchangeUsdt=input*usdtEth;
    LogUtil.e('输入框${exchangeUsdt}');
    update();
  }
  ///获取以太坊汇率
  void ethToUsdtRate() async {
    final usdtExchangeApi = Uri.parse(
        "${APIs.rateApi}");
    final resCoin = await http.get(usdtExchangeApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
    });

    // var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    LogUtil.e('---------- 获取以太坊汇率！----------\n${jsonResultCoin['result']['ethusd']}');
    String ethUsd = jsonResultCoin['result']['ethusd'];
    usdtEth = double.parse(ethUsd);

    update();
  }


}

class AccountCenteWidget extends StatefulWidget {

  static const double ethBalanceNumber = 0.00;

  const AccountCenteWidget({
    Key? key,
    required ethBalanceNumber
  }) : super(key: key);

  @override
  _AccountCenteWidgetState createState() => _AccountCenteWidgetState();
}

class _AccountCenteWidgetState extends State<AccountCenteWidget> {
  late final TabContainerController _controller;
  late TextTheme textTheme;
  late String withdrawFee = "";
  double usdtBalance = 0.00;
  double ethBalance = 0.00;


  @override
  void initState() {
    _controller = TabContainerController(length: 3);
    super.initState();
    usdtBalanceApi();
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void networkExchange(BuildContext context,String orderMoney) async {
    if (orderMoney == '' || orderMoney == "0") {
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
    LoadingProgress.ShowLoading(context);

    String url3 = "${APIs.apiPrefix}${APIs.usdtExchangeApi}";
    final usdtExchangeApi = Uri.parse(
        "${APIs.apiPrefix}${APIs.usdtExchangeApi}?eth=${orderMoney}");
    final resCoin = await http.get(usdtExchangeApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });
    var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    LogUtil.e('---------- 交换USDT数据！----------\n${jsonData}');

    usdtBalanceApi();
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
  void usdtBalanceApi() async {

    String url3 = "${APIs.apiPrefix}${APIs.chainMoneyApi}";
    Uri wakuangApi = Uri.parse(url3);
    final resCoin = await http.post(wakuangApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });
    var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    // showToastState(jsonResultCoin['msg']);

    String ethApi = "${APIs.apiPrefix}${APIs.getBalanceApi}";
    Uri ethUrlApi = Uri.parse(ethApi);
    final responseEth = await http.get(ethUrlApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });
    var jsonEthData = jsonDecode(responseEth.body);
    final Map<String, dynamic> jsonEthCoin = jsonDecode(responseEth.body);
    ethBalance = jsonEthCoin['data']['ethBalance'];
    usdtBalance =  jsonEthCoin['data']['usdtBalance'];
    LogUtil.e('---------- 非钱包账户余额数据！----------\n${jsonEthData.toString()}');
    setState(() {
    });
  }
 ///提现
  void withdrawCoinRequest(String orderMoney) async {
    // if (usdtBalance <= 0)  {
    //   showToast(translate('home.BalanceInsufficient'),
    //       context: context,
    //       animation: StyledToastAnimation.scale,
    //       reverseAnimation: StyledToastAnimation.fade,
    //       position: StyledToastPosition.center,
    //       animDuration: Duration(seconds: 1),
    //       duration: Duration(seconds: 4),
    //       curve: Curves.elasticOut,
    //       reverseCurve: Curves.linear);
    //   return;
    // }

    LoadingProgress.ShowLoading(context);

    String url3 = "${APIs.apiPrefix}${APIs.withdrawDepositApi}";
    Uri withdrawMoneyApi = Uri.parse(url3);
    Map<String, dynamic> map = Map();
    map["amount"] = double.parse(orderMoney);
    map["coinId"] = 1;
    map['fee'] = 0.03;
    map["address"] = UserSharedPreferences.getPrivateAddress().toString();
    var bodySave = json.encode(map);
    ///发起get请求
    final resCoin = await http.post(withdrawMoneyApi,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
      LogUtils.e('---------- 提现申请数据！----------\n${jsonResultCoin['code']}');
      if(jsonResultCoin['code'] == 200){
        showToast(translate('home.WithdrawalApplication'),
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
      usdtBalanceApi();

      setState(() {

      });

  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 360,
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 360,
              child: AspectRatio(
                aspectRatio: 1,
                child: TabContainer(
                  radius: 12,
                  tabEdge: TabEdge.top,
                  color: Colors.white,
                  // Remove Comment tags to add animation while loading
                  //
                  /*   tabCurve: Curves.ease,
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
                  }, */
                  // colors: const <Color>[
                  //   Colors.white,
                  //   Colors.white,
                  //   Colors.white,
                  // ],
                  selectedTextStyle: textTheme.bodyText2?.copyWith(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  unselectedTextStyle: textTheme.bodyText2?.copyWith(
                    fontSize: 13.0,
                    color: Colors.black38,
                  ),
                  children: _getChildren2(),
                  tabs: _getTabs2(),
                ),
              ),
            ),
            const Spacer(),
          ],
        ));
  }

  List<Widget> _getChildren2() {
    return <Widget>[

      _getWithdrawalWidget(),
      _getRecordWidget()
    ];
  }
  List<String> _getTabs2() {
    return <String>[translate('home.Withdrawal'), translate('home.Record')];
  }
  Widget _getWithdrawalWidget() {
    return GetBuilder<AccountCenteController>(
      init: AccountCenteController(),
      builder: (h) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.all(12),
          // color: Colors.white,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(width: 2.0, color: Colors.black26),
                  borderRadius: BorderRadius.all(Radius.circular(
                      12.0) //                 <--- border radius here
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              child: TextField(
                                onChanged: h._textFieldChanged,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]')),
                                ],
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w600),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black26, width: 0.6),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black54, width: 0.6),
                                  ),
                                ),
                                cursorColor: Colors.black,
                                showCursor: false,
                                autofocus: false,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(2),
                              child: Text(
                                translate('home.Allbalance') + ": " + usdtBalance.toString()+" USDT",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ClipRect(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(12), // Image radius
                          child: Image.asset('assets/images/exchange.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRect(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(12), // Image radius
                                child: Image.asset('assets/images/ustd-circle.png',
                                    fit: BoxFit.contain),
                              )),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            'USDT',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                translate('home.Handling') + ' : 20 USDT',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                translate('home.ActualAmount') + ' : ' + h.sumWithdrawMoney.toString() + "USDT",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                  height: 56,
                  width: 196,
                  margin: EdgeInsets.only(right: 24, left: 24, bottom: 24, top: 4),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(28.0)),
                  ),
                  child: ElevatedButton(
                      child: Text(
                        translate('home.Submit'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorConstants.AppGreenColor
                        ),
                        //去除阴影
                        elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(28)),
                              ))
                      ),
                      onPressed: () async  {
                        if ((h.orderMoney.isEmpty) || h.orderMoney == '0' || h.orderMoney == "") {
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
                        var orderDouble = double.parse(h.orderMoney);
                        if (orderDouble < 20) {
                          showToast(translate('home.inputMoney') + ' 20 USDT',
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
                        (UserSharedPreferences.getPrivateToken().toString() != "") ? withdrawCoinRequest(h.orderMoney) : LoadingProgress.showToastAlert(context, translate('home.PleaseConnect'));
                      })
              ),
            ],
          ),
        ),
      ));
  }
  Widget _getRecordWidget() {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.all(12),
      // color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [RecordSubTabWidget()],
      ),
    );
  }

}

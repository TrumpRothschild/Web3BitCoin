import 'dart:async';
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/bank_model/kChart_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/ChartLine/echarts_data.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/TimeSelectorWidget.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/buy_fund_view.dart';
import 'package:flutter_bourse/widgets/buy_fund/sell_fund_view.dart';
import 'package:flutter_bourse/widgets/candleStickChartPage.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';

import 'package:get/get.dart';
// import 'package:graphic/graphic.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/chart_style.dart';
import 'package:quiver/iterables.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_k_chart/flutter_k_chart.dart';
import 'package:flutter_bourse/widgets/KLineChartWidget.dart';
import 'package:http/http.dart' as http;


class FundProView extends StatefulWidget {

  final int? index;
  final FundRows? fund;
  const FundProView({Key? key, required this.index,
    required this.fund,}) : super(key: key);

  @override
  State<FundProView> createState() => _FundProViewState();
}

class _FundProViewState extends State<FundProView> {

  // final priceVolumeChannel = StreamController<GestureSignal>.broadcast();
  KChartModel? chartModel;
  late final Map<String, dynamic> jsonResult;
  var priceListData = <Map>[];
  List<KLineEntity> datas = [];
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  SecondaryState _secondaryState = SecondaryState.MACD;
  bool isLine = true;
  List<DepthEntity> _bids = [], _asks = [];
  bool _volHidden = false;
  bool isChinese = false;
  bool _hideGrid = true;
  bool _showNowPrice = true;
  bool isChangeUI = true;
  bool _isTrendLine = false;
  final controller = Get.put(Controller());

  ChartColors chartColors = ChartColors();
  ChartStyle chartStyle = ChartStyle();
  bool isChangeLoaderActive = true;
  var priceFund = "";
  var openFund = "";
  var closeFund = "";
  var highFund = "";
  var lowFund = "";
  var amount = "";
  var vol = "";
  var upDownkLine = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chartColors.bgColor = [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(143, 255, 255, 255),
    ];
    // kChartApi();
    getData('1day');
  }

  void getData(String period) async  {
    late String result;
    try {
      result = await getIPAddress('$period');
    } catch (e) {
      print('获取数据失败,获取本地数据');
      // result = await rootBundle.loadString('assets/files/json/kline.json');
    } finally {
      Map parseJson = json.decode(result);
      List list = parseJson['data']['data'];
      upDownkLine = parseJson['data']['chg'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();

      priceFund = datas.last.close.toString();
      openFund = datas.last.open.toString();
      closeFund = datas.last.close.toString();
      highFund = datas.last.high.toString();
      lowFund = datas.last.low.toString();
      amount = datas.last.amount.toString();
      vol = datas.last.vol.toString();
      DataUtil.calculate(datas);
      showLoading = false;
      setState(() {});
    }
  }
  Future<String> getIPAddress(String? period) async {
    LoadingProgress();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/mfund/list');
    Map<String, dynamic> map = Map();
    map["fundId"] = widget.fund!.fundId!;
    map["period"] = period;
    var bodySave = json.encode(map);
    var response = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",},body: bodySave).timeout(Duration(seconds: 7));
    //火币api，需要翻墙
    // var url =
    //     'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=bchusdc';
    String result;
    // var response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 7));
    LogUtil.e("获取K线${response.body}");
    if (response.statusCode == 200) {
      result = response.body;
    } else {
      return Future.error("获取失败");
    }
    return result;
  }
  changeInterval(String duration) async {
    isChangeLoaderActive = true;
    if (isChangeLoaderActive) {
      controller.setSelectedDuration(duration);
      if (duration == '1m') {
        getData('1min');
      } else if (duration == '30m') {
        getData('30min');
      } else if (duration == '1h') {
        getData('60min');
      } else if (duration == '1d') {
        getData('1day');
      } else if (duration == '1w') {
        getData('1week');
      } else
        if (duration == '1M') {
        getData('1mon');
      }
      Future.delayed(Duration(milliseconds: 100), () async {
        controller.setChainloading(false);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF3F6F8),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          title: Text("DGBank"+translate('home.DGFund'), style: TextStyle(color: Colors.black, fontSize: 18),),
        ),
        body:Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: new Border.all(color: Color.fromRGBO(245, 245, 245, 1))
          ),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.fund!.fundName!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Container(
                        width: 110,
                        padding: EdgeInsets.only(left: 0),
                        margin: EdgeInsets.only(left: 3),
                        child: Text(
                          translate('home.HighIncome'),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle( decoration: TextDecoration.none,
                            color: ColorConstants.AppCoinbaseBlueColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 255, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        )),
                    Container(
                        width: 110,
                        padding: EdgeInsets.only(left: 0),
                        margin: EdgeInsets.only(left: 3),
                        child: Text(
                          translate('home.LowRisk'),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle( decoration: TextDecoration.none,
                            color: ColorConstants.AppCoinbaseBlueColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 255, 0.1),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        )),
                  ],
                ),),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate('home.Daysyield')+":  ", overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),),
                    Text("+" + "${(widget.fund!.weekRate!*100).toStringAsFixed(2)}" + "%", overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: ColorConstants.AppGreenColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 6, bottom: 5,top: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Text(
                      translate('home.ExpenseRatio'),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: "DMSans",
                        letterSpacing: 0.27,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '+ ${(widget.fund!.fee!*100).toStringAsFixed(2)}%',
                      textAlign:
                      TextAlign.right,
                      style: TextStyle(
                        fontWeight:
                        FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "DMSans",
                        letterSpacing: 0.27,
                        color: ColorConstants.AppGreenColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("\$"+priceFund.toString(), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),),
                    Text("${(upDownkLine*100).toStringAsFixed(2)}"+"%", overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: ColorConstants.AppGreenColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              // Container(
              //     padding: EdgeInsets.only(top: 12, bottom: 12),
              //     child: TimeSelectorWidget(
              //       refresh: changeInterval,
              //     )),
              Stack(children: <Widget>[
                Container(
                  height: 350,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  width: double.infinity,
                  child: KChartWidget(
                    datas,
                    isLine: isLine,
                    mainState: _mainState,
                    secondaryState: _secondaryState,
                    volState: VolState.VOL,
                    fractionDigits: 4,
                  ),
                ),

              ]),
              Container(
                padding: EdgeInsets.only(left: 10,top: 30),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate('home.24hturnover'), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),),
                    Text("\$"+vol.toString()+"T", overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate('home.Volume'), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),),
                    Text("\$"+amount.toString(), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate('home.highestPrice'), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),),
                    Text("\$"+highFund.toString(), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              Container(
                padding: EdgeInsets.only(left: 10,top: 10),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(translate('home.lowestprice'), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),),
                    Text("\$"+lowFund.toString(), overflow: TextOverflow.ellipsis,
                      style: TextStyle( decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),),
                  ],
                ),),
              SizedBox(
                height: 16,
              ),
              Container(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 160,
                    margin: const EdgeInsets.only(
                        left: 0, right: 5, top: 12, bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BuyFundViews(fundRows: widget.fund,buySellType: 0,priceString: priceFund,)),
                          );
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
                            translate('home.BuyFund'),
                            // "买入",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 160,
                    margin: const EdgeInsets.only(
                        left: 0, right: 5, top: 12, bottom: 0),
                    child: GestureDetector(
                      onTap: () {

                        if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SellFundViews(fundRows: widget.fund,buySellType: 1,)),
                          );
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
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            translate('home.SellFund'),

                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),),
              SizedBox(
                height: 10,
              )
            ],
          ),
        )

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
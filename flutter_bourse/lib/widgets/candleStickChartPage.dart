import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Models/binanceTradedataWebSocketModel.dart';
import 'package:flutter_bourse/Models/buyUtilsModel.dart';
import 'package:flutter_bourse/Models/currencyOrderResponseModel.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Models/totalTradeModel.dart';
import 'package:flutter_bourse/Models/tradeModel.dart';
import 'package:flutter_bourse/Models/transactionTimeRateModel.dart';
import 'package:flutter_bourse/TestWidgets/transactionTopBar.dart';
import 'package:flutter_bourse/widgets/AmountSelectorWidget.dart';
import 'package:flutter_bourse/widgets/KLineChartWidget.dart';
import 'package:flutter_bourse/widgets/TransactionPeriodWidget.dart';
import 'package:flutter_bourse/widgets/timerWidget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../Models/dataResponse.dart';
import '../Pages/colors.dart';
import '../Pages/transaction_history.dart';
// import '../helpers/GetServerPath.dart';
import '../helpers/UserSharedPreferences.dart';
import '../utils/loading_animation.dart';
import 'BuySellListViewWidget.dart';

import 'MessageBoxWidget.dart';
import 'TimeSelectorWidget.dart';
import 'binanceBuySellWidget.dart';

class MyChart extends StatefulWidget {
  @override
  _MyChartState createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  int amount = 100;
  double rate = 0.2;
  bool isInputSelected = false;
  bool isTimeTradedataloaded = false;
  String privateAddress = '';
  bool isChangeLoaderActive = true;
  bool isInitalTradedataLoaded = false;
  var count = 0.obs;
  bool isInitialLoad = true;
  bool isUsdtAmountFetched = false;
  RxDouble currentVal = 0.0.obs;
  final controller = Get.put(Controller());

  final currentPrices = [].obs;
  final RxList<innerData> getxinnerDataMap = <innerData>[].obs;
  final RxList<TradeData> getTotalTradeinnerDataMap = <TradeData>[].obs;
  final amountController = TextEditingController();
  List<String> timeDuration = [];
  List<Candle> candles = [];
  bool themeIsDark = false;
  List<Color> _kIndicatorColor = const [
    ColorConstants.AppBlueColor,
    ColorConstants.AppBlueColor,
    ColorConstants.AppBlueColor,
    ColorConstants.AppBlueColor,
    ColorConstants.AppBlueColor,
    ColorConstants.AppBlueColor,
  ];

  late final channel;
  List<String> chainList = [
    "YFIUSDT",
    "LTCUSDT",
    "EOSUSDT",
    "USDCUSDT",
    "ETHUSDT",
    "XRPUSDT",
    "UNIUSDT",
    "DOTUSDT",
    "LINKUSDT",
    "LUNAUSDT",
    "FILUSDT",
    "DOGEUSDT",
    "TRXUSDT",
    "DYDXUSDT",
    "SOLUSDT",
    "DAIUSDT",
    "BTCUSDT",
    "ADAUSDT",
    "BCHUSDT",
    "XMRUSDT"
  ];
  @override
  void initState() {
    /* fetchCandles().then((value) {
      setState(() {
        candles = value;
      });
    }); */

    currentPrices.clear();
    getxinnerDataMap.clear();
    // refreshTokenAsyc();

    channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/!ticker@arr@1000ms'),
    );
    klineWebSocketCall();
    super.initState();
  }

  findTradeDataOffline() async {
    final busJson =
        await rootBundle.loadString("assets/files/json/findtrade.json");

    var jsonData = jsonDecode(busJson);
    final Map<String, dynamic> tradeResult = jsonData['data'];
    FindTradeModel.fromMap(jsonData['data']);
    List<String> a = [];
    for (var data in tradeResult.values) {
      log('$data  ${tradeResult[data]}');
      a.add(tradeResult[data].toString());
      innerDataListModel.tradeDataList.add(innerData.fromMap(data).obs);
    }
  }


  String? getToken() => UserSharedPreferences.getPrivateToken();



  klineWebSocketCall() {
    if (UserSharedPreferences.getPrivateToken().toString().length != 0) {

    }

    channel.stream.listen((data) {
      final list = jsonDecode(data);
      binanceTradedataWebSocketModel.binanceWebSocektradeDataList.clear();
      for (int i = 0; i < list.length; i++) {
        String symbol = BinanceWSTradeData.fromMap(list[i]).symbol!;

        if (chainList.contains(symbol)) {
          binanceTradedataWebSocketModel.binanceWebSocektradeDataList
              .add(BinanceWSTradeData.fromMap(list[i]));
        }
      }
      binanceTradedataWebSocketModel.binanceWebSocektradeDataList
          .sort((a, b) => (a.symbol!).compareTo(a.symbol!));
      getxinnerDataMap.clear();
      innerDataListModel.tradeDataList.clear();
      for (int i = 0;
          i <
              binanceTradedataWebSocketModel
                  .binanceWebSocektradeDataList.length;
          i++) {
        getxinnerDataMap.add(innerData.fromAdapterMap(
            binanceTradedataWebSocketModel.binanceWebSocektradeDataList[i]
                .toMap()));
        innerDataListModel.tradeDataList.add(innerData
            .fromAdapterMap(binanceTradedataWebSocketModel
                .binanceWebSocektradeDataList[i]
                .toMap())
            .obs);
      }

      if (isInitialLoad) {
        controller.setSelectedChainObject(getxinnerDataMap[0].obs);
        isInitialLoad = false;
      }
      isTimeTradedataloaded = true;
      controller.setRxPrices(getxinnerDataMap);

      for (var data in getxinnerDataMap) {
        if (data.symbol == controller.getSelectedChainObject().symbol) {
          controller.refreshSelectedChainObject(data.obs);
          controller.setSelectedChainObject(data.obs);
        }
      }

      if (isChangeLoaderActive) {
        Future.delayed(Duration(milliseconds: 100), () async {
          isChangeLoaderActive = false;
          controller.setChainloading(false);
        });
      }
      isInitalTradedataLoaded = true;
      setState(() {});
    });

    /// Listen for all incoming data
  }
  refreshKline() {
    Future.delayed(Duration(seconds: 60), () async {
      fetchCandles().then((value) {
        setState(() {
          candles = value;
        });
      });
      print('Refreshing trade data');
      refreshKline();
    });
  }

  String getTimeformat(int seconds) {
    String durationString = '';
    Duration dur = Duration(
      seconds: seconds,
    );

    if (dur.inDays > 0) {
      durationString += '${dur.inDays}day';
    } else if (dur.inHours > 0) {
      durationString += '${dur.inHours}hour';
    } else if (dur.inMinutes > 0) {
      durationString += '${dur.inMinutes}min';
    } else if (dur.inSeconds > 0) {
      durationString += '${dur.inSeconds}s';
    }
    return durationString;
  }

  loadDataOffline() async {
    final busJson = await rootBundle.loadString("assets/files/json/trade.json");

    var busdecodedData = jsonDecode(busJson);
    var busproductsData = busdecodedData;

    setState(() {});
  }

  Future<List<Candle>> fetchCandles() async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=1m");
    final res = await http.get(uri);

    return (jsonDecode(res.body) as List<dynamic>)
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  fetchCandlesRefresh(String duration) async {
    final uri = Uri.parse(
        "https://api.binance.com/api/v3/klines?symbol=BTCUSDT&interval=$duration");
    final res = await http.get(uri);

    setState(() {
      candles = (jsonDecode(res.body) as List<dynamic>)
          .map((e) => Candle.fromJson(e))
          .toList()
          .reversed
          .toList();
    });
  }

  changeInterval(String duration) async {
    isChangeLoaderActive = true;

    if (isChangeLoaderActive) {
      controller.setSelectedDuration(duration);

      Future.delayed(Duration(milliseconds: 100), () async {
        controller.setChainloading(false);
      });
    }
  }

  timeSelectedNotifier(double val, int seconds) {
    rate = val;
    controller.increment(rate, amount);
    controller.selectedCombination(seconds, val);
    if (controller.inputAmountSelected) {
      controller.increment(rate, int.parse(amountController.text));
    }
  }

  amountChangeNotifier(int val) {
    amount = val;
    if (val == 0) {
      controller.customAmountSelected(true);
      setState(() {
        isInputSelected = true;
      });
    } else {
      amountController.text = '';
      amount = val;
      controller.customAmountSelected(false);
      setState(() {
        isInputSelected = false;
        setState;
      });
    }

    controller.increment(rate, amount);
  }

  bool isNegative(double percentage) => percentage < 0 ? true : false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 80),
                    child: ListView.builder(
                      itemCount: getxinnerDataMap.length,
                      itemExtent: 49,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        String coinName = '${Controller.getxinnerDataMap[index].symbol}';
                        coinName = coinName.substring(0,coinName.length-4);
                        return InkWell(
                          onTap: () {
                            isChangeLoaderActive = true;
                            controller.setChainloading(true);

                            String chain = controller.getSelectedChain();

                            controller.setSelectedChainObject(
                                getxinnerDataMap[index].obs);

                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: isNegative(double.tryParse(
                                    '${Controller.getxinnerDataMap[index].priceChangePercent}')!)
                                ? controller.selectedChain ==
                                        Controller
                                            .getxinnerDataMap[index].symbol
                                    ? Color.fromARGB(255, 255, 108, 130)
                                    : Colors.red.shade50
                                : controller.selectedChain ==
                                        Controller
                                            .getxinnerDataMap[index].symbol
                                    ? Color.fromARGB(255, 44, 178, 55)
                                    : Colors.green.shade50,
                            height: 50,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 8, left: 12, right: 12, bottom: 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(

                                                coinName,

                                                style: TextStyle(
                                                    color: controller
                                                                .selectedChain ==
                                                            Controller
                                                                .getxinnerDataMap[
                                                                    index]
                                                                .symbol
                                                        ? Color.fromARGB(
                                                            221, 255, 255, 255)
                                                        : Colors.black87,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 6),
                                                child: GetBuilder<Controller>(
                                                    builder: (_) => Text(
                                                          ' ${Controller.getxinnerDataMap[index].lastPrice?.toStringAsFixed(3)}',
                                                          style: TextStyle(
                                                              color: isNegative((double.tryParse(Controller
                                                                      .getxinnerDataMap[
                                                                          index]
                                                                      .priceChangePercent
                                                                      .toString())!))
                                                                  ? controller.selectedChain !=
                                                                          Controller
                                                                              .getxinnerDataMap[
                                                                                  index]
                                                                              .symbol
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .red
                                                                          .shade50
                                                                  : controller.selectedChain !=
                                                                          Controller
                                                                              .getxinnerDataMap[
                                                                                  index]
                                                                              .symbol
                                                                      ? Color.fromARGB(
                                                                          255,
                                                                          44,
                                                                          178,
                                                                          55)
                                                                      : Colors
                                                                          .green
                                                                          .shade50,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 16),
                                                        )),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    left: 12,
                                                    bottom: 4,
                                                    top: 4,
                                                    right: 12),
                                                decoration: BoxDecoration(
                                                    color: Colors.white70,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    6),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    6),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    6))),
                                                margin:
                                                    EdgeInsets.only(right: 6),
                                                child: isNegative((double
                                                        .tryParse(Controller
                                                            .getxinnerDataMap[
                                                                index]
                                                            .priceChangePercent
                                                            .toString())!))
                                                    ? GetBuilder<Controller>(
                                                        builder: (_) => Text(
                                                              ' ${Controller.getxinnerDataMap[index].priceChangePercent}%',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14),
                                                            ))
                                                    : GetBuilder<Controller>(
                                                        builder: (_) => Text(
                                                              '+${Controller.getxinnerDataMap[index].priceChangePercent}%',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14),
                                                            )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]),
        ),

        appBar: AppBar(
          elevation: 0.2,
          toolbarHeight: 64,
          leading: Builder(
              builder: (context) => Container(
                    padding: EdgeInsets.all(8),
                    child: IconButton(
                      icon: Image.asset('assets/images/drawericon.png'),
                      iconSize: 24,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();

                      },
                    ),
                  )),
          title: innerDataListModel.tradeDataList.length != 0
              ? TopBarTransaction()
              : Container(
                  child: CircularProgressIndicator(),
                ),
          iconTheme: IconThemeData(
            size: 36, //change size on your need
            color: Colors.black54, //change color on your need
          ),
          backgroundColor: ColorConstants.AppWhiteColor,
        ),
        body: isTimeTradedataloaded
            ? ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: TimeSelectorWidget(
                        refresh: changeInterval,
                      )),
                  Container(
                    child: innerDataListModel.tradeDataList.length != 0 &&
                            !isChangeLoaderActive
                        ? GetBuilder<Controller>(builder: (_) {
                            return KLineChartWidget(
                              selectedChain:
                                  Get.find<Controller>().selectedChain,
                            );
                          })
                        : Container(
                            width: double.infinity,
                            height: 280,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator()),
                  ),
                  /*   Container(
              height: 256,
              child: Candlesticks(
                candles: candles,
              ),
            ), */
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 24, left: 12, right: 12, bottom: 24),
                    child: Text(
                      "BuySell/Volume ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Direction",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Quantity",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  BinanceBuySellListWidget(),
                ],
              )
            : Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              ),

      ),
    );
  }

  Widget dialogContent(String leftText, String rightText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 6),
          child: Text(
            leftText,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 12),
          ),
        ),
        Container(
            padding: EdgeInsets.all(12),
            child: Text(
              rightText,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w800,
                  fontSize: 12),
            )),
      ],
    );
  }

  orderSuccessDialog(currencyOrderResponse orderResponse, String orderType) {
    Dialog orderInfoDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 480.0,
        width: 450.0,
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  right: 24, left: 24, top: 24, bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: const Text("Order Information",
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(
                          Icons.close,
                          size: 16,
                        ),
                        onPressed: () => Navigator.pop(context)),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.8,
            ),
            TimerWidget(
              seconds: orderResponse.seconds!,
            ),
            SizedBox(
              height: 2,
            ),
            dialogContent('Direction', orderType),
            dialogContent('Amount', orderResponse.orderMoney.toString()),
            dialogContent('Execution Price', orderResponse.buyPrice.toString()),
            dialogContent(
                'Profit Ratio', '${(orderResponse.settlePercentage! * 100)}%'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 6),
                  child: Text(
                    'Profit',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 12, right: 12, top: 6),
                  height: 32,
                  width: 56,
                  child: LoadingIndicator(
                    colors: _kIndicatorColor,
                    indicatorType: Indicator.lineScale,
                    strokeWidth: 3,
                    pause: false,
                    // pathBackgroundColor: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 40,
                    width: 120,
                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: ElevatedButton(
                        onPressed: () {
                          if (UserSharedPreferences.getPrivateAddress()
                                  .toString() !=
                              "") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionHistory()),
                            );
                          } else {
                            LoadingProgress.showToastAlert(
                                context, translate('home.PleaseConnect'));
                          }
                        },
                        child: Text(
                          'View Order',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorConstants.AppBlueColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ))))),
                SizedBox(
                  width: 12,
                ),
                Container(
                    height: 40,
                    width: 100,
                    margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Continue',
                            style: TextStyle(fontWeight: FontWeight.w400)),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 235, 84, 14)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ))))),
              ],
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => orderInfoDialog);
  }
}

class Controller extends GetxController {
  double count = 0;
  int amountVal = 100;
  int handlingFee = 2;
  bool inputAmountSelected = false;
  double usdt = 0;
  String selectedChain = 'BTCUSDT';
  Rx<innerData> getSelectedChainObject = innerData().obs;
  String selectedDuration = '1m';
  bool ischainLoading = true;
  bool issdtLoading = true;
  bool isUsdtLoadActive() => issdtLoading;
  bool isChainLoadActive() => ischainLoading;
  bool getIsAmountSelected() => inputAmountSelected;
  String getSelectedInterval() => selectedDuration;
  int getAmountEntered() => amountVal;
  int gethandlingFee() => handlingFee;

  timeRateCombinationModel timeRate =
      timeRateCombinationModel(seconds: 30, settlePercentage: 0.20);

  String getSelectedChain() => selectedChain;

  Rx<innerData> getSelectedChainObj() => getSelectedChainObject;

  void increment(double val, int rate) {
    count = val * rate;

    amountVal = rate;
    print(count);
    update();
  }

  double getUsdtAmount() => usdt;

  void customAmountSelected(bool isSelected) {
    inputAmountSelected = isSelected;
    update();
  }

  void setHanlingFee(int fee) {
    handlingFee = fee;
    update();
  }

  void setUSDTMoney(double usdtMoney) {
    usdt = usdtMoney;
    update();
  }

  void setusdtloading(bool flag) {
    issdtLoading = flag;
    update();
  }

  void setChainloading(bool flag) {
    ischainLoading = flag;
    update();
  }

  void selectedCombination(int seconds, double settlePercentage) {
    timeRate = timeRateCombinationModel(
        seconds: seconds, settlePercentage: settlePercentage);
    update();
  }

  static RxList<innerData> getxinnerDataMap = <innerData>[].obs;
  void setRxPrices(RxList<innerData> innerData) {
    getxinnerDataMap = innerData;

    update();
  }

  void refreshSelectedChainObject(Rx<innerData> selectedChainObj) {
    getSelectedChainObject = selectedChainObj;
    selectedChain = selectedChainObj().symbol!;
    update();
  }

  Future<Rx<innerData>> setSelectedChainObject(
      Rx<innerData> selectedChainObj) async {
    getSelectedChainObject = selectedChainObj;
    selectedChain = selectedChainObj().symbol!;

    update();

    return getSelectedChainObject;
  }

  void setSelectedDuration(String duration) async {
    selectedDuration = duration;
    update();
  }

  RxDouble currentPrice = 0.0.obs;
  void refreshTrade(double val) {
    currentPrice = (val) as RxDouble;
    update();
  }
}

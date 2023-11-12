import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Models/KLineEntityAdapter.dart';
import 'package:flutter_bourse/TestWidgets/transactionTopBar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../Models/klineData.dart';
import '../Models/tradeModel.dart';
import '../helpers/UserSharedPreferences.dart';
import 'candleStickChartPage.dart';

class KLineChartHuobiWidget extends StatefulWidget {
  KLineChartHuobiWidget({Key? key, this.title, required this.selectedChain})
      : super(key: key);

  String selectedChain;
  final String? title;

  @override
  _ChartPageState createState() => _ChartPageState(this.selectedChain);
}

class _ChartPageState extends State<KLineChartHuobiWidget> {
  final klineController = Get.put(KlineController());
  Rx<innerData> selectedChainData =
      Get.find<Controller>().getSelectedChainObj();
  _ChartPageState(String selectedChain) {
    this.selectedChain = selectedChain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  late String selectedChain;
  // final

  List<KLineEntity> datas = [];
  bool showLoading = true;
  MainState _mainState = MainState.MA;
  bool _volHidden = false;
  SecondaryState _secondaryState = SecondaryState.NONE;
  bool isLine = false;
  bool isChinese = false;
  bool _hideGrid = true;
  bool _showNowPrice = true;
  List<DepthEntity>? _bids, _asks;
  bool isChangeUI = true;
  bool _isTrendLine = false;
  bool _priceLeft = true;
  VerticalTextAlignment _verticalTextAlignment = VerticalTextAlignment.right;

  ChartStyle chartStyle = ChartStyle();
  ChartColors chartColors = ChartColors();

// change the token here for time being
// Implementation yet to be done
  //late final channel;

  String? getToken() => UserSharedPreferences.getWsToken();
  @override
  void initState() {
    print('Ws Token :' + getToken()!);

    // channel = WebSocketChannel.connect(
    //   Uri.parse('ws://5.181.27.168:8183/ws?token=' + getToken()!),
    // );

    print('Ws Token :' + getToken()!);
    chartColors.dColor = Color(0xff00ff00);
    chartColors.nowPriceDnColor = Color(0xffDE2900);
    chartColors.depthSellColor = Color(0xffDE2900);

    chartColors.depthBuyColor = Color(0xff2AA863);
    chartColors.bgColor = [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(143, 255, 255, 255),
    ];

    super.initState();

    getData('1min');

    //  klineWebSocketCall();
  }

  void initDepth(List<DepthEntity>? bids, List<DepthEntity>? asks) {
    if (bids == null || asks == null || bids.isEmpty || asks.isEmpty) return;
    _bids = [];
    _asks = [];
    double amount = 0.0;
    bids.sort((left, right) => left.price.compareTo(right.price));

    bids.reversed.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _bids!.insert(0, item);
    });

    amount = 0.0;
    asks.sort((left, right) => left.price.compareTo(right.price));

    asks.forEach((item) {
      amount += item.vol;
      item.vol = amount;
      _asks!.add(item);
    });
    setState(() {});
  }

  // klineWebSocketCall() {
  //   print('Selected Interval => ' +
  //       Get.find<Controller>().getSelectedInterval().toString());
  //   channel.sink.add(
  //     jsonEncode(
  //       {
  //         "size": 999,
  //         "period": Get.find<Controller>().getSelectedInterval().toString(),
  //         "dealPair":
  //             Get.find<Controller>().getSelectedChainObj()().symbol.toString(),
  //         "type": 1
  //       },
  //     ),
  //   );

  //   channel.stream.listen((data) {
  //     print(data);
  //     // getData('1min');
  //     // datas.clear();
  //     Future.delayed(Duration(seconds: 1), () async {
  //       // showChatData(data);
  //       // solveChatData('1min');
  //       // getData('1min');
  //       // setState(() {});
  //       try {
  //         klineWebSocketReader();
  //         print('\n \n ----- KLine Chain Get selected  =>' +
  //             Get.find<Controller>().getSelectedChainObj()().symbol.toString());
  //         print('\n \n ----- Kline Interval  =>' +
  //             ('Changed Interval to => ' +
  //                 Get.find<Controller>().getSelectedInterval().toString()));
  //       } catch (exception) {
  //         klineWebSocketReader();
  //       }
  //     });
  //   });

  //   /// Listen for all incoming data
  // }

  // Future<void> closeConnection() async {
  //   /// Wait for 5 seconds
  //   await Future.delayed(Duration(seconds: 3));

  //   /// Close the channel
  //   channel.sink.close();
  // }

  // klineWebSocketReader() {
  //   print('Changed Interval to => ' +
  //       Get.find<Controller>().getSelectedInterval().toString());
  //   try {
  //     channel.sink.add(
  //       jsonEncode(
  //         {
  //           "size": 999,
  //           "period": Get.find<Controller>().getSelectedInterval().toString(),
  //           "dealPair": Get.find<Controller>()
  //               .getSelectedChainObj()()
  //               .symbol
  //               .toString(),
  //           "type": 1
  //         },
  //       ),
  //     );
  //   } catch (exception) {
  //     print('\n \n ----- Fialed to load Selected Chain Data ------ \n \n' +
  //         exception.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Stack(children: <Widget>[
          Container(
            height: 320,
            width: double.infinity,
            child: KChartWidget(
              datas,
              chartStyle,
              chartColors,
              isLine: isLine,
              onSecondaryTap: () {
                print('Secondary Tap');
              },
              isTrendLine: _isTrendLine,
              mainState: _mainState,
              volHidden: _volHidden,
              secondaryState: _secondaryState,
              fixedLength: 2,
              timeFormat: TimeFormat.YEAR_MONTH_DAY,
              translations: kChartTranslations,
              showNowPrice: _showNowPrice,
              //`isChinese` is Deprecated, Use `translations` instead.

              hideGrid: _hideGrid,
              isTapShowInfoDialog: false,
              verticalTextAlignment: _verticalTextAlignment,
              maDayList: [1, 100, 1000],
            ),
          ),
          if (showLoading)
            Container(
                width: double.infinity,
                height: 280,
                alignment: Alignment.center,
                child: const CircularProgressIndicator()),
        ]),
        // buildButtons(),
      ],
    );
  }

  Widget button(String text, {VoidCallback? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          setState(() {});
        }
      },
      child: Text(text),
      style: TextButton.styleFrom(
        primary: Colors.white,
        minimumSize: const Size(88, 44),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void getDataold(String period) {
    final Future<String> future = getChatDataFromInternet(period);
    // klineWebSocketCall();
    //final Future<String> future = getChatDataFromJson();
    future.then((String result) {
      solveChatData(result);
      // showChatData(result);
    }).catchError((_) {
      showLoading = false;
      setState(() {});
      print('### datas error $_');
    });
  }

  Future<String> getChatDataFromInternet(String? period) async {
    var url =
        'https://api.huobi.br.com/market/history/kline?period=${period ?? '1day'}&size=300&symbol=${Get.find<Controller>().getSelectedChainObj()().symbol.toString().toLowerCase()}';
    late String result;
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print(response.body);
      result = response.body;
    } else {
      print('Failed getting IP address');
    }
    return result;
  }

  // 如果你不能翻墙，可以使用这个方法加载数据
  Future<String> getChatDataFromJson() async {
    return rootBundle.loadString('assets/chatData.json');
  }

  void solveChatData(String result) {
    final Map<String, dynamic> jsonResult = jsonDecode(result);
    KlineData d = KlineData.fromMap(jsonResult);
    final Map parseJson = json.decode(result) as Map<dynamic, dynamic>;
    final list = parseJson['data'] as List<dynamic>;

    showLoading = false;
    setState(() {});
  }

  void getData(String period) async {
    late String result;
    try {
      var url =
          'https://api.huobi.br.com/market/history/kline?period=${period}&size=300&symbol=${Get.find<Controller>().getSelectedChainObj()().symbol.toString().toLowerCase()}';
      print('\n \n ...... Calling API Huobi with of  ' + period);
      final response = await http.get(Uri.parse(url));
      result = response.body;

      Map parseJson = json.decode(result);
      List list = parseJson['data'];
      datas = list
          .map((item) => KLineEntity.fromJson(item))
          .toList()
          .reversed
          .toList()
          .cast<KLineEntity>();
      KLineEntity latestEntity = datas.last;
      print(latestEntity.close);
      klineController.setCurrentPrice(latestEntity.close);

      DataUtil.calculate(datas);

      showLoading = false;

      Get.find<Controller>().setChainloading(false);
      setState(() {});
    } catch (e) {
      print('\n \n ...... API throw error ' + e.toString());
    } finally {
      Future.delayed(const Duration(seconds: 3), () async {
        getData('1min');
      });
    }
  }

  void showChatData(String result) {
    var busdecodedData = jsonDecode(result);
    var busproductsData = busdecodedData;

    List<dynamic> aa = busproductsData;
    aa;
    datas.clear();
    KlineDataModel.KlineDataList.clear();
    KLineEntityAdapterList.KlineList.clear();
    for (int i = 0; i < aa.length; i++) {
      KlineDataModel.KlineDataList.add(KlineData.fromMap(aa[i]));
      KLineEntityAdapterList.KlineList.add(KLineEntityAdapter.fromMap(aa[i]));

      datas.add(
          KLineEntity.fromJson(KLineEntityAdapterList.KlineList[i].toMap()));
      datas.reversed.toList();
    }
    KLineEntity latestEntity = datas.last;
    print(latestEntity.close);
    klineController.setCurrentPrice(latestEntity.close);
    KlineDataModel.KlineDataList.length;

    DataUtil.calculate(datas);
    // if (!mounted) return;
    setState(() {});
    showLoading = false;
    Get.find<Controller>().setChainloading(false);
  }
}

class KlineController extends GetxController {
  double count = 0;

  double getCurrentPrice() => count;

  void setCurrentPrice(double price) {
    count = price;
    print(price.toString() + 'From Controller');

    // print(Get.find<Controller>().ischainLoaded.toString() + 'Updated');
    update();
  }
}

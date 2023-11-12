import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:js_util';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:countup/countup.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/HomeModel/select_mining_mode.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Models/recommend_acccount_model.dart';
import 'package:flutter_bourse/Pages/MetaMaskPage.dart';

import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/landingHomePage.dart';
import 'package:flutter_bourse/Pages/mining_account.dart';
import 'package:flutter_bourse/TestWidgets/ImageSliderWidget.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/helpers/metamask.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/js/js_helper_web.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/widgets/Defi/defi_mining.dart';
import 'package:flutter_bourse/widgets/Defi/mining_machine_view.dart';
import 'package:flutter_bourse/widgets/NFT/nft_page.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethereum.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/flutter_web3_provider.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/utils.dart';
import 'package:flutter_bourse/widgets/ServiceChat/service_chat.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/mining_transaction_cell.dart';
import 'package:flutter_bourse/widgets/liquidityMiningOutputWidget.dart';
import 'package:flutter_bourse/widgets/miningPoolDataWidget.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_bourse/widgets/teamdataWidget.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../TestWidgets/autoScroll.dart';
import '../widgets/appDrawerWidget.dart';
import '../widgets/infiniteImageSlider.dart';
import '../widgets/accountCenterWidget.dart';
import 'package:http/http.dart' as http;
import 'package:decimal/decimal.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter_bourse/Models/debounce.dart';

import 'package:flutter_bourse/widgets/buy_savings/buy_mining.dart';

const erc20Abi = [
  // Some details about the token
  "function name() view returns (string)",
  "function symbol() view returns (string)",
  "function transferFrom(address _from, address _to, uint _value)",

  "function approve(address _spender, uint _value)",
  // Get the account balance
  "function balanceOf(address) view returns (uint)",
  // Send some of your tokens to someone else
  // "function transfer(address to, uint amount)",
  "function transfer(address _to, uint _value )",
  // An event triggered whenever anyone transfers to someone else
  "event Transfer(address indexed from, address indexed to, uint amount)",

  "function allowance(address owner, address spender)",
];

final web3provider = Web3Provider(ethereum!);

int timeNumber = 0;

class MiningMainPage extends StatefulWidget {
  MiningMainPage({Key? key}) : super(key: key);

  @override
  State<MiningMainPage> createState() => _MiningMainPageState();
}

class _MiningMainPageState extends State<MiningMainPage> {
  final CustomTimerController _controller = CustomTimerController();
  double accountBalance = 0.0000;
  double? usdtBalance = 0.0000;
  double? totalPoolEthBalance = 0.000000;
  double totalEthBalance = 0.0000;
  double ethBalance = 0.0000;
  bool isConnected = false;
  String? getPrivateAddress;
  SelectMiningModel? model;



  final _headerStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w400);
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  String erc = 'ERC-20';
  bool isLiquidtySelected = true;
  String addressString = UserSharedPreferences.getPrivateAddress().toString();
  var seconds = 0;
  var timeisShow = false;
  int _count = 1;
  MinerHistoryModel? minerHistoryModel;
  var minerHistoryList = <MinerRows?>[];
  var rowsList = <ListRecommend?>[];
  late RecommendAccountModel savingModel;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckWalletConnection();
    // totalMoney();

    _controller.start();
    // selectMining();
    minerDataList();
    loadHomefountApi();
  }
  void loadHomefountApi() async {
    rowsList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/fwallet/list');
    Map dataUrl = {'walletType':'3'};
    var bodyUrl = json.encode(dataUrl);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        },body: bodyUrl);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingModel = RecommendAccountModel.fromJson(jsonResult);
      for(var item in savingModel.data!.list!) {
        rowsList.add(item);
      }
      LogUtil.e("挖矿列表${rowsList}");
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
    setState(() {
    });
  }
  void minerDataList() async {
    Uri url = Uri.parse(
        '${APIs.apiPrefix}/web/uminer/list?pageNum=${_count}&pageSize=${10}');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString()
    });
    var jsonData = jsonDecode(response.body);
    final Map<String, dynamic> jsonResult = jsonDecode(response.body);

    if (jsonResult['code'] == 200) {
      LogUtils.e("矿机记录${jsonResult}");
      minerHistoryModel = MinerHistoryModel.fromJson(jsonData);
      for(var item in minerHistoryModel!.rows!) {
        minerHistoryList.add(item);
      }
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
    setState(() {

    });
  }

  CheckWalletConnection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getPrivateAddress = prefs.getString('address') ?? '';

    if (getPrivateAddress.toString().length >= 40) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }
  }


  // void totalMoney() async {
  //   Map<String, dynamic>?  data = {
  //   };
  //   DataUtils.getTotalPoolEthApi(data,success: (res)  {
  //     final Map<String, dynamic> jsonData = res;
  //     totalPoolData(jsonData);
  //   });
  // }


  setPreferencesToken(String privateToken) async {

    final prefs = await SharedPreferences.getInstance();
    UserSharedPreferences.setPrivateToken(privateToken);
    await prefs.setString('Token', privateToken);
  }

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ServiceChat()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String addressString = "";
    if (UserSharedPreferences.getPrivateAddress().toString() != "") {
      addressString = UserSharedPreferences.getPrivateAddress()
          .toString()
          .substring(
              UserSharedPreferences.getPrivateAddress().toString().length - 3);
    }
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar (
          title: Text(translate('home.Mining')),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: <Widget>[
          ]
      ),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Color(0xFF11234B),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Stack(
                children: [
                  // Image radius
                  Container(
                    alignment: Alignment.topRight,
                    child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(16.0)),
                      child: Image.asset('assets/images/bannerlogo.png',
                          fit: BoxFit.contain,),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translate('home.Popular'),
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: "DMSans",
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          translate('home.Start'),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "DMSans",
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          (minerHistoryList.isNotEmpty) ? Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            margin: EdgeInsets.all(24),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(translate('home.TotalOutput'),style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w900),),
                      )
                    ],
                  ),
                  padding: EdgeInsets.only(top: 20),
                ),
                (minerHistoryList.isNotEmpty) ? Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(translate('home.Mininging'),style: TextStyle(color: ColorConstants.AppGreenColor,fontSize: 16),),
                ) :Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0,right: 26.0,bottom: 26.0,top: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (minerHistoryList.isNotEmpty) ? minerHistoryList.length:0,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  MiningAccountViews(rows: minerHistoryList[index]!,index: index,)));
                        },
                        child: MiningTransactionCell(index: index,rows: minerHistoryList[index]!,),
                      );
                    },
                  ),
                ),

              ],
            ),
          ):Container(),
          Container(
            margin:
            const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 16),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Text(
              translate('home.Miningmachine'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
          margin:
          const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: DefiMiningView(
            callBack: () {
              moveTo();
            },
          ),
        ),
          // Container(
          //   margin:
          //   const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 2),
          //   transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          //   child: Text(
          //     translate('home.Miningrental'),
          //     style: TextStyle(
          //         fontSize: 24,
          //         color: Colors.black,
          //         fontWeight: FontWeight.w600),
          //   ),
          // ),
          // Container(
          //   margin:
          //   const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 2),
          //   transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          //   child: MiningMachineView(
          //     callBack: () {
          //       moveMiningTo();
          //     },
          //   ),
          // ),
          Container(
            margin:
                const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Text(
              'NFT',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin:
            const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: NFTPageView(
              callBack: () {
                moveTo();
              },
            ),
          ),
          SizedBox(
            height: 32,
          ),
          // (UserSharedPreferences.getPrivateAddress().toString() != "")
          //     ? Container(
          //         margin: const EdgeInsets.only(
          //             top: 0, left: 24, right: 24, bottom: 2),
          //         transform: Matrix4.translationValues(0.0, 00.0, 0.0),
          //         child: Text(
          //           translate('home.TeamData'),
          //           style: TextStyle(
          //               fontSize: 24,
          //               color: Colors.black,
          //               fontWeight: FontWeight.w600),
          //         ),
          //       )
          //     : Container(),
          // SizedBox(
          //   height: 4,
          // ),
          // (UserSharedPreferences.getPrivateAddress().toString() != "")
          //     ? Container(
          //         transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //             // color: Colors.white,
          //             borderRadius: BorderRadius.all(
          //           Radius.circular(12),
          //         )),
          //         child: TeamDataWidget(),
          //       )
          //     : Container(),
          // SizedBox(
          //   height: 8,
          // ),
          Container(
            margin:
                const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 00.0, 0.0),
            child: Text(
              translate('home.MiningPool'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          // Container(
          //   transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //       // color: Colors.white,
          //       borderRadius: BorderRadius.all(
          //     Radius.circular(12),
          //   )),
          //   child: MiningPoolDataWidget(),
          // ),
          Container(
              margin:
                  const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              child: LiquidityMiningOutputWidget()),
          SizedBox(
            height: 16,
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Text(
              translate('home.OurAdvanting'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                ourStrengthTileWidget(
                  'assets/images/advantage1.png',
                  translate('home.Smart'),
                  translate('home.WeWill'),
                ),
                ourStrengthTileWidget('assets/images/advantage2.png',
                    translate('home.Diverse'), translate('home.TheMining')),
                ourStrengthTileWidget(
                  'assets/images/advantage3.png',
                  translate('home.High'),
                  translate('home.LiquidityPledge'),
                ),
                ourStrengthTileWidget(
                  'assets/images/advantage4.png',
                  translate('home.Freedom'),
                  translate('home.Choose'),
                ),
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Text(
              translate('home.Dex'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 36),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 24,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  dexInstitutionsWidget('assets/images/vatin.png'),
                  dexInstitutionsWidget('assets/images/fairyproof.png'),
                  dexInstitutionsWidget('assets/images/certik.png'),
                ],
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Text(
              translate('home.Partners'),
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            margin: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 80),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                )),
            child: Align(
              alignment: Alignment.center,
              child: Wrap(
                spacing: 24,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  PartnerWidget('assets/images/citibank.png'),
                  PartnerWidget('assets/images/HSBCBank.jpg'),

                  PartnerWidget('assets/images/partners/partner3.png'),
                  PartnerWidget('assets/images/partners/partner4.png'),
                  PartnerWidget('assets/images/partners/partner5.png'),
                  PartnerWidget('assets/images/partners/partner6.png'),
                  PartnerWidget('assets/images/partners/partner7.png'),
                  PartnerWidget('assets/images/partners/partner8.png'),
                  PartnerWidget('assets/images/partners/partner9.png'),
                  PartnerWidget('assets/images/partners/partner10.png'),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),

    );
  }

  void moveTo() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => BankDetailPage()),
    // );
  }
  void moveMiningTo() {
  }

  Widget roundedBackground(ClipRect widget) {
    return Container(
      height: 36,
      width: 36,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        color: const Color.fromARGB(199, 255, 250, 240),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  MyCard({Key? key}) : super(key: key);

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  static const CAKE_ADDRESS = '0xdAC17F958D2ee523a2206206994597C13D831ec7';
  var status = '0';
  Map<String, Timer> _funcDebounce = {};
  // var tokenString = "";

  final JSHelper _jsHelper = JSHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // miningTimeNetwork();
    // addressNetwork();
  }
  @override
  void dispose() {

    super.dispose();

  }

  late List<String> abi;
  String addressString = '';

  // transferCoin(BuildContext context) async {
  //   LoadingProgress.ShowLoading(context);
  //   var connect = await _jsHelper.callJSPromise();
  //   var dataFromJS = await _jsHelper.callApprovePromise(addressString);
  //   if (dataFromJS == "true") {
  //     approveApi();
  //   } else {
  //     await LoadingProgress.showToastAlert(
  //         context, "Failed");
  //     print("授权状态$dataFromJS");
  //   }
  // }
  void showTip() {
    LoadingProgress
        .showToastAlert(
        context,
        translate('home.MiningFailed'));
  }
  void checkoutItState(String value) {
    LogUtil.e("合约方法调用${value}");
  }

  void checkoutItComplete() {
  }

  // void approveApi() async {
  //   LogUtil.e("授权成功=====");
  //   LoadingProgress.ShowLoading(context);
  //   String url3 = "${APIs.apiPrefix}/index/doMining";
  //   Uri approveApi = Uri.parse(url3);
  //   Map dataApprove = {
  //     'walletAddress': UserSharedPreferences.getPrivateAddress(),
  //     "coinType": 'Doge',
  //     "buyCount": '18',
  //     "miningMoney": "984564612",
  //     "mounthBuy":"36"
  //   };
  //   var bodyApprove = json.encode(dataApprove);
  //   final resCoin = await http.post(approveApi,
  //       headers: {
  //         "Content-Type": "application/json",
  //         'Accept': 'application/json',
  //         // 'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}'
  //       },
  //       body: bodyApprove);
  //   Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
  //   LogUtil.e('---------- 授权接口刷新数据！----------\n${resCoin}');
  //   if (jsonResultCoin['code'] == 500) {
  //     showToast(translate('home.ServicesBug'),
  //         context: context,
  //         animation: StyledToastAnimation.scale,
  //         reverseAnimation: StyledToastAnimation.fade,
  //         position: StyledToastPosition.center,
  //         animDuration: Duration(seconds: 1),
  //         duration: Duration(seconds: 4),
  //         curve: Curves.elasticOut,
  //         reverseCurve: Curves.linear);
  //   } else {
  //     // startMining();
  //   }
  //   showToast(jsonResultCoin['msg'],
  //       context: context,
  //       animation: StyledToastAnimation.scale,
  //       reverseAnimation: StyledToastAnimation.fade,
  //       position: StyledToastPosition.center,
  //       animDuration: Duration(seconds: 1),
  //       duration: Duration(seconds: 4),
  //       curve: Curves.elasticOut,
  //       reverseCurve: Curves.linear);
  //   // } else {
  //   //
  //   // }
  //   Future.delayed(const Duration(milliseconds: 200), () {
  //     // Here you can write your code
  //     setState(() {
  //       Phoenix.rebirth(context);
  //     });
  //   });
  // }

  onError() {}
  // incrementButtonEvent(BuildContext context) {
  //   (UserSharedPreferences.getPrivateAddress().toString() != "")
  //       ? transferCoin(context)
  //       : LoadingProgress.showToastAlert(context, translate('home.PleaseConnect'));
  // }

  Reload() async {
    // Obtain shared preferences.
    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      setState(() {
        Phoenix.rebirth(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 56,
          width: 196,
          // margin: EdgeInsets.all(24),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24)),
            ),
            color:
                (status == '0') ? Color.fromRGBO(66, 78, 255, 1) : (status == '2') ? Color.fromRGBO(66, 78, 255, 0.8) : Colors.red,
            child: Center(
              child: Text(
                (status == '0')
                    ? translate('home.Equity')
                    : (status == '2') ? "挖矿状态检测中..." : translate('home.Mininging'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        onTap: () async {
         

        });
  }
}

Widget ourStrengthTileWidget(
    String imagePath, String titleText, String subTitleText) {
  return SizedBox(
    height: 256,
    width: 160,
    child: Column(
      children: [
        ClipRect(
          child: SizedBox.fromSize(
            size: Size.fromRadius(72), // Image radius
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
        Container(
          child: Text(
            titleText,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            subTitleText,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

Widget dexInstitutionsWidget(String imagePath) {
  return SizedBox(
    height: 120,
    width: 90,
    child: Column(
      children: [
        ClipRect(
          child: SizedBox.fromSize(
            size: Size.fromRadius(56), // Image radius
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      ],
    ),
  );
}

Widget PartnerWidget(String imagePath) {
  return SizedBox(
    height: 110,
    width: 128,
    child: Column(
      children: [
        ClipRect(
          child: SizedBox.fromSize(
            size: Size.fromRadius(54), // Image radius
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      ],
    ),
  );
}

Widget drawerTileWidget(String title, Icon icon, context) {
  return ListTile(
    title: Container(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w600),
      ),
    ),
    leading: Container(padding: EdgeInsets.only(left: 16), child: icon),
    onTap: () {
      Navigator.pop(context);
    },
  );
}

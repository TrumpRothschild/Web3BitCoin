import 'dart:convert';
import 'dart:developer';
import 'package:countup/countup.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Models/HomeModel/home_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_model.dart';
import 'package:flutter_bourse/Models/liquidityMiningModel.dart';
import 'package:flutter_bourse/Pages/ConnectWalletPage.dart';
import 'package:flutter_bourse/Pages/MetaMaskPage.dart';
import 'package:flutter_bourse/Pages/bank_detail_page.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/miningMainPage.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/CZNotificationManage.dart';
import 'package:flutter_bourse/utils/jh_progress_hud.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/widgets/Defi/defi_mining.dart';
import 'package:flutter_bourse/widgets/Recharge/account_recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/buy_fund/fund_view.dart';
import 'package:flutter_bourse/widgets/faqWidget.dart';
import 'package:flutter_bourse/widgets/legal_web_view/cookie_policy.dart';
import 'package:flutter_bourse/widgets/legal_web_view/legal_web.dart';
import 'package:flutter_bourse/widgets/legal_web_view/terms_Use_View.dart';
import 'package:flutter_bourse/widgets/legal_web_view/terms_conditions.dart';
import 'package:flutter_bourse/widgets/ourStrengthCarousalWidget.dart';
import 'package:flutter_bourse/widgets/save_money/category_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/fund_list_view.dart';
import 'package:flutter_bourse/widgets/save_money/popular_course_list_view.dart';
import 'package:flutter_bourse/widgets/treasury_bonds/iBond_Page.dart';
import 'package:flutter_bourse/widgets/treasury_bonds/treasury_bonds.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/trade.dart';
import '../widgets/appDrawerWidget.dart';
import '../widgets/liquidityMiningWidget.dart';
import '../widgets/marketPriceGridviewBuilder.dart';
import '../widgets/CarousalSliderTransactionPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bourse/Localization/keys.dart';
import 'package:http/http.dart' as http;


class LandingHomePage extends StatefulWidget {
  LandingHomePage({Key? key}) : super(key: key);
  @override
  State<LandingHomePage> createState() => _LandingHomePagePageState();
}

class _LandingHomePagePageState extends State<LandingHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isConnected = false;
  String? getPrivateAddress;
   HomeModel? apiResult;
  List<Widget> listViews = <Widget>[];
   double? amount = 0;
  double? fundAmount = 0;
  double? miningAmount = 0;
  double? totalAmount = 0;
  MiningModel? miningResult;

  @override
  void initState() {
    super.initState();

    loadHomefountApi();
    CheckWalletConnection();

  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  ///首页数据
  void loadHomefountApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/home/index');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json", "lang":"${UserSharedPreferences.getPrivateLang()}"});
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      if (jsonResult['data']['savingsSum'] == null) {
        amount = 0.0;
      } else {
        amount = jsonResult['data']['savingsSum'];
      }
      if (jsonResult['data']['fundSum'] == null) {
        fundAmount = 0.0;
      } else {
        fundAmount = jsonResult['data']['fundSum'];
      }
      if (jsonResult['data']['minerSum'] == null){
        miningAmount = 0.0;
      } else {
        miningAmount = jsonResult['data']['minerSum'];
      }
     if (jsonResult['data']['recommendSum'] == null) {
       totalAmount = 0.0;
     } else {
       totalAmount = jsonResult['data']['recommendSum'];
     }

    } else {
      showToast(translate('home.NetworkTip'),
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

    if (getPrivateAddress!.length >= 40) {
      setState(() {
        isConnected = true;
      });
    } else {
      setState(() {
        isConnected = false;
      });
    }
  }
  final _headerStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w400);
  bool isLiquidtySelected = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var localizationDelegate = LocalizedApp.of(context).delegate;
    String addressString = "";
    if (UserSharedPreferences.getPrivateAddress() != "") {
      addressString = UserSharedPreferences.getPrivateAddress()!
          .substring(
              UserSharedPreferences.getPrivateAddress()!.length - 3);
    }
    return Scaffold(
        drawer: AppDrawer(),
        backgroundColor: Color(0xFFF3F6F8),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          actions: <Widget>[
            ((UserSharedPreferences.getPrivateAddress() != ""))
                ? Container(
                    margin: EdgeInsets.only(
                        top: 12, bottom: 12, right: 12, left: 12),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            width: 50,
                            height: 16,
                            child: Text(
                              "${UserSharedPreferences.getPrivateAddress()}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            width: 50,
                            height: 16,
                            child: Text(
                              "..." + addressString,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ))
                : (UserSharedPreferences.getLoginType() == 2) ? Container(
                margin: EdgeInsets.only(
                    top: 12, bottom: 12, right: 12, left: 12),
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 2),
                        width: 50,
                        height: 16,
                        child: Text(
                          "${UserSharedPreferences.getUserName()}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                )) : Container(margin: EdgeInsets.only(top: 12, bottom: 12, right: 12), width: 140,child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ))),
                      onPressed: () {
                        Dialog errorDialog = Dialog(
                          backgroundColor: Color.fromARGB(255, 244, 244, 244),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ), //this right here
                          child: Container(
                            height: 570.0,
                            width: 600.0,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 24, left: 24, top: 24, bottom: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          child: Text(translate('home.network'),
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                      const Spacer(
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                // Comment this line if running on Mobile Phone ( Android / iOS)
                                MetaMaskPage(),
                                const Spacer(
                                  flex: 1,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                              ],
                            ),
                          ),
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => errorDialog);
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 0, top: 0, right: 0),
                          margin: EdgeInsets.only(left: 0, top: 0, right: 0),
                          child: Text(
                            translate('home.Login')+"/"+translate('home.Register'),
                            style: TextStyle(
                                color: ColorConstants.AppBlueColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ),
                    )),
          ],
          // title: "DGBank",

        ),
        body: ListView(
          children: [
            Container(
              height: 280,
              margin: EdgeInsets.all(26),
              padding: EdgeInsets.all(26),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 0, top: 0, bottom: 16),
                      width: 130,
                      height: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/BankManager.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      child: Text(
                        translate('home.blockchain'),
                        // "This platform belongs to technical research, please do not buy or trade in any form.",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w100),
                        textAlign: TextAlign.left,
                        maxLines: 2,
                      ),
                      padding: EdgeInsets.only(left: 150, top: 0),
                      height: 50,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      child: Text(
                        translate('home.decentralised'),
                        // "If you cause financial loss please contact me: Telegram: @TestBlockWeb3",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w100),
                        maxLines: 2,
                      ),
                      padding: EdgeInsets.only(left: 150, top: 50),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      child: Text(
                        translate('home.enjoy'),
                        // "All the data displayed on this platform are false data and are used for product function testing",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: "DMSans",
                            fontWeight: FontWeight.w100),
                        maxLines: 3,
                      ),
                      padding: EdgeInsets.only(left: 150, top: 100),
                      // height: 90,
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        top: 150,
                        bottom: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 6,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                height: 46,
                                width: 120,
                                margin: const EdgeInsets.only(
                                    left: 0, right: 5, top: 12, bottom: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    if ((UserSharedPreferences.getPrivateAddress() != "") || (UserSharedPreferences.getLoginType() == 2)){
                                      if (UserSharedPreferences.getLoginType() == 2) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AccountRechargeView()),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RechargeViews(savingsData: SavingRows(),)),
                                        );
                                      }
                                    }
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    color: ColorConstants.AppCoinbaseBlueColor,
                                    child: Center(
                                      child: Text(
                                        translate('home.TradeNow'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: "DMSans",
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container (
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.AboutDGBankProfile'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: "DMSans",
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              margin: const EdgeInsets.only(
                  left: 24, top: 14,right: 24, bottom: 15),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  )),
              child:Padding(padding:const EdgeInsets.only(top: 20, left: 26, right: 16,bottom: 15),
              child:  Text(
                translate('home.AbountProfile'),style: TextStyle(color: Colors.black,fontSize: 15),
              ))
           ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 26, right: 16),
              child: Text(
                translate('home.DGBankSavings') ,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.darkerText,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            CategoryListView(
              callBack: () {
                moveToBank();
              },
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16,bottom: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      translate('home.HighYieldFund'),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FundListView(
              callBack: () {
              },
            ),
            const SizedBox(
              height: 13,
            ),
            // Container(
            //   transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            //   margin: const EdgeInsets.only(
            //       left: 24, top: 24, right: 24, bottom: 0),
            //   width: double.infinity,
            //   height: 170,
            //   decoration: const BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(12),
            //       )),
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         left: 10, top: 24, right: 0, bottom: 24),
            //     child: Stack(
            //       children: [
            //         // Image radius
            //         IntrinsicHeight(
            //           child: Column(
            //             children: <Widget>[
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Expanded(
            //                     flex: 5,
            //                     child: Align(
            //                       alignment: Alignment.center,
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             crossAxisAlignment: CrossAxisAlignment.center,
            //                             children: [
            //                               ClipRect(
            //                                 child: SizedBox.fromSize(
            //                                   size: const Size.fromRadius(
            //                                       12), // Image radius
            //                                   child: Image.asset(
            //                                       'assets/images/BTC.png',
            //                                       fit: BoxFit.contain),
            //                                 ),
            //                               ),
            //                               const SizedBox(
            //                                 width: 12,
            //                               ),
            //                               Column(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                                 crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     translate('home.TotalDeposits'),
            //                                     style: TextStyle(
            //                                         fontSize: 15,
            //                                         color: Colors.black45,
            //                                         fontFamily: "DMSans",
            //                                         fontWeight:
            //                                         FontWeight.w600),
            //                                   ),
            //                                   SizedBox(
            //                                     height: 6,
            //                                   ),
            //                                   Row(
            //                                     mainAxisAlignment:
            //                                     MainAxisAlignment.start,
            //                                     children: [
            //                                       Countup(
            //                                         begin: 184.45,
            //                                         maxLines: 2,
            //                                         end: amount!,
            //                                         prefix: '\$ ',
            //                                         duration: const Duration(
            //                                             milliseconds: 1500),
            //                                         separator: ',',
            //                                         style: const TextStyle(
            //                                           overflow:
            //                                           TextOverflow.ellipsis,
            //                                           fontFamily: "DMSans",
            //                                           fontWeight:
            //                                           FontWeight.w600,
            //                                           fontSize: 16,
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 5,
            //                     child: Align(
            //                       alignment: Alignment.center,
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                             children: [
            //                               ClipRect(
            //                                 child: SizedBox.fromSize(
            //                                   size: const Size.fromRadius(
            //                                       12), // Image radius
            //                                   child: Image.asset(
            //                                       'assets/images/fund.png',
            //                                       fit: BoxFit.contain),
            //                                 ),
            //                               ),
            //                               const SizedBox(
            //                                 width: 5,
            //                               ),
            //                               Column(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                                 crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     translate('home.TotalVolume'),
            //                                     style: TextStyle(
            //                                         fontSize: 15,
            //                                         color: Colors.black45,
            //                                         fontFamily: "DMSans",
            //                                         fontWeight:
            //                                         FontWeight.w600),
            //                                   ),
            //                                   Row(
            //                                     mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                     children: [
            //                                       Countup(
            //                                         begin: 184.45,
            //                                         end: fundAmount!,
            //                                         prefix: '\$ ',
            //                                         duration: const Duration(
            //                                             milliseconds: 1500),
            //                                         separator: ',',
            //                                         style: const TextStyle(
            //                                           overflow:
            //                                           TextOverflow.ellipsis,
            //                                           fontFamily: "DMSans",
            //                                           fontWeight:
            //                                           FontWeight.w600,
            //                                           fontSize: 16,
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 16,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Expanded(
            //                     flex: 5,
            //                     child: Align(
            //                       alignment: Alignment.center,
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.start,
            //                             crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                             children: [
            //                               ClipRect(
            //                                 child: SizedBox.fromSize(
            //                                   size: const Size.fromRadius(
            //                                       12), // Image radius
            //                                   child: Image.asset(
            //                                       'assets/images/mining.png',
            //                                       fit: BoxFit.contain),
            //                                 ),
            //                               ),
            //                               const SizedBox(
            //                                 width: 12,
            //                               ),
            //                               Column(
            //                                 mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                                 crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text(
            //                                     translate('home.TotalMining'),
            //                                     style: TextStyle(
            //                                         fontSize: 15,
            //                                         color: Colors.black45,
            //                                         fontFamily: "DMSans",
            //                                         fontWeight:
            //                                         FontWeight.w600),
            //                                   ),
            //                                   SizedBox(
            //                                     height: 6,
            //                                   ),
            //                                   Row(
            //                                     mainAxisAlignment:
            //                                     MainAxisAlignment.start,
            //                                     children: [
            //                                       Countup(
            //                                         begin: 184.45,
            //                                         maxLines: 2,
            //                                         end: miningAmount!,
            //                                         prefix: '\$ ',
            //                                         duration: const Duration(
            //                                             milliseconds: 1500),
            //                                         separator: ',',
            //                                         style: const TextStyle(
            //                                           overflow:
            //                                           TextOverflow.ellipsis,
            //                                           fontFamily: "DMSans",
            //                                           fontWeight:
            //                                           FontWeight.w600,
            //                                           fontSize: 15,
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     flex: 5,
            //                     child: Align(
            //                       alignment: Alignment.center,
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                         CrossAxisAlignment.center,
            //                         children: [
            //                           Row(
            //                             mainAxisAlignment: MainAxisAlignment.start,
            //                             crossAxisAlignment: CrossAxisAlignment.center,
            //                             children: [
            //                               ClipRect(
            //                                 child: SizedBox.fromSize(
            //                                   size: const Size.fromRadius(
            //                                       12), // Image radius
            //                                   child: Image.asset(
            //                                       'assets/images/totaldeal.png',
            //                                       fit: BoxFit.contain),
            //                                 ),
            //                               ),
            //                               const SizedBox(
            //                                 width: 8,
            //                               ),
            //                               Column(
            //                                 mainAxisAlignment: MainAxisAlignment.start,
            //                                 crossAxisAlignment: CrossAxisAlignment.start,
            //                                 children: [
            //                                   Container(
            //                                     child: Text(
            //                                       translate('home.TotalDeal'),
            //                                       style: TextStyle(
            //                                           fontSize: 15,
            //                                           color: Colors.black45,
            //                                           fontFamily: "DMSans",
            //                                           fontWeight:
            //                                           FontWeight.w600),
            //                                     ),
            //                                     margin: EdgeInsets.only(right: 0),
            //                                   ),
            //                                   SizedBox(
            //                                     height: 6,
            //                                   ),
            //                                   Row(
            //                                     mainAxisAlignment:
            //                                     MainAxisAlignment.center,
            //                                     children: [
            //                                       Countup(
            //                                         begin: 184.45,
            //                                         end: totalAmount!,
            //                                         prefix: '\$ ',
            //                                         duration: const Duration(milliseconds: 1500),
            //                                         separator: ',',
            //                                         style: const TextStyle(
            //                                           overflow: TextOverflow.ellipsis,
            //                                           fontWeight: FontWeight.w600,
            //                                           fontFamily: "DMSans",
            //                                           fontSize: 15,
            //                                         ),
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 0, left: 24, right: 24, bottom: 16),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.Liquidity'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: DefiMiningView(
                callBack: () {
                  moveToMining();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 0, left: 24, right: 24, bottom: 16),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
               "DGBank" +" "+ translate('home.bond'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 0.0, 0.0),
              child: IBondsSavingsView(
                callBack: () {
                  moveToIBondPage();
                },
              ),
            ),
            Container(
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.WorkingAtDGBank'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 14, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    child: Text(translate('home.HereDGBank'),style: TextStyle(color: Colors.black),maxLines: 5,),
                  ),
                  Container(
                    width: 80,
                    height: 130,
                    child: Image.asset('assets/images/safe.png'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 10),
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text(translate('home.HereDGBank'),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),maxLines: 5,)
                  ),

                  Text(translate('home.WeSec'),style: TextStyle(color: Colors.black),),
                  Text(translate('home.LearnHow'),style: TextStyle(color: ColorConstants.AppCoinbaseBlueColor),),
                ],
              ),
            ),
            Container(
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 130,
                        child: Image.asset('assets/images/worldwide.png'),
                      ),
                    ],
                  ),
                  Text(translate('home.Protected'),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text(translate('home.BankProtected'),style: TextStyle(color: Colors.black,fontSize: 15),maxLines: 2,),
                  Text(translate('home.knowCoin'),style: TextStyle(color: ColorConstants.AppCoinbaseBlueColor),),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 16, left: 24, right: 24, bottom: 8),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.FAQ'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 24, left: 24, right: 24, bottom: 24),
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: FaqWidget(),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.Dex'),
                style: TextStyle(
                    fontSize: 18,
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
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 80,
                      width: 160,
                      margin: const EdgeInsets.only(
                          left: 8, right: 5, top: 0, bottom: 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(16)),
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                padding: EdgeInsets.only(left: 6,right: 5),
                                child: Image.asset('assets/images/apple.png'),
                              ),
                              Text(
                                'iOS',
                                style: TextStyle(
                                    color: ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 80,
                      width: 160,
                      margin: const EdgeInsets.only(
                          left: 8, right: 5, top: 0, bottom: 0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(16)),
                          ),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                padding: EdgeInsets.only(left: 6,right: 5),
                                child: Image.asset('assets/images/android.png'),
                              ),
                              Text(
                                'Android',
                                style: TextStyle(
                                    color: ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container (
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.CooperativeInsuranceAgency'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
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
                    Container(
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/FDIC.png'),
                    )
                  ],
                ),
              ),
            ),
            Container (
              margin:
              const EdgeInsets.only(top: 0, left: 24, right: 24, bottom: 2),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              child: Text(
                translate('home.OurRegulator'),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
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
                    Container(
                      // width: 110,
                      // height: 110,
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/FCAGraphic.png'),
                    ),
                    Container(
                      // width: 110,
                      // height: 110,
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/FHFA.png'),
                    ),
                    Container(
                      // width: 110,
                      // height: 110,
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/USASecurity.png'),
                    ),
                    Container(
                      // width: 110,
                      // height: 110,
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/OFACLogo.png'),
                    ),
                    Container(
                      // width: 110,
                      // height: 110,
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/nfa-300.png'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: PartnerWidget('assets/images/seclogo.png'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 70),
              transform: Matrix4.translationValues(0.0, 00.0, 0.0),
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 120,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.Careers'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 120,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LegalWebView()),
                          );
                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.PrivacyPolicy'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 120,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CookiePolicyView()),
                          );
                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.CookiePolicy'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 150,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsConditions()),
                          );
                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.TermsConditions'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 120,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsUseView()),
                          );
                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.TermsUse'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 46,
                      width: 120,
                      margin: const EdgeInsets.only(
                          left: 0, right: 5, top: 12, bottom: 0),
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Card(
                          color: Color(0xFFF3F6F8),
                          child: Center(
                            child: Text(translate('home.DigitalAsset'),style: TextStyle(color: ColorConstants.AppGreyColor,fontSize: 15,fontWeight: FontWeight.w100)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
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
  void moveToBank() {
    if ((UserSharedPreferences.getPrivateAddress() != "") || (UserSharedPreferences.getLoginType() == 2)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BankDetailPage()),
      );
    } else {
      LoadingProgress.showToastAlert(
          context, translate('home.PleaseConnect'));
    }

  }
  void moveToMining() {
    if ((UserSharedPreferences.getPrivateAddress() != "") || (UserSharedPreferences.getLoginType() == 2)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  MiningMainPage()),
      );
    } else {
      LoadingProgress.showToastAlert(
          context, translate('home.PleaseConnect'));
    }

  }
  void moveToIBondPage() {

    if ((UserSharedPreferences.getPrivateAddress() != "") || (UserSharedPreferences.getLoginType() == 2)) {

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const IBondViewPage()),
      );
    } else {
      LoadingProgress.showToastAlert(
          context, translate('home.PleaseConnect'));
    }
  }
  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          Container(
            child: PopularCourseListView(
              callBack: () {
                moveToBank();
              },
            ),
          )
        ],
      ),
    );
  }

}

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 196,
      margin: EdgeInsets.all(24),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        color: Color.fromRGBO(66, 78, 255, 1),
        child: Center(
          child: Text(
            translate('home.Equity'),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
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
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            subTitleText,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
            size: const Size.fromRadius(56), // Image radius
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ),
      ],
    ),
  );
}

Widget PartnerWidget(String imagePath) {
  return SizedBox(
    // height: 90,
    // width: 90,
    child: Column(
      children: [
        ClipRect(
          child: SizedBox.fromSize(
            size: const Size.fromRadius(54), // Image radius
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
        style: const TextStyle(
            fontSize: 16, color: Colors.black45, fontWeight: FontWeight.w600),
      ),
    ),
    leading: Container(padding: EdgeInsets.only(left: 16), child: icon),
    onTap: () {
      Navigator.pop(context);
    },
  );
}


import 'dart:convert';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/bank_model/recommend_balance_model.dart';
import 'package:flutter_bourse/Models/fund_account_model.dart';
import 'package:flutter_bourse/Models/recommend_acccount_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/RecommendView/recommend_view_cell.dart';
import 'package:flutter_bourse/widgets/UserCenter/generated/assets.dart';
import 'package:flutter_bourse/widgets/UserCenter/utils/iconly/iconly_bold.dart';
import 'package:flutter_bourse/widgets/UserCenter/widgets/custom_list_tile.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/bank_detail/bank_detail_cell.dart';
import 'package:flutter_bourse/widgets/buy_fund/fund_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_fund/fund_orders_model.dart';
import 'package:flutter_bourse/widgets/buy_fund/recommend_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_fund/recommend_orders_model.dart';
import 'package:flutter_bourse/widgets/buy_savings/detail_account.dart';
import 'package:flutter_bourse/widgets/buy_savings/fund_account.dart';
import 'package:flutter_bourse/widgets/buy_savings/fund_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/product_page_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/recommend_account.dart';
import 'package:flutter_bourse/widgets/buy_savings/recommend_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/withdraw_product_view.dart';
import 'package:flutter_bourse/widgets/fund_bank/fund_list_cell.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';

class BuyRecommendTransactionPage extends StatefulWidget {

  // final Function()? callBack;
  const BuyRecommendTransactionPage({Key? key}) : super(key: key);

  @override
  State<BuyRecommendTransactionPage> createState() => _BuyRecommendTransactionPageState();
}

class _BuyRecommendTransactionPageState extends State<BuyRecommendTransactionPage> {

  void niubi() {

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.ProductAccount'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SegmentedTabControl(
                    // Customization of widget
                    radius: const Radius.circular(30),
                    backgroundColor: Colors.grey.shade100,
                    indicatorColor: Colors.white,
                    tabTextColor: Colors.black45,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,
                    height: 45,
                    tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    // Options for selection
                    // All specified values will override the [SegmentedTabControl] setting
                    tabs: [
                      SegmentTab(
                        label: translate('home.SavingsAccount'),
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: Colors.white,
                      ),
                      SegmentTab(
                        label: translate('home.RecommendAccount'),
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: Colors.white,
                      ),
                      SegmentTab(
                        label: translate('home.FundAccount'),
                        // backgroundColor: Colors.white,
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        // textColor: Colors.black26,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      SavingsAccountWidget(label: 'FIRST PAGE',
                        color: Colors.white,),
                      RecommendAccountWidget(
                        label: 'FIRST PAGE',
                        color: Colors.white,
                      ),
                      FundAccountWidget(
                        // callTip:(){
                        //   niubi();
                        // },
                        label: 'FIRST PAGE',
                        color: Colors.white,

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FundAccountWidget extends StatefulWidget {
  // final Function()? callBack;

  const FundAccountWidget({
    Key? key,
    required this.label,
    required this.color,
    // required this.callTip
  }) : super(key: key);
  final String label;
  final Color color;
  // final VoidCallback? callTip;

  @override
  State<FundAccountWidget> createState() => _FundAccountWidgetState();
}

class _FundAccountWidgetState extends State<FundAccountWidget> {

 late RecommendBalanceModel? modelBalance = RecommendBalanceModel();

 var rowsList = <OrdersRows>[];
 late FundOrdersModel savingModel;
 late  FundAccountList? savingsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHomefountApi();
  }
  void loadHomefountApi() async {
    rowsList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/ufund/list');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        });
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingModel = FundOrdersModel.fromJson(jsonResult);
      for(var item in savingModel.rows!) {
        rowsList.add(item);
      }
      LogUtil.e("基金订单列表${rowsList}");
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

  void movePushNextPage(OrdersRows list) {
    // Navigator.pop(context);
    // Future.delayed(Duration(milliseconds:500)).then((value){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WithdrawProductView(walletType: "2", orderId: list.ftId,)),
      );
    // });
  }

 @override
 Widget build(BuildContext context) {

   return Scaffold(
           backgroundColor: Color(0xFFF3F6F8),
           body: SingleChildScrollView(
             child: Container(
               padding: EdgeInsets.all(5),
               margin: EdgeInsets.all(5),
               decoration: const BoxDecoration(
                   color: Color(0xFFF3F6F8),
                   borderRadius: BorderRadius.only(
                       topRight: Radius.circular(16),
                       bottomRight: Radius.circular(16),
                       topLeft: Radius.circular(16),
                       bottomLeft: Radius.circular(16))),
               child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: (rowsList.isNotEmpty) ? rowsList.length : 0,
                 padding: EdgeInsets.zero,
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context, index) {
                   return FundAccountDetailCell(list: rowsList[index],callback: (){
                     movePushNextPage(rowsList[index]);
                   },callCancelOrder: (){
                     setState(() {
                     });
                   },);
                 },
               ),
             ),
           ));
 }
}

class RecommendAccountWidget extends StatefulWidget {
  const RecommendAccountWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);
  final String label;
  final Color color;

  @override
  State<RecommendAccountWidget> createState() => _RecommendAccountWidgetState();
}

class _RecommendAccountWidgetState extends State<RecommendAccountWidget> {

  late RecommendBalanceModel? modelBalance = RecommendBalanceModel();
  var rowsList = <RecommendOrdersRows>[];
  late RecommendOrdersModel savingModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHomefountApi();
  }
  void loadHomefountApi() async {
    // rowsList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/urecommend/list');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        });
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingModel = RecommendOrdersModel.fromJson(jsonResult);
      for(var item in savingModel.rows!) {
        rowsList.add(item);
      }
      LogUtil.e("理财余额列表${jsonResult}");
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
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Color(0xFFF3F6F8),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(5),
            decoration: const BoxDecoration(
                color: Color(0xFFF3F6F8),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16))),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: (rowsList.isNotEmpty) ? rowsList.length : 0,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return RecommendAccountDetailCell(list: rowsList[index],callCancelOrder: (){
                  setState(() {

                  });
                },);
              },
            ),
          ),
        ));
  }
}

class SavingsAccountWidget extends StatefulWidget {
  const SavingsAccountWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);
  final String label;
  final Color color;

  @override
  State<SavingsAccountWidget> createState() => _SavingsAccountWidgetState();
}

class _SavingsAccountWidgetState extends State<SavingsAccountWidget> {

  late RecommendBalanceModel? modelBalance = RecommendBalanceModel();

  var rowsList = <SavingsOrdersRows>[];
  late SavingsAccountModel savingModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHomefountApi();
  }

  void loadHomefountApi() async {
    rowsList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/usavings/list');

    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json",
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        });
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingModel = SavingsAccountModel.fromJson(jsonResult);
      for(var item in savingModel.rows!) {
        rowsList.add(item);
      }
      LogUtil.e("储蓄余额列表${jsonResult}");
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavingViewsController>(
        init: SavingViewsController(),
        builder: (h) => Scaffold(
            backgroundColor: Color(0xFFF3F6F8),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: (rowsList.isNotEmpty) ? rowsList.length : 0,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return ProductPageCell(list: rowsList[index],);
                      },
                    ),

                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            )));
  }
}
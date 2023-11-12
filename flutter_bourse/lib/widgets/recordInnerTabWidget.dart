import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_model.dart';
import 'package:flutter_bourse/Models/MiningModel/records_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/widgets/MiningCellView/mining_history_list.dart';
import 'package:flutter_bourse/widgets/MiningCellView/record_history_list.dart';
import 'package:flutter_bourse/widgets/MiningCellView/withdraw_history_list.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tab_container/tab_container.dart';
import 'package:http/http.dart' as http;

class RecordSubTabWidget extends StatefulWidget {
  const RecordSubTabWidget({Key? key}) : super(key: key);

  @override
  _RecordSubTabWidgetState createState() => _RecordSubTabWidgetState();
}

class _RecordSubTabWidgetState extends State<RecordSubTabWidget> {
  late final TabContainerController _controller2;
  late TextTheme textTheme;
  late List<Records>? recordsList = [Records()];
  late List<Records>? withdrawList = [Records()];
  late List<Records>? miningList = [Records()];
  late List<Records>? benefitList = [Records()];

  @override
  void initState() {
    _controller2 = TabContainerController(length: 4);
    super.initState();
    exchangeHistoryNetwork();
    withdrawHistoryNetwork();
    miningHistoryNetwork();
    rebateHistoryNetwork();
  }

  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 270,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 270,
              child: AspectRatio(
                aspectRatio: 1,
                child: TabContainer(
                  radius: 12,
                  tabEdge: TabEdge.top,
                  // tabCurve: Curves.easeIn,
                  /*   transitionBuilder: (child, animation) {
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
                  colors: const <Color>[
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],

                  selectedTextStyle: textTheme.bodyText2?.copyWith(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  unselectedTextStyle: textTheme.bodyText2?.copyWith(
                      fontSize: 12.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.w500),
                  children: _getChildren2(),
                  tabs: _getTabs2(),
                ),
              ),
            ),
          ],
        ));
  }
  List<Widget> _getChildren2() {
    return <Widget>[
      _getSwapSubWidget(),
      _getWithdrawalSubWidget(),
      _getMiningSubWidget(),
      _getRebateSubWidget(),
    ];
  }
  List<String> _getTabs2() {
    return <String>[translate('home.Swap'), translate('home.Withdrawal'), translate('home.Mining'), translate('home.Rebate')];
  }
  Reload() async {
    // Obtain shared preferences.
    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      setState(() {
        Phoenix.rebirth(context);
      });
    });
  }
  ///----提现记录
  void withdrawHistoryNetwork() async {
    recordsList?.clear();
    withdrawList?.clear();
    miningList?.clear();
    benefitList?.clear();
    // Dio? _tokenDio;
    // Uri tokenurl = Uri.parse('${APIs.apiPrefix}/mobile/userInfo/login');
    // Map data = {
    //   'userName': UserSharedPreferences.getPrivateAddress().toString()
    // };
    // // var body = json.encode(data);
    // // final res = await http.post(tokenurl,
    // //     headers: {"Content-Type": "application/json"}, body: body);
    // DataUtils.login(data, success: (res) async {
      String url3 = "${APIs.apiPrefix}${APIs.getWithDrawRecords}?pageNum=1&PageSize=20";
      Uri wakuangApi = Uri.parse(url3);
      final response = await http.get(wakuangApi, headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      });
    Map<String,dynamic> data = jsonDecode(response.body);
      if (data['code'] == 200) {
        // var listData = jsonDecode(response.body);
        ///响应数据

        RecordsModel recordsModel = RecordsModel.fromJson(data);
        if (recordsModel.data!.records!.isNotEmpty) {
          for (var item in recordsModel.data!.records!) {
            withdrawList?.add(item);
          }
        }
        setState(() {
        });
        LogUtil.e('---------- 获取提现记录 ----------\n${withdrawList}');
      }
  }
  ///兑换记录
  void exchangeHistoryNetwork() async {
    recordsList?.clear();
    withdrawList?.clear();
    miningList?.clear();
    benefitList?.clear();
    String listHistoryString = "${APIs.apiPrefix}${APIs.listHistoryApi}?pageNum=1&PageSize=20";
    Uri listHistoryApi = Uri.parse(listHistoryString);
    final resCoin = await http.get(listHistoryApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });
    var jsonData = jsonDecode(resCoin.body);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    if (jsonResultCoin['code'] == 200) {
      ///响应数据
      Map<String,dynamic> data = jsonDecode(resCoin.body);

      RecordsModel recordsModel = RecordsModel.fromJson(data);
      if (recordsModel.data!.records!.isNotEmpty) {
        for (var item in recordsModel.data!.records!) {
          recordsList?.add(item);
        }
      }
      print("兑换记录${recordsList}");
      setState(() {
      });
    }
  }
  ///挖矿记录
  void miningHistoryNetwork() async {
    recordsList?.clear();
    withdrawList?.clear();
    miningList?.clear();
    benefitList?.clear();
    String miningHistoryString = "${APIs.apiPrefix}${APIs.getMiningRecords}?pageNum=1&PageSize=20";
    Uri miningHistoryApi = Uri.parse(miningHistoryString);
    final miningCoin = await http.get(miningHistoryApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });

    if (miningCoin.statusCode == 200) {
      ///响应数据
      Map<String,dynamic> data = jsonDecode(miningCoin.body);
      RecordsModel recordsModel = RecordsModel.fromJson(data);
      if (recordsModel.data!.records!.isNotEmpty) {
        for (var item in recordsModel.data!.records!) {
          miningList?.add(item);
        }
      }
      LogUtil.e("挖矿记录${miningList}");
    }
    setState(() {
    });
  }
  ///回扣记录
  void rebateHistoryNetwork() async {
    recordsList?.clear();
    withdrawList?.clear();
    miningList?.clear();
    benefitList?.clear();
    String benefitHistoryString = "${APIs.apiPrefix}${APIs.getUserGroupBenefit}?pageNum=1&PageSize=20";
    Uri benefitHistoryApi = Uri.parse(benefitHistoryString);
    final benefitCoin = await http.get(benefitHistoryApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    });
    if (benefitCoin.statusCode == 200) {
      ///响应数据
      Map<String,dynamic> data = jsonDecode(benefitCoin.body);
      RecordsModel recordsModel = RecordsModel.fromJson(data);
      if (recordsModel.data!.records!.isNotEmpty) {
        for (var item in recordsModel.data!.records!) {
          benefitList?.add(item);
        }
      }
      LogUtil.e('---------- 获取回扣记录 ----------\n${benefitList}');
    }
    setState(() {
    });
  }

  Widget _getSwapSubWidget() {

    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(translate('home.Time')),
                Text(translate('home.Count')),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: (recordsList!.length > 0) ?  ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: recordsList?.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return RecordHistoryList(index: index,recordsModel: recordsList![index],);
                },
              ) : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Container(
                 height: 56,
                 width: 56,
                 child: ClipRect(
                   child: SizedBox.fromSize(
                     size: Size.fromRadius(80), // Image radius
                     child: Image.asset('assets/images/nodata.png',
                     fit: BoxFit.contain),
            ),
          ),
        ),
               SizedBox(
          height: 6,
        ),
               Text(
          translate('home.NoData'),
          style: TextStyle(
              fontSize: 12,
              color: Colors.black38,
              fontWeight: FontWeight.w600),
        ),
               ],
              ),

            ),
          )
        ],
      ),
    );
  }

  Widget _getRebateSubWidget() {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      // color: Colors.black12,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.Time')),
                Text(translate('home.Count')),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
                child: (benefitList!.length > 0) ? ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: benefitList?.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return RecordHistoryList(index: index,recordsModel: benefitList![index],);
                  },
                ) : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: ClipRect(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(80), // Image radius
                          child: Image.asset('assets/images/nodata.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      translate('home.NoData'),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),

            ),
          )
        ],
      ),
    );
  }

  Widget _getWithdrawalSubWidget() {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      // color: Colors.black12,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.Time')),
                Text(translate('home.State')),
                Text(translate('home.Count')),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
                child: (withdrawList!.length > 0) ? ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: withdrawList?.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return WithdrawHistoryList(index: index,recordsModel: withdrawList![index],);
                  },
                ) : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: ClipRect(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(80), // Image radius
                          child: Image.asset('assets/images/nodata.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      translate('home.NoData'),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )

            ),
          )
        ],
      ),
    );
  }

  Widget _getMiningSubWidget() {
    return Container(
      margin: EdgeInsets.only(left: 4, right: 4),
      // color: Colors.black12,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(translate('home.Time')),
                // Text(translate('home.Type')),
                Text(translate('home.Count')),
              ],
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
                child: (miningList!.length > 0) ? ListView.builder(
                  shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: miningList?.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return MiningHistoryList(index: index,recordsModel: miningList![index],);
                  },
                ) : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      child: ClipRect(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(80), // Image radius
                          child: Image.asset('assets/images/nodata.png',
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      translate('home.NoData'),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black38,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )

            ),
          )
        ],
      ),
    );
  }
}

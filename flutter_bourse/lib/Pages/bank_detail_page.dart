
import 'dart:convert';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/RecommendView/recommend_view_cell.dart';
import 'package:flutter_bourse/widgets/bank_detail/bank_detail_cell.dart';
import 'package:flutter_bourse/widgets/fund_bank/fund_list_cell.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';

import '../Models/HomeModel/recommend_model.dart';


class BankDetailPage extends StatefulWidget {
  const BankDetailPage({Key? key}) : super(key: key);

  @override
  State<BankDetailPage> createState() => _BankDetailPageState();
}

class _BankDetailPageState extends State<BankDetailPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.DGProducts'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: MaterialApp(
        home: DefaultTabController(
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
                        label: translate('home.DGSavings'),
                        // backgroundColor: Colors.white,
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        // textColor: Colors.black26,
                        color: Colors.white,
                      ),
                      SegmentTab(
                        label: translate('home.DGrecommend'),
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        // For example, this overrides [indicatorColor] from [SegmentedTabControl]
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                // Sample pages
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SampleWidget(

                      ),
                      RecommendWidget(
                        label: 'FIRST PAGE',
                        color: Colors.white,
                      ),

                      // iBondWidget(label: 'iBond', color: Colors.white)
                    ],
                  ),
                ),
              ],
            ),
          ),
          length: 2,
        ),
      ),
    );
  }
}
class SampleWidget extends StatefulWidget {
  const SampleWidget({Key? key}) : super(key: key);

  @override
  State<SampleWidget> createState() => _SampleWidgetState();
}

class _SampleWidgetState extends State<SampleWidget> {

 late SavingModel savingsModel;
 late List<SavingRows> savingsModelList = [];
  @override
  void initState() {

    super.initState();
    savingsApi();

  }
  ///存储
 void savingsApi() async {
    savingsModelList.clear();
   Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/psavings/list');
   final res = await http.get(tokenurl,
       headers: {
     "Content-Type": "application/json",
         "lang":UserSharedPreferences.getPrivateLang().toString(),

         "zone": changeUtcStrToLocalStr(),
       });

   final Map<String, dynamic> jsonResult = jsonDecode(res.body);
   if (jsonResult['code'] == 200) {
     savingsModel = SavingModel.fromJson(jsonResult);

     for(var item in savingsModel.rows!) {
       savingsModelList.add(item);
     }
     setState(() {
     });
   } else {

   }
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
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
      padding: EdgeInsets.only(bottom: 70),
      child: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: (savingsModelList.length != null) ? savingsModelList.length : 0,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return BankDetailCell(index: index,savingsData: savingsModelList[index],);
        },
      ),
    );
  }
}

class RecommendWidget extends StatefulWidget {
  const RecommendWidget({
    Key? key,
    required this.label,
    required this.color,
  }) : super(key: key);
  final String label;
  final Color color;

  @override
  State<RecommendWidget> createState() => _RecommendWidgetState();
}

class _RecommendWidgetState extends State<RecommendWidget> {

  RecommendModel? savingsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRecommendApi();
  }

  void loadRecommendApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/precommend/list?recommendType=0');

    final res = await http.get(tokenurl,
        headers: {
      "Content-Type": "application/json", "lang":UserSharedPreferences.getPrivateLang().toString(),
          "zone": changeUtcStrToLocalStr(),
        });
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingsModel = RecommendModel.fromJson(jsonResult);
      LogUtil.e('推荐数据 $jsonResult');
      setState(() {
      });
    } else {

    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25))),
      padding: EdgeInsets.only(bottom: 70),
      child: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: (savingsModel?.rows != null) ? savingsModel?.rows!.length : 0,
        padding: EdgeInsets.zero,
        // padding: const EdgeInsets.only(
        //     top: 0, bottom: 0, right: 16, left: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return RecommendViewCell(index: index,recommendData: savingsModel?.rows![index],);
        },
      ),
    );
  }
}

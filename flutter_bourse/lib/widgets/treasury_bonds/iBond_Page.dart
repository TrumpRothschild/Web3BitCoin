
import 'dart:convert';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
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
import 'package:flutter_bourse/widgets/treasury_bonds/iBond_cell.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';

class IBondViewPage extends StatefulWidget {
  const IBondViewPage({Key? key}) : super(key: key);

  @override
  State<IBondViewPage> createState() => _IBondViewPageState();
}

class _IBondViewPageState extends State<IBondViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text("DGBank"+translate('home.bond'), style: TextStyle(color: Colors.black, fontSize: 18),),
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
                    radius: const Radius.circular(30),
                    backgroundColor: Colors.grey.shade100,
                    indicatorColor: Colors.white,
                    tabTextColor: Colors.black45,
                    selectedTabTextColor: Colors.white,
                    squeezeIntensity: 2,
                    height: 45,
                    tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    tabs: [
                      SegmentTab(
                        label: "DGBank"+translate('home.bond'),
                        selectedTextColor: ColorConstants.AppCoinbaseBlueColor,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      RecommendWidget(
                        label: 'FIRST PAGE',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          length: 1,
        ),
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
  late List<RecommendRows> recommendModelList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRecommendApi();
  }
  void loadRecommendApi() async {
    recommendModelList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/precommend/list?recommendType=1');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString()});
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingsModel = RecommendModel.fromJson(jsonResult);
      LogUtil.e('推荐数据 $jsonResult');
      for(var item in savingsModel!.rows!) {
        recommendModelList.add(item);
      }
      setState(() {
      });
    } else {
    }
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
        itemCount: (recommendModelList.isNotEmpty) ? recommendModelList.length : 0,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return iBondViewCell(index: index,recommendData: recommendModelList[index],);
        },
      ),
    );
  }
}

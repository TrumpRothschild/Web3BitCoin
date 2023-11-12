import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/bank_model/kChart_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/ChartLine/echarts_data.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
// import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quiver/iterables.dart';
import 'package:http/http.dart' as http;

class IBondsSavingsView extends StatefulWidget {
  const IBondsSavingsView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _IBondsSavingsViewState createState() => _IBondsSavingsViewState();
}

class _IBondsSavingsViewState extends State<IBondsSavingsView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  FundModel? modelFund = FundModel();
  late final Map<String, dynamic> jsonResult;
  List? fundList;
  late KChartModel chartModel;
  RecommendModel? savingsModel;
  var savingsList = <RecommendRows?>[];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    super.initState();
    // loadHomefountApi();
    loadRecommendApi();
  }


  void loadRecommendApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/precommend/list?recommendType=1');
    Map<String, dynamic> map = Map();
    map["recommendType"] = "1";
    var bodySave = json.encode(map);
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json", "lang":UserSharedPreferences.getPrivateLang().toString()});

    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingsModel = RecommendModel.fromJson(jsonResult);
      for(var item in savingsModel!.rows!) {
        savingsList.add(item);
      }
      setState(() {
      });
    } else {

    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        height: 190,
        width: double.infinity,
        child: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: (savingsList.isNotEmpty) ? savingsList.length : 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = savingsList.length > 10
                      ? 10
                      : savingsList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return FundView(
                    // category: Category.popularCourseList[index],
                    fund: savingsList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class FundView extends StatelessWidget {
  const FundView(
      {Key? key,
        // this.category,
        this.popularCourseList,
        this.animationController,
        this.animation,
        this.fund,
        this.callback})
      : super(key: key);

  final VoidCallback? callback;
  // final Category? category;
  final RecommendRows? fund;
  final Category? popularCourseList;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: callback,
              child: SizedBox(
                width: 280,
                child: Stack(
                  children: <Widget>[
                    Container(
                      // color: Colors.white,
                      padding: EdgeInsets.only(left: 15),
                      height:160,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                // color: HexColor('#F8FAFB'),
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width:  24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.only(right: 26),
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          const SizedBox(
                                            height:  24.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 0,bottom: 8,left: 0),
                                            margin: EdgeInsets.only(left: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: Image.asset('assets/images/usa-flag-logo.png',width: 30,height: 20,),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 130,
                                                  child: Text(
                                                    fund!.recommendName.toString(),
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 15,
                                                      fontFamily: "DMSans",
                                                      color: DesignCourseAppTheme.lightText,
                                                    ),
                                                    maxLines: 2,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 5,top: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '+ ${(fund!.profitRate!*100).toStringAsFixed(2)}%',
                                                  textAlign:
                                                  TextAlign.right,
                                                  style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 18,
                                                    fontFamily: "DMSans",

                                                    color: ColorConstants.AppGreenColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Text(translate('home.savingsIssued'),style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "DMSans",),textAlign: TextAlign.center,maxLines: 4,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 13.0,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
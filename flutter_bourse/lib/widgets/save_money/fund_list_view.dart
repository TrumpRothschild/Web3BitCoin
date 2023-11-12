import 'dart:convert';
// import 'dart:ffi';

import 'package:flustars/flustars.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Models/bank_model/kChart_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/ChartLine/echarts_data.dart';
import 'package:flutter_bourse/widgets/buy_fund/fund_view.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:graphic/graphic.dart';
import 'package:quiver/iterables.dart';
import 'package:http/http.dart' as http;

class FundListView extends StatefulWidget {
  const FundListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<FundListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  FundModel? modelFund = FundModel();
  late final Map<String, dynamic> jsonResult;
  List? fundList;
  late KChartModel chartModel;
  var listTrend = <FundRows?>[];
  List trendList = [];


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    // fundKChartApi();
    super.initState();
    loadHomefountApi();
  }
  void fundKChartApi() async {

    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/mfund/list');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString(),"zone": changeUtcStrToLocalStr(),});

    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      chartModel = KChartModel.fromJson(jsonResult);

    } else {

    }
    setState(() {
    });
  }
  void loadHomefountApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/pfund/list');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString()});
    jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      modelFund = FundModel.fromJson(jsonResult);
      List rows = jsonResult['rows'];
      for (var item in modelFund!.rows!) {
        listTrend.add(item);
      }
      for(var i =0;i <rows.length;i++){
        trendList.add(rows[i]['trend']);
      }
      print("K线图产品趋势${trendList}");
    }
    setState(() {
    });

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
        height: 200,
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
                itemCount: (listTrend.isNotEmpty) ? listTrend.length : 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = listTrend.length > 10
                      ? 10
                      : listTrend.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return FundView(
                    category: Category.popularCourseList[index],
                    fund: listTrend[index],
                    index: index,
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                    jsonResult: trendList[index],
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
var sumList = [[],[]];
class FundView extends StatelessWidget {
   FundView(
      {Key? key,
        this.category,
        this.popularCourseList,
        this.animationController,
        this.animation,
        this.fund,
        this.callback,
        this.index,
        required this.jsonResult

      })
      : super(key: key);

  final VoidCallback? callback;
  final Category? category;
  final FundRows? fund;
  final int? index;
  final Category? popularCourseList;
  final AnimationController? animationController;
  final Animation<double>? animation;
   final List jsonResult;

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
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  FundProView(index: index,fund: fund)),
                );
              },
              child: SizedBox(
                width: 300,
                child: Stack(
                  children: <Widget>[
                    Container(
                      // color: Colors.white,
                      padding: EdgeInsets.only(left: 15),
                      height: 200,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width:  14.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.only(right: 26),
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 0,bottom: 8,left: 0),
                                            margin: EdgeInsets.only(left: 0),
                                            child: Text(
                                              fund!.fundName!,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: "DMSans",
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme.lightText,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 5,top: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        translate('home.CurrentPrice'),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color: DesignCourseAppTheme.darkText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      Text(
                                                        '${jsonResult[1][0]}',
                                                        textAlign:
                                                        TextAlign.right,
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          fontSize: 18,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 5,top: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        // '近1年:  ',
                                                        translate('home.Nearly'),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color: DesignCourseAppTheme
                                                              .darkText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      Text(
                                                        '+ ${(fund!.annualRate!*100).toStringAsFixed(2)}%',
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
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 5,top: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        translate('home.ExpenseRatio'),
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color: DesignCourseAppTheme
                                                              .darkText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 25,
                                                      ),
                                                      Text(
                                                        '+ ${(fund!.fee!*100).toStringAsFixed(2)}%',
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
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, right: 0,top: 3,left: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: (category!.type == 0) ? ColorConstants.AppCoinbaseBlueColor : (category!.type == 1) ? ColorConstants.AppYellowColor : Colors.black,
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                    ),
                                                    width: 120,
                                                    height: 40,
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          10.0),
                                                      child: Text(translate('home.BuyFund'),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "DMSans",),textAlign: TextAlign.center,),
                                                    ),
                                                    margin: EdgeInsets.only(left: 0,bottom: 13),
                                                  ),
                                                )
                                              ],
                                            ),
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

const lineSectionsData = [
  [

  ],
  [

  ],
];
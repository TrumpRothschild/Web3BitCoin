import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';


class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  SavingModel? savingsModel;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    savingsApi();
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
  void savingsApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/psavings/list');
    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString(),
          "zone": changeUtcStrToLocalStr(),
        });
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      savingsModel = SavingModel.fromJson(jsonResult);
      LogUtil.e("存储信息列表${jsonResult}");
      setState(() {
      });
    } else {
      showToast("无网络");
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
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: Container(
        height: 164,
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
                itemCount: (savingsModel?.rows?.length != null) ? savingsModel?.rows?.length : 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int? count = savingsModel!.rows!.length > 10
                      ? 10
                      : savingsModel?.rows?.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count!) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return CategoryView(
                    category: savingsModel!.rows![index],
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

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,

      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final SavingRows? category;

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    var dailyDouble = category!.profitRate!.toDouble()*100;

    String sentence1 = sprintf('%0.2f', [dailyDouble]);

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
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
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
                                    width: 55 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.only(right: 26),
                                        color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16,right: 0),
                                            child: Text(
                                              category!.savingName!,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                fontFamily: "DMSans",
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .lightText,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                          const Expanded(
                                            child: SizedBox(),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Countup(
                                                        begin: 184.45,
                                                        end: double.parse(sentence1),
                                                        prefix: '+ ',
                                                        duration: const Duration(
                                                            milliseconds: 1500),
                                                        separator: ',',
                                                        style: const TextStyle(
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                            fontFamily: "DMSans",
                                                          fontWeight:
                                                          FontWeight.w900,
                                                          fontSize: 16,
                                                          color: ColorConstants.AppGreenColor
                                                        ),
                                                      ),
                                                      Text(
                                                       "%  APY",
                                                        textAlign:
                                                        TextAlign.right,
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 13,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color:
                                                          ColorConstants.AppGreenColor,
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
                                                bottom: 13, right: 13,top: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: (category!.savingId == 1) ? ColorConstants.AppCoinbaseBlueColor : (category!.savingId == 2) ? ColorConstants.AppYellowColor : Colors.black,
                                                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                  ),
                                                  width: 80,
                                                  height: 40,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => RechargeViews(savingsData: SavingRows(),)),
                                                        );
                                                      } else {
                                                        LoadingProgress.showToastAlert(
                                                            context, translate('home.PleaseConnect'));
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(10.0),
                                                      child: Text(translate('home.Deposit'),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "DMSans",),textAlign: TextAlign.center,),
                                                    ),
                                                  ),
                                                  margin: EdgeInsets.only(right: 0,bottom: 13),
                                                ),
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
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 16),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                              child: AspectRatio(
                                  aspectRatio: 1.0,
                                  child: Image.asset('assets/images/dgbank.png')),
                            )
                          ],
                        ),
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
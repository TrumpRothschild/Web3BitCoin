import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:countup/countup.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_bourse/Models/MiningModel/defi_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_defi.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
// import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_mining.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DefiMiningView extends StatefulWidget {
  const DefiMiningView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _DefiMiningViewState createState() => _DefiMiningViewState();
}

class _DefiMiningViewState extends State<DefiMiningView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  DefiModel? defiModel;
  var defiList = <DefiData?>[];
  var defiIconList = ["assets/images/ETH.png","assets/images/Doge.png","assets/images/XRP.png","assets/images/DYDX.png","assets/images/AXIE.png","assets/images/radiant.png","assets/images/SAND.png","assets/images/MANA.png","assets/images/ENJ.png","assets/images/YGG.png"];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    selectMining();
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
  void selectMining() async {
    Uri url = Uri.parse('${APIs.apiPrefix}/web/pminer/list?minerType=0');
    final resMining = await http.get(url,
        headers: {"Content-Type": "application/json",
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()
    });
    final Map<String, dynamic> jsonResult = jsonDecode(resMining.body);
    if (jsonResult['code'] == 200) {
      defiModel = DefiModel.fromJson(jsonResult);
      for(var item in defiModel!.rows!) {
        defiList.add(item);
      }
      setState(() {
      });
    } else {

    }

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
                itemCount: (defiList.isNotEmpty) ? defiList.length : 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = defiList.length > 10 ? 10 : defiList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return DefiView(
                    defiData: defiList[index],
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                    indexCreent: index,
                    iconList: defiIconList[index],
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

class DefiView extends StatelessWidget {

   DefiView(
      {Key? key,
        this.defiData,
        this.animationController,
        this.animation,
        this.callback,
        required this.indexCreent,
        required this.iconList
      })
      : super(key: key);

  final VoidCallback? callback;
  final DefiData? defiData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final int indexCreent;
  final String? iconList ;

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
                      builder: (context) => BuyDefiView(defiData: defiData,)),
                );
              },
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
                                              defiData!.outputCoin!,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20,
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
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 3),
                                            child: Text(
                                              translate('home.Reference')+": "+" ",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                fontFamily: "DMSans",
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme.darkText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, bottom: 6),
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Countup(begin: 184.45, end: defiData!.profitRate!*100*365, prefix: '+', duration: const Duration(milliseconds: 1500), separator: ',', style: const TextStyle(overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w900,fontFamily: "DMSans", fontSize: 18,color: ColorConstants.AppGreenColor),),
                                                  Text(
                                                    "%",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        fontFamily: "DMSans",
                                                        letterSpacing: 0.27,
                                                        color: ColorConstants.AppGreenColor
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8, right: 13,top: 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: ColorConstants.AppCoinbaseBlueColor,
                                                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                  ),
                                                  width: 80,
                                                  height: 40,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(10.0),
                                                    child: Text(translate('home.Minings'),style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "DMSans",),textAlign: TextAlign.center,),
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
                                  child:  Image.asset(iconList!)),
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
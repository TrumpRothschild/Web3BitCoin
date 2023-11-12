import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_bourse/Models/HomeModel/select_mining_mode.dart';
import 'package:flutter_bourse/Models/MiningModel/defi_model.dart';
import 'package:flutter_bourse/Models/MiningModel/kuangi_model.dart';
import 'package:flutter_bourse/Models/MiningModel/mining_info_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/buy_savings/buy_mining.dart';
import 'package:flutter_bourse/widgets/save_money/design_course_app_theme.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
// import 'package:best_flutter_ui_templates/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MiningMachineView extends StatefulWidget {
  const MiningMachineView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;

  @override
  _MiningMachineViewState createState() => _MiningMachineViewState();
}

class _MiningMachineViewState extends State<MiningMachineView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  KuangjiModel? kuangjiModel;
  MiningInfoModel? miningInfoModel;

  var kuangjiList = <KuangjiRows?>[];

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
    Uri url = Uri.parse('${APIs.apiPrefix}/web/pminer/list?minerType=1');
    final resMining = await http.get(url,
        headers: {"Content-Type": "application/json",
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        });
    final Map<String, dynamic> jsonResult = jsonDecode(resMining.body);
    if (jsonResult['code'] == 200) {
      kuangjiModel = KuangjiModel.fromJson(jsonResult);
      for(var item in kuangjiModel!.rows!) {
        kuangjiList.add(item);
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
                itemCount: (kuangjiList.isNotEmpty) ? kuangjiList.length : 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count = kuangjiList.length > 10
                      ? 10
                      : kuangjiList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController!,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController?.forward();
                  return MiningView(
                    defiData: kuangjiList[index],
                    category: Category.miningMachineList[index],
                    // miner: miningInfoModel!.data!.miner!,
                    // minerAlgorithm: miningInfoModel!.data!.minerAlgorithm!,
                    animation: animation,
                    animationController: animationController,
                    callback: widget.callBack,
                    indexCreent: index,
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

class MiningView extends StatelessWidget {
  const MiningView(
      {Key? key,
        this.category,
        this.animationController,
        this.animation,
        this.defiData,
        // required this.miner,
        // required this.minerAlgorithm,
        this.callback,required this.indexCreent})
      : super(key: key);

  final VoidCallback? callback;
  final KuangjiRows? defiData;
  final Category? category;

  final AnimationController? animationController;
  final Animation<double>? animation;
  final int indexCreent;

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
                      builder: (context) => BuyMiningViews(category: Category.miningCoinList[indexCreent],miner: defiData,)),
                );
              },
              child: SizedBox(
                width: 340,
                child: Stack(
                  children: <Widget>[
                    Container(
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
                                      color: Colors.white,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(top: 7,right: 0),
                                            child: Text(
                                              defiData!.minerName!,
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                                fontFamily: "DMSans",
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme.lightText,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                           height: 10,
                                         ),
                                          Container(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(bottom: 2),
                                              child: Text(
                                                translate('home.supportType')+" "+defiData!.outputCoin!,
                                                style: TextStyle(color: Colors.grey,fontSize: 15,fontFamily: "DMSans"),textAlign: TextAlign.center,),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 0, bottom: 1),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        translate('home.Reference')+": ",
                                                        textAlign: TextAlign.right,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 14,
                                                          fontFamily: "DMSans",
                                                          letterSpacing: 0.27,
                                                          color: DesignCourseAppTheme.darkText,
                                                        ),
                                                      ),
                                                      Countup(begin: 184.45, end: defiData!.profitRate!*100, prefix: '+', duration: const Duration(milliseconds: 1500), separator: ',', style: const TextStyle(overflow: TextOverflow.ellipsis,fontFamily: "DMSans", fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 0.27,color: ColorConstants.AppGreenColor),),
                                                      Text(
                                                        '%',
                                                        textAlign: TextAlign.right,
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
                                                bottom: 2, right: 13,top: 10),
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
                                  child: Image.network(defiData!.imgUrl!)),
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
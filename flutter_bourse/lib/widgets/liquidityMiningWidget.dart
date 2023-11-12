import 'dart:convert';

import 'package:countup/countup.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/defi_model.dart';
import 'package:flutter_bourse/Models/liquidityMiningModel.dart';
import 'package:flutter_bourse/Pages/miningMainPage.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import '../Models/HomeModel/mining_model.dart';
import '../Pages/colors.dart';
import 'package:http/http.dart' as http;

class LiquidityMiningWdiget extends StatefulWidget {
  const LiquidityMiningWdiget({Key? key}) : super(key: key);

  @override
  State<LiquidityMiningWdiget> createState() => _LiquidityMiningWdigetState();
}

class _LiquidityMiningWdigetState extends State<LiquidityMiningWdiget> {
  final double _height = 120;

  final _scrollController = ScrollController();
  bool flag = false;
  MiningModel? miningResult;
  DefiModel? defiModel;
  var defiDataList = <DefiData?>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectMining();
  }
  void selectMining() async {
    Uri url = Uri.parse('${APIs.apiPrefix}/web/pminer/list?minerType=0');
    final resMining = await http.get(url,
        headers: {"Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        });

    final Map<String, dynamic> jsonResult = jsonDecode(resMining.body);
    if (jsonResult['code'] == 200) {
      defiModel = DefiModel.fromJson(jsonResult);
      for(var item in defiModel!.rows!) {
        defiDataList.add(item);
      }
      setState(() {
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: ListView.builder(
        //  shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: (defiDataList.isNotEmpty) ? defiDataList.length : 0,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MiningMainPage()),)
            },
            child: LiquidityMiningItem(item: defiDataList[index]),
          );
        },
      ),
    );
  }
}

class LiquidityMiningItem extends StatelessWidget {

  final DefiData? item;
  const LiquidityMiningItem({Key? key, required this.item})
      : assert(item != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: 340,
      margin: const EdgeInsets.only(
        right: 24,
      ),
      height: 120,
      width: MediaQuery.of(context).size.width - 48,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 6),
        child: Column(
          children: [
            // Image radius
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(24), // Image radius
                                    child: Image.asset("assets/images/"+item!.outputCoin!+".png",
                                        fit: BoxFit.contain),
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  item!.outputCoin!,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              height: 24,
                              // width: 70,
                              padding: EdgeInsets.only(right: 8),
                              child: ElevatedButton(
                                  child: Text(translate('home.Enter'),
                                      style: TextStyle(fontSize: 12)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              ColorConstants.AppBlueColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MiningMainPage()),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.ProfitabilityAPY')+": ",
                        style: TextStyle(
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${item!.profitRate!*100}'+" %",
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            color: Color.fromARGB(221, 241, 2, 2),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

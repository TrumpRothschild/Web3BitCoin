import 'dart:convert';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/ActingModel/acting_level.dart';
import 'package:flutter_bourse/Models/ActingModel/acting_model.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

import '../Pages/colors.dart';
import 'package:http/http.dart' as http;

class TeamDataWidget extends StatefulWidget {
  TeamDataWidget({Key? key}) : super(key: key);

  @override
  State<TeamDataWidget> createState() => _TeamDataWidgetState();
}

class _TeamDataWidgetState extends State<TeamDataWidget> {
  bool inverter = false;

  final _headerStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w400);
  final _contentStyleHeader = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  ActingModel? actingModel;
  ActingLevel? actingLevel;
  ActingLevel? actingLevel2;
  ActingLevel? actingLevel3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupUserApi();
    // benefitByLevel("1");
    // benefitByLevel2('2');
    // benefitByLevel3('3');
  }
  void groupUserApi() async {
    Map<String, dynamic>?  data = {
    };
    DataUtils.getGroupUserCount(data,success: (res)  {
      final Map<String, dynamic> jsonData = res;
      actingModel = ActingModel.fromJson(res);
      print("获取团队资料${jsonData}");
      setState(() {
      });
    });
  }
  void benefitByLevel(String level) {
    Map<String, dynamic>?  data = {
      "level" : level
    };
    DataUtils.getUserGroupsBenefitByLevel(data,success: (res)  {
      final Map<String, dynamic> jsonData = res;
      actingLevel = ActingLevel.fromJson(jsonData);
      print("获取代理下级一级${actingLevel}");
      setState(() {
      });
    });
  }
  void benefitByLevel2(String level) {
    Map<String, dynamic>?  data = {
      "level" : level
    };
    DataUtils.getUserGroupsBenefitByLevel(data,success: (res)  {
      final Map<String, dynamic> jsonData = res;
      actingLevel2 = ActingLevel.fromJson(jsonData);
      print("获取代理下级二级${actingLevel}");
      setState(() {
      });
    });
  }
  void benefitByLevel3(String level) {
    Map<String, dynamic>?  data = {
      "level" : level
    };
    DataUtils.getUserGroupsBenefitByLevel(data,success: (res)  {
      final Map<String, dynamic> jsonData = res;
      actingLevel3 = ActingLevel.fromJson(jsonData);
      print("获取代理下级三级${actingLevel}");
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 6,
          ),
          getMiningData(translate('home.NumberTeams'),(actingModel?.data?.groupUserNum != null) ? "${actingModel?.data?.groupUserNum}" : "0") ,
          getMiningData(translate('home.TeamEarnings'), (actingModel?.data?.groupUserNum != null) ? "${actingModel?.data?.allEth}" + "  ETH" : "0 ETH" ),
          Accordion(
            disableScrolling: true,
            initialOpeningSequenceDelay: 0,
            maxOpenSections: 1,
            headerBackgroundColorOpened: Colors.black54,
            scaleWhenAnimating: true,
            openAndCloseAnimation: true,
            paddingListTop: 0,
            paddingListBottom: 0,
            //  headerPadding:
            //     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                contentBackgroundColor: Colors.white,
                contentBorderWidth: 0,
                contentBorderColor: Colors.white,
                headerBackgroundColor: Colors.white,
                isOpen: false,
                flipRightIconIfOpen: false,
                rightIcon: Row(
                  children: [
                    Text(
                      (actingModel.isNull) ? "0" : "${actingModel?.data?.levelSumBenefit?.i1}",
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Icon(Icons.arrow_drop_down,
                        color: ColorConstants.AppGreenColor),
                  ],
                ),
                header: Text(translate('home.GenerationIncome'), style: _headerStyle),
                content: Align(
                  alignment: Alignment.center,
                  child: (!actingModel.isNull) ?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(translate('home.TeamEarnings'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13),),
                          padding: EdgeInsets.only(left: 40),
                        ),
                        Container(child: Text(translate("home.SubordinateAgents"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13)),
                          padding: EdgeInsets.only(right: 40),
                        ),
                  ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumBenefit?.i1}" + " ETH",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(left: 40,top: 15),
                              ),
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumUser?.i1}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(right: 40,top: 15),
                              )
                            ])
                      ]) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 0.8,
                      ),
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
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              AccordionSection(
                contentBackgroundColor: Colors.white,
                contentBorderWidth: 0,
                contentBorderColor: Colors.white,
                headerBackgroundColor: Colors.white,
                isOpen: false,
                flipRightIconIfOpen: false,
                rightIcon: Row(
                  children: [
                    Text(
                      (actingModel == null) ? "0" : "${actingModel?.data?.levelSumBenefit?.i3}",
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Icon(Icons.arrow_drop_down,
                        color: ColorConstants.AppGreenColor),
                  ],
                ),
                header: Text(translate('home.SecondGeneration'), style: _headerStyle),
                content: Align(
                  alignment: Alignment.center,
                  child: (!actingModel.isNull) ?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(translate('home.TeamEarnings'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13),),
                                padding: EdgeInsets.only(left: 40),
                              ),
                              Container(child: Text(translate("home.SubordinateAgents"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13)),
                                padding: EdgeInsets.only(right: 40),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumBenefit?.i2}" + " USDT",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(left: 40,top: 15),
                              ),
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumUser?.i2}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(right: 40,top: 15),
                              )
                            ])
                      ]) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 0.8,
                      ),
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
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              AccordionSection(
                contentBackgroundColor: Colors.white,
                contentBorderWidth: 0,
                contentBorderColor: Colors.white,
                headerBackgroundColor: Colors.white,
                isOpen: false,
                flipRightIconIfOpen: false,
                rightIcon: Row(
                  children: [
                    Text(
                      (actingModel == null) ? "0" : "${actingModel?.data?.levelSumBenefit?.i3}",
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    const Icon(Icons.arrow_drop_down,
                        color: ColorConstants.AppGreenColor),
                  ],
                ),
                header: Text(translate('home.ThreeIncome'), style: _headerStyle),
                content: Align(
                  alignment: Alignment.center,
                  child: (!actingModel.isNull) ?Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(translate('home.TeamEarnings'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13),),
                                padding: EdgeInsets.only(left: 40),
                              ),
                              Container(child: Text(translate("home.SubordinateAgents"),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 13)),
                                padding: EdgeInsets.only(right: 40),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumBenefit?.i3}" + " USDT",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(left: 40,top: 15),
                              ),
                              Container(child: Text((actingModel == null) ? "0" : "${actingModel?.data?.levelSumUser?.i3}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200,fontSize: 12),),
                                padding: EdgeInsets.only(right: 40,top: 15),
                              )
                            ])
                      ]) : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Divider(
                        thickness: 0.8,
                      ),
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
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool accordinClose() {
    inverter = !inverter;
    setState(() {});
    return inverter;
  }

  bool accordinOpen() {
    inverter = !inverter;
    setState(() {});
    return inverter;
  }

  Widget getMiningData(String name, String value) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 12, left: 6, right: 6),
      padding: EdgeInsets.only(left: 18, right: 18, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

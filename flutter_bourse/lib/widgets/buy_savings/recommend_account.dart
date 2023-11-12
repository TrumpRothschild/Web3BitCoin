import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/recommend_acccount_model.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/widgets/buy_fund/recommend_account_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/product_page_cell.dart';
import 'package:flutter_bourse/widgets/buy_savings/recommend_account_cell.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class RecommendAccountViewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

class RecommendAccountViews extends StatefulWidget {

  final ListRecommend? savingsList;
  final int? index;
  const RecommendAccountViews({Key? key,this.index,this.savingsList}) : super(key: key);

  @override
  State<RecommendAccountViews> createState() => _RecommendAccountViewsState();
}

class _RecommendAccountViewsState extends State<RecommendAccountViews> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadHomefountApi();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecommendAccountViewsController>(
        init: RecommendAccountViewsController(),
        builder: (h) => Scaffold(
            backgroundColor: Color(0xFFF3F6F8),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                decoration: const BoxDecoration(
                    color: Color(0xFFF3F6F8),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16))),
                // child: ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: (widget.savingsList!.productList!.isNotEmpty) ? widget.savingsList!.productList!.length : 0,
                //   padding: EdgeInsets.zero,
                //   scrollDirection: Axis.vertical,
                //   itemBuilder: (context, index) {
                //     return RecommendAccountDetailCell(list: widget.savingsList!.productList![index],);
                //   },
                // ),
              ),
            )
        ));
  }
}




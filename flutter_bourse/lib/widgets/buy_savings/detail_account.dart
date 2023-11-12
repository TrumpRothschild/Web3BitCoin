import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:flutter_bourse/widgets/buy_savings/product_page_cell.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class SavingViewsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }
}

// class SavingViews extends StatefulWidget {
//
//   // final SavingsList? savingsList;
//   final int? index;
//   const SavingViews({Key? key,this.index,this.savingsList}) : super(key: key);
//
//   @override
//   State<SavingViews> createState() => _SavingViewsState();
// }
//
// class _SavingViewsState extends State<SavingViews> {
//
//   late List<SavingsList> rowsList = [];
//   late SavingsAccountModel savingModel;
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // loadHomefountApi();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SavingViewsController>(
//         init: SavingViewsController(),
//         builder: (h) => Scaffold(
//           backgroundColor: Color(0xFFF3F6F8),
//             body: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.all(0),
//                 margin: EdgeInsets.all(0),
//                 child: Column(
//                   children: <Widget>[
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: (widget.savingsList!.productList!.isNotEmpty) ? widget.savingsList!.productList!.length : 0,
//                       padding: EdgeInsets.zero,
//                       scrollDirection: Axis.vertical,
//                       itemBuilder: (context, index) {
//                         return ProductPageCell(list: widget.savingsList!.productList![index],);
//                       },
//                     ),
//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: Container(
//                         height: 50,
//
//                         margin: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 0),
//                         padding: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 0),
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => WithdrawView(walletType: '1',)),
//                             );
//                             setState(() {
//                             });
//                           },
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(25)),
//                             ),
//                             color: ColorConstants.AppCoinbaseBlueColor,
//                             child: Center(
//                               child: Text(
//                                 translate('home.Extract'),
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15,
//                     )
//                   ],
//                 ),
//               ),
//             )));
//   }
// }




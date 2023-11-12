import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_bourse/widgets/transaction_order.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OrderDetailPage extends GetView<TransactionHistory> {
  final HistoryRecords rows;
  const OrderDetailPage({Key? key, required this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        elevation: 0,
        title: Text(translate('home.OrdersDetail')),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15,right: 15,top: 15),
        height: 436,
        decoration: new BoxDecoration(
          color: Colors.white,
          //Set the rounded corner angle
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          // border: new Border.all(width: 1, color: Colors.black26),
        ),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 30,bottom: 15),
                    child: Text(
                      rows.currencyMedium.toString(),
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 30,bottom: 15),
                    child: Text(rows.orderNo.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.BuyAmount') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.orderMoney.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.OpeningPrice') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.buyPrice.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.BuyDirection'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child:  (rows.orderStatus == 2) ? Text(translate('home.Bearish'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFFFA6142))) : Text(
                       translate('home.Bullish'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF00C692)),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.Time'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.seconds.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.Profitability') + "(%)",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text('${rows.settlePercentage!*100}%',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.ProfitUSDT') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.profitMoney.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF00C692)),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.HandlingFee'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.fee.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.OpeningTime'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.buyTime.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.ClosingTime'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(

                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.settleTime.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
                    child: Text(translate('home.ClosingPrice'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
                    child: Text(rows.settlePrice.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _OrderDetailPageState extends State<OrderDetailPage> {
//   // late Rows row;
//
//   @override
//   Widget build(BuildContext context) {
//     // ;
//     print("传参${ModalRoute.of(context)?.settings.arguments}");
//
//     return Scaffold(
//
//       backgroundColor: Color(0xFFF3F6F8),
//       appBar: AppBar(
//         elevation: 0,
//         title: Text(translate('home.OrdersDetail')),
//       ),
//       body: Container(
//         margin: EdgeInsets.only(left: 15,right: 15,top: 15),
//         height: 436,
//         decoration: new BoxDecoration(
//           color: Colors.white,
//           //Set the rounded corner angle
//           borderRadius: BorderRadius.all(Radius.circular(6.0)),
//           // border: new Border.all(width: 1, color: Colors.black26),
//         ),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 30,bottom: 15),
//                     child: Text(
//                       "row.currencyMedium.toString()",
//                       style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//
//                   Container(
//
//                     margin: EdgeInsets.only(left: 16,top: 30,bottom: 15),
//                     child: Text('202208171283782137823274',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.BuyAmount') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('10000',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.OpeningPrice') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('10000',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.BuyDirection'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text(translate('home.Bullish'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF00C692)),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.Time'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text(translate('home.30s'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.Profitability') + "(%)",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('20%',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.ProfitUSDT') + '(USDT)',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('+2000',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF00C692)),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.HandlingFee'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('200',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.OpeningTime'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('2022-08-17 11:48:58',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.ClosingTime'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('2022-08-17 11:48:58',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(left: 16,top: 0,bottom: 15),
//                     child: Text(translate('home.ClosingPrice'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Color(0xFF989BA9)),),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 0,bottom: 15,right: 15),
//                     child: Text('23806.83',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.black),),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );;
//   }
// }

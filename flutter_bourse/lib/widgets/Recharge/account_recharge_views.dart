
import 'dart:convert';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/bank_model/fund_model.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/model/network_recharge_model.dart';
import 'package:flutter_bourse/widgets/Recharge/model/recharge_model.dart';
import 'package:flutter_bourse/widgets/Recharge/submit_credentials_dart.dart';
import 'package:flutter_bourse/widgets/RecommendView/recommend_view_cell.dart';
import 'package:flutter_bourse/widgets/bank_detail/bank_detail_cell.dart';
import 'package:flutter_bourse/widgets/fund_bank/fund_list_cell.dart';
import 'package:flutter_bourse/widgets/save_money/models/category.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class AccountRechargeView extends StatefulWidget {


  const AccountRechargeView({Key? key}) : super(key: key);

  @override
  State<AccountRechargeView> createState() => _AccountRechargeViewState();
}

class _AccountRechargeViewState extends State<AccountRechargeView> {

  var orderMoney = "";
  var addressWithdraw = "";
  // late RechargeModel rechargeModel = RechargeModel();
  late double usdtMoney = 0;
  late String withdrawFee = "";
  var passwordString = "";
  var inputBool = true;
  var isSelectedBtc = false;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedUSDC = false;
  var isSelectedErc = false;
  var isSelectedERC20USDT = true;
  var isSelectedTRC20USDT = false;
  var isSelectedUSDCERC20 = false;
  var isSelectedUSDCTRC20 = false;
  late RechargeDataModel modelRecharge = RechargeDataModel();

  var feeMonry = "";
  var coinId = 0;
  var networkId = 0;
  var loginType = UserSharedPreferences.getLoginType();
  // String erc = 'Automatic recharge';
  // String network = 'ERC20';
  var address = "";
  var codeImage = '';
  @override
  void initState() {
    super.initState();
    accountLoginTypeInfo();
  }

  void accountLoginTypeInfo() async {
    String walletString = "${APIs.apiPrefix}/web/coin/list";
    Uri walletUrl = Uri.parse(walletString);
    final walletResponse = await http.post(walletUrl,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
      "lang":UserSharedPreferences.getPrivateLang().toString()
    });
    final Map<String, dynamic> jsonResult = jsonDecode(walletResponse.body);
    if (jsonResult['code'] == 200) {

      modelRecharge = RechargeDataModel.fromJson(jsonResult);
      coinId = modelRecharge.data![2].coinId!;
      address = modelRecharge.data![2].address!;
      codeImage = modelRecharge.data![2].codeImg!;

    } else if (jsonResult['code'] == 401) {
      showToast(translate('home.LoginTip'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.DepositToken'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  SingleChildScrollView(
        child: Container(
          // height: 670,
          color: Color(0xFFF3F6F8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            isSelectedBtc = true;
                            isSelectedEth = false;
                            isSelectedDoge = false;
                            isSelectedERC20USDT = false;
                            isSelectedTRC20USDT = false;
                            isSelectedUSDCERC20 = false;
                            isSelectedUSDCTRC20 = false;
                            coinId = modelRecharge.data!.first.coinId!;
                            address = modelRecharge.data!.first.address.toString();
                            feeMonry = modelRecharge.data!.first.fee!.toString();
                            codeImage = modelRecharge.data!.first.codeImg.toString();
                            setState(() {

                            });
                          },
                          child: Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedBtc == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                // translate('home.TradeNow'),
                                "BTC",
                                style: TextStyle(
                                    color: (isSelectedBtc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ) ,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {

                            isSelectedBtc = false;
                            isSelectedEth = false;
                            isSelectedDoge = false;
                            isSelectedERC20USDT = true;
                            isSelectedTRC20USDT = false;
                            isSelectedUSDCERC20 = false;
                            isSelectedUSDCTRC20 = false;
                            coinId = modelRecharge.data![2].coinId!;
                            address = modelRecharge.data![2].address!;
                            feeMonry = modelRecharge.data![2].fee!.toString();
                            codeImage = modelRecharge.data![2].codeImg.toString();
                            setState(() {

                            });
                          },
                          child:Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedERC20USDT == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "USDT-ERC20",
                                style: TextStyle(
                                    color: (isSelectedERC20USDT == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            isSelectedBtc = false;
                            isSelectedEth = false;
                            isSelectedDoge = false;
                            isSelectedERC20USDT = false;
                            isSelectedTRC20USDT = true;
                            isSelectedUSDCERC20 = false;
                            isSelectedUSDCTRC20 = false;
                            coinId = modelRecharge.data![1].coinId!;
                            address = modelRecharge.data![1].address!;
                            feeMonry = modelRecharge.data![1].fee!.toString();
                            codeImage = modelRecharge.data![1].codeImg.toString();
                            setState(() {

                            });
                          },
                          child:Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedTRC20USDT == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "USDT-TRC20",
                                style: TextStyle(
                                    color: (isSelectedTRC20USDT == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            isSelectedBtc = false;
                            isSelectedEth = true;
                            isSelectedDoge = false;

                            isSelectedERC20USDT = false;
                            isSelectedTRC20USDT = false;
                            isSelectedUSDCERC20 = false;
                            isSelectedUSDCTRC20 = false;
                            coinId = modelRecharge.data![6].coinId!;
                            address = modelRecharge.data![6].address!;
                            feeMonry = modelRecharge.data![6].fee!.toString();
                            codeImage = modelRecharge.data![6].codeImg.toString();
                            setState(() {

                            });
                          },
                          child:Container(
                            decoration:  BoxDecoration(
                              color: (isSelectedEth == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(23),
                              ),

                            ),
                            child: Center(
                              child: Text(
                                // translate('home.TradeNow'),
                                "ETH",
                                style: TextStyle(
                                    color: (isSelectedEth == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),

                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {

                              isSelectedBtc = false;
                              isSelectedEth = false;
                              isSelectedDoge = true;

                              isSelectedERC20USDT = false;
                              isSelectedTRC20USDT = false;
                              isSelectedUSDCERC20 = false;
                              isSelectedUSDCTRC20 = false;
                              coinId = modelRecharge.data![3].coinId!;
                              address = modelRecharge.data![3].address!;
                              feeMonry = modelRecharge.data![3].fee!.toString();
                              codeImage = modelRecharge.data![3].codeImg.toString();

                              setState(() {

                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedDoge == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),

                              ),
                              child: Center(
                                child: Text(
                                  // translate('home.TradeNow'),
                                  "Doge",
                                  style: TextStyle(
                                      color: (isSelectedDoge == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {
                              // isSelectedErc = true;
                              isSelectedBtc = false;
                              isSelectedEth = false;
                              isSelectedDoge = false;

                              isSelectedERC20USDT = false;
                              isSelectedTRC20USDT = false;
                              isSelectedUSDCERC20 = true;
                              isSelectedUSDCTRC20 = false;
                              coinId = modelRecharge.data![4].coinId!;
                              address = modelRecharge.data![4].address!;
                              feeMonry = modelRecharge.data![4].fee!.toString();
                              codeImage = modelRecharge.data![4].codeImg.toString();
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedUSDCERC20 == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),

                              ),
                              child: Center(
                                child: Text(
                                  "USDC-ERC20",
                                  style: TextStyle(
                                      color: (isSelectedUSDCERC20 == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                      Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                            onTap: () {
                              isSelectedBtc = false;
                              isSelectedEth = false;
                              isSelectedDoge = false;
                              isSelectedERC20USDT = false;
                              isSelectedTRC20USDT = false;
                              isSelectedUSDCERC20 = false;
                              isSelectedUSDCTRC20 = true;
                              coinId = modelRecharge.data![5].coinId!;
                              address = modelRecharge.data![5].address!;
                              feeMonry = modelRecharge.data![5].fee!.toString();
                              codeImage = modelRecharge.data![5].codeImg.toString();
                              setState(() {

                              });
                            },
                            child: Container(
                              decoration:  BoxDecoration(
                                color: (isSelectedUSDCTRC20 == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(23),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "USDC-TRC20",
                                  style: TextStyle(
                                      color: (isSelectedUSDCTRC20 == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )

                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 20),
                  padding: EdgeInsets.only(left: 10,right: 10,bottom: 0,top: 20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (codeImage =='') ? Container(): Container(
                            child: Image.memory(base64.decode(codeImage.split(',')[1]),fit: BoxFit.fill,gaplessPlayback: true,),
                            width: 180,
                            height: 180,
                          ),
                        ],
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 330,
                              child: Text(address,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: address));
                          showToast(translate('home.CopySuccess'),
                              context: context,
                              animation: StyledToastAnimation.scale,
                              reverseAnimation: StyledToastAnimation.fade,
                              position: StyledToastPosition.center,
                              animDuration: Duration(seconds: 1),
                              duration: Duration(seconds: 4),
                              curve: Curves.elasticOut,
                              reverseCurve: Curves.linear);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text('Copy',style: TextStyle(color: ColorConstants.AppCoinbaseBlueColor,fontSize: 15,fontWeight: FontWeight.w900),),
                        ),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              height: 60,
                              width: 220,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 3, bottom: 0),
                              padding: EdgeInsets.only(left: 15, right: 15, top: 3, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SubmitCredentialsView(coinId: coinId,networkId: networkId)),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                  ),
                                  color: ColorConstants.AppCoinbaseBlueColor,
                                  child: Center(
                                    child: Text(
                                      translate('home.Deposit'),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
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
  }
}

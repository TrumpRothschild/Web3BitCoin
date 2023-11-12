import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HistoryModel/miner_history_model.dart';
import 'package:flutter_bourse/Models/Recharge/recharge_model.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/dio_utils.dart';
import 'package:flutter_bourse/http/error_handle.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/utils/jh_encrypt_utils.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/utils/obdj_ImageButton.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/model/recharge_model.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;

class MiningWithdrawView extends StatefulWidget {

  final String? coinName;
  final MinerRows? rows;
  const MiningWithdrawView({Key? key,this.coinName,this.rows}) : super(key: key);

  @override
  State<MiningWithdrawView> createState() => _MiningWithdrawViewState();
}

class _MiningWithdrawViewState extends State<MiningWithdrawView> {

  var orderMoney = "";
  var addressWithdraw = "";
  late RechargeModel rechargeModel = RechargeModel();
  late double usdtMoney = 0;
  late String withdrawFee = "";
  var passwordString = "";
  var inputBool = true;
  var isSelectedBtc = true;
  String fundType = '';
  var responseData = "";
  late Map<String, dynamic> jsonDataCoin;

  bool wcConnected = false;
  late Future balanceF;
  late Future usdcBalanceF;
  double walletResult = 0.0000;
  var status = '0';
  late RechargeDataModel modelRecharge = RechargeDataModel();
  var coinId = 0;
  var address = "";
  BigInt cakePerBlock = BigInt.zero;
  int poolLength = 0;
  BigInt yourCakeBalance = BigInt.zero;
  String? addressString = '';
  String txHash = '';
  var feeMonry = "";


  TextEditingController _controllerTextEdit = TextEditingController();
  FocusNode _node = FocusNode();
  var loginType = UserSharedPreferences.getLoginType();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountInfoApi();
  }

  void getAccountInfoApi() async {
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
      print('获取充值地址${jsonResult}');
      modelRecharge = RechargeDataModel.fromJson(jsonResult);
      coinId = modelRecharge.data![2].coinId!;
      addressString = modelRecharge.data![2].address!;
      feeMonry = modelRecharge.data![2].fee!.toString();
    } else if (jsonResult['code'] == 401) {
      showToast(translate('home.LoginExpired'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    } else {
      showToast(jsonResult['msg'],
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

  void withdrawCoinRequest() async {

    LoadingProgress.ShowLoading(context);
    String url3 = "${APIs.apiPrefix}${APIs.withdrawDepositApi}";
    Uri withdrawMoneyApi = Uri.parse(url3);
    var encrypted = JhEncryptUtils.aesEncrypt(passwordString);
    Map<String, dynamic> map = Map();
    map["amount"] = double.parse(orderMoney);
    map["password"] = encrypted;
    map["coinId"] = coinId;
    map['fee'] = double.parse(feeMonry);
    map['walletType'] = '4';
    map['orderId'] = widget.rows!.mtId;
    map["address"] = addressWithdraw;
    var bodySave = json.encode(map);
    ///发起get请求
    final resCoin = await http.post(withdrawMoneyApi,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        }, body: bodySave);
    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    LogUtils.e("提现接口${jsonResultCoin}");
    if (jsonResultCoin['code']==200) {
      showToastState(translate('home.WithdrawalApplication'));
    } else if (jsonResultCoin['code']==401) {
      showToastState(translate('home.LoginExpired'));
    } else {
      showToastState(jsonResultCoin['msg']);
    }

    setState(() {
    });
  }
  void showToastState(String msg) {
    showToast(msg,
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
    Navigator.pop(context);
  }
  void _textFieldChanged(String str) {
    setState(() {
      orderMoney = str;
    });

    print(str);
  }
  void _textFieldAddress(String str) {
    setState(() {
      addressWithdraw = str;
    });

    print(str);
  }
  void _textFieldPassword(String str) {
    setState(() {
      passwordString = str;
    });

    print(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.Withdrawal'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 580,
          color: Color(0xFFF3F6F8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        translate('home.Withdrawalmethod'),
                        style: TextStyle(
                            color: Color(0xFF989BA9),
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        height: 50,
                        width: 95,
                        margin: const EdgeInsets.only(
                            left: 0, right: 5, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            isSelectedBtc = true;
                            coinId = modelRecharge.data!.first.coinId!;
                            addressString = modelRecharge.data!.first.address;
                            feeMonry = modelRecharge.data!.first.fee!.toString();

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
                                widget.coinName.toString(),
                                style: TextStyle(
                                    color: (isSelectedBtc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ) ,
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 15),
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        translate('home.WithdrawTokens'),
                        style: TextStyle(
                            color: Color(0xFF989BA9),
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(left: 15,top: 0,right: 1,bottom: 1),
                    width: 350,
                    height: 50,
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(26.0)),
                    ),
                    child: (loginType == 1) ? Text(UserSharedPreferences.getPrivateAddress().toString(), style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w900)) : TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 10),
                      ),
                      onChanged: _textFieldAddress,
                      autofocus: false,
                    )
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        translate('home.WithdrawAmount'),
                        style: TextStyle(
                            color: Color(0xFF989BA9),
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),

                  ],
                ),
                Container(
                    width: 350,
                    height: 54,
                    margin: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 1),
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: (inputBool == true) ? TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 10),
                            ),
                            onChanged: _textFieldChanged,
                            autofocus: false,
                          ) : GestureDetector(
                            child: Text(usdtMoney.toString(),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w900),),
                            onTap: (){
                              inputBool = true;
                              setState(() {
                              });
                            },
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(0),
                            width: 78,
                            child: ElevatedButton(
                                child: Text(translate('home.Maximum'),style: TextStyle(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w900),),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        ColorConstants.AppCoinbaseBlueColor
                                    ),
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                    shape:
                                    MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(37.5),
                                        ))
                                ),
                                onPressed: () {
                                  inputBool = false;
                                  setState(() {
                                  });
                                })
                        )
                      ],
                    )
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: RichText(
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: translate('home.Handling')+": ",
                                  style: TextStyle(color: Color(0xFF989BA9),fontSize: 14,fontWeight: FontWeight.w300)
                              ),
                              TextSpan(
                                  text: ("${feeMonry}" ) + " %",
                                  style: TextStyle(color: Color(0xFF3B3E4E),fontSize: 14,fontWeight: FontWeight.w300)
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        translate('home.Transaction'),
                        style: TextStyle(
                            color: Color(0xFF989BA9),
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                    width: 350,
                    height: 54,
                    margin: EdgeInsets.only(left: 15,top: 0,right: 15,bottom: 1),
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 200,
                          child: (inputBool == true) ? TextField(
                            controller: _controllerTextEdit,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: _node,
                            maxLength: 16,
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey),
                            decoration: InputDecoration(
                              hintText: translate('home.Password'),
                              counterText: "",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            obscureText: true,
                            inputFormatters: [

                            ],
                            onChanged: _textFieldPassword,
                            autofocus: false,
                          ) : GestureDetector(
                            child: Text(usdtMoney.toString(),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w900),),
                            onTap: (){
                              inputBool = true;
                              setState(() {
                              });
                            },
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 50,
                        width: 280,
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, top: 12, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            withdrawCoinRequest();
                            setState(() {
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25)),
                            ),
                            color: ColorConstants.AppCoinbaseBlueColor,
                            child: Center(
                              child: Text(
                                translate('home.Extract'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Models/position_details_model.dart';
import 'package:flutter_bourse/Pages/account_register_page.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/update_password_page.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/jh_encrypt_utils.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var dataArr;

class AccountLoginPage extends StatefulWidget {
  const AccountLoginPage({Key? key}) : super(key: key);

  @override
  State<AccountLoginPage> createState() => _AccountLoginPageState();
}

class _AccountLoginPageState extends State<AccountLoginPage> {

  var listRows = <HistoryRecords?>[];
  var holdingRows = <Records?>[];

  int _count = 1;
  late HistoryOrderModel modelOrder = HistoryOrderModel();
  late PositionDetailsModel modelPosition = PositionDetailsModel();
  int? orderStatus = 1;
  var emailCode = "";
  late EasyRefreshController _controller;
  var verificationString = '';
  var codeImage = "";
  var uuidString = "";
  var passwordString = "";
  TextEditingController _controllerTextEdit = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    codeImageApi();
  }
  void codeImageApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/captchaImage');

    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json"});
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      // apiResult = HomeModel.fromJson(jsonResult);
      codeImage = jsonResult['img'];
      uuidString = jsonResult['uuid'];
      setState(() {
      });

    } else {
      showToast("无网络");
    }

  }
  void sendCodeApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/sendEmail');
    Map data = {'email':emailCode};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",
        "lang":UserSharedPreferences.getPrivateLang().toString()
        },body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 0) {
      // apiResult = HomeModel.fromJson(jsonResult);

      setState(() {
      });

    } else {
      showToast("无网络");
    }

  }
  void loginApi() async {

    var encrypted = JhEncryptUtils.aesEncrypt(passwordString);
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/ulogin');
    Map data = {'username':emailCode,"code":verificationString,"password":encrypted,"uuid":uuidString};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json","lang":UserSharedPreferences.getPrivateLang().toString()},body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      UserSharedPreferences.setPrivateToken(jsonResult['token']);
      setLoginType(2);
      UserSharedPreferences.setUserName(emailCode);
      showToast(translate('home.SuccessLogin'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);

      setState(() {
      });

      Reload();
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

  }
  setLoginType(int privateLanuage) async {
    // Obtain shared preferences.
    setState(() async {

      UserSharedPreferences.setLoginType(privateLanuage);

    });
  }

  void loadUserInfoApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/getUserInfo');

    final res = await http.get(tokenurl,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}', "lang":UserSharedPreferences.getPrivateLang().toString()});
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      UserSharedPreferences.setPrivateToken(jsonResult['token']);
      // apiResult = HomeModel.fromJson(jsonResult);
      showToast(translate('home.SuccessLogin'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);

      setState(() {
      });
      Reload();
    } else {

      showToast(translate('home.NetworkTip'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);
    }
  }
  Reload() async {
    // Obtain shared preferences.
    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      setState(() {
        Phoenix.rebirth(context);
      });
    });
  }



  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  /// -----------

  void _textFieldAccount(String str) {
    setState(() {
      emailCode = str;
    });

    print(str);
  }
  void _textFieldPassword(String str) {
    setState(() {
      passwordString = str;
    });

    print(str);
  }
  void _textFieldVerificationPassword(String str) {
    setState(() {
      // orderMoney = str;
      verificationString = str;
    });

    print(str);
  }

  late bool clickState = true;
  late bool clickHistoryState = true;

  @override
  Widget build(BuildContext contexHistory) {
    return GetBuilder(
        init: TransactionHistoryController(),
        builder: (TransactionHistoryController controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xFFF3F6F8),
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black87),
              elevation: 0,
              title: Text(
                translate('home.AccountLogin'),
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.center,
              ),
            ),
            body: Column(
              children: [

                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.Account'),
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  height: 54,
                  margin: EdgeInsets.only(left: 24,top: 10,right: 24,bottom: 1),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 20),
                        hintText: translate('home.Account')
                    ),
                    onChanged: _textFieldAccount,
                    autofocus: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.password'),
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  height: 54,
                  margin: EdgeInsets.only(left: 24,top: 10,right: 24,bottom: 1),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),

                  ),
                  child: TextField(
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
                      // WhitelistingTextInputFormatter(
                      //     RegExp("[^\u4e00-\u9fa5]")),
                      // LengthLimitingTextInputFormatter(16),
                    ],
                    onChanged: _textFieldPassword,
                    autofocus: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.PasswordCode'),
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 54,
                    margin: EdgeInsets.only(left: 24,right: 24),
                    padding: EdgeInsets.only(left: 5,right: 10,top: 5,bottom: 5),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                    ),
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 54,
                          padding: EdgeInsets.only(left: 15),
                          child:  TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10),
                                hintText: translate('home.PasswordCode')
                            ),
                            onChanged: _textFieldVerificationPassword,
                            autofocus: false,
                          ),
                        ),
                        (codeImage != "") ? Container(
                          padding: EdgeInsets.only(top: 0,bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  margin: EdgeInsets.only(right: 10),

                                  child: Image.memory(base64Decode(codeImage),width: 120,fit: BoxFit.fill,gaplessPlayback: true,),
                                ),
                                onTap: () {
                                  codeImageApi();
                                },
                              ),

                            ],
                          ),
                        )  : Container(),
                      ],
                    )
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(
                      left: 24, right: 24, top: 42),
                  child: GestureDetector(
                    onTap: () {
                      loginApi();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      ),
                      color: ColorConstants.AppCoinbaseBlueColor,
                      child: Center(
                        child: Text(
                          // translate('home.TradeNow'),
                          translate('home.Login'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      left: 24, right: 24, top: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountRegisterPage()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                      ),
                      child: Center(
                        child: Text(
                          translate('home.Register'),
                          style: TextStyle(
                              color: ColorConstants.AppCoinbaseBlueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdatePasswordPage()),
                    );
                  },

                  child:  Container(
                    height: 60,
                    width: 70,
                    margin: const EdgeInsets.only(
                        left: 24, right: 24, top: 12),
                    child: Text(
                      translate('home.ForgotPassword'),
                      style: TextStyle(
                          color: ColorConstants.AppCoinbaseBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),

              ],
            ),
            // body: ExampleScreen(),
          );
        });
  }
}

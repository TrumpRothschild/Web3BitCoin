import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:flutter_bourse/Models/history_order_model.dart';
import 'package:flutter_bourse/Models/position_details_model.dart';

import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/jh_encrypt_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

var dataArr;

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {

  int _count = 1;

  int? orderStatus = 1;
  late Timer _timer;
  int _countdownTime = 0;

  late EasyRefreshController _controller;
  var passwordString = "";
  var accountString = "";
  var confirmString = "";
  var emailString = "";
  var emailCode = "";
  TextEditingController _controllerTextEdit = TextEditingController();
  FocusNode _node = FocusNode();
  TextEditingController textEditController = TextEditingController();
  FocusNode _nodeTextEdit = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();

  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }
  void sendCodeApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/email/sendEmail');
    Map data = {'email':emailString};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: { 'Content-Type': 'application/json',
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()
        },body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {


      setState(() {
      });

    } else {

    }

  }

  void upadtePasswordApi() async {
    var encrypted = JhEncryptUtils.aesEncrypt(passwordString);
    var confirmPasswordEncrypted = JhEncryptUtils.aesEncrypt(confirmString);
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/forgetPwd');
    Map data = {'email':emailString,'password':encrypted,"confirmPassword":confirmPasswordEncrypted,'code':emailCode};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json',
          'lang':'zh_CN'},body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);

    if (jsonResult['code'] == 200) {
      showToast(translate('home.UpdateSuccess'),
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear);

      Navigator.pop(context);

      setState(() {
      });

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

  void _textFieldChanged(String str) {
    setState(() {
      emailString = str;
    });
    print(str);
  }
  void _textFieldPassword(String str) {
    setState(() {
      passwordString = str;
    });

    print(str);
  }
  void _textFieldConfirmPassword(String str) {
    setState(() {
      confirmString = str;
    });

    print(str);
  }
  void _textFieldEmail(String str) {
    setState(() {
      emailCode = str;
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
            backgroundColor: Color(0xFFF3F6F8),
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black87),
              elevation: 0,
              title: Text(
                translate('home.ForgotPassword'),
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.center,
              ),
            ),
            body: Column(
              children: [

                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.Password')+"*",
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  height: 54,
                  margin: EdgeInsets.only(left: 24,top: 10,right: 24),
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
                  padding: EdgeInsets.only(left: 24,top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.ConfirmNewPassword')+"*",
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.only(left: 24,top: 10,right: 24),
                  height: 54,
                  margin: EdgeInsets.only(left: 24,top: 10,right: 24),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                  ),
                  child: TextField(
                    controller: textEditController,
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _nodeTextEdit,
                    maxLength: 16,
                    style: TextStyle(
                        fontSize: 18, color: Colors.grey),
                    decoration: InputDecoration(
                      hintText: translate('home.ConfirmNewPassword'),
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
                    onChanged: _textFieldConfirmPassword,
                    autofocus: false,
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 24,top: 20,right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.AccountEmail'),
                        style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: EdgeInsets.only(left: 24,right: 24,),
                  height: 54,
                  margin: EdgeInsets.only(left: 24,right: 24),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 5),
                        hintText: translate('home.AccountEmail')
                    ),
                    onChanged: _textFieldChanged,
                    autofocus: false,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                Container(
                    height: 54,
                    margin: EdgeInsets.only(left: 24,right: 24),
                    padding: EdgeInsets.all(15),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                      border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                    ),
                    child: Stack(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(

                          height: 54,
                          child:  TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(bottom: 10),
                                hintText: translate('home.SMS')
                            ),
                            onChanged: _textFieldEmail,
                            autofocus: false,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(right: 2),
                                  margin: EdgeInsets.only(right: 2),
                                  width: 138,
                                  height: 35,
                                  child: ElevatedButton(
                                      child: Text(( _countdownTime > 0) ? '($_countdownTime)'+ translate('home.NewSend') : translate('home.SendCode'),style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w900),),
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
                                        sendCodeApi();
                                        if (_countdownTime == 0) {

                                          //Http请求发送验证码
                                          setState(() {
                                            _countdownTime = 60;
                                          });
                                          //开始倒计时
                                          startCountdownTimer();

                                        }
                                      })
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  height: 60,
                  margin: const EdgeInsets.only(
                      left: 24, right: 24, top: 42),
                  child: GestureDetector(
                    onTap: () {
                      upadtePasswordApi();
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
                          translate('home.updateConfirm'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
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

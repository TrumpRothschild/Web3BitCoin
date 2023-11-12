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

class AccountRegisterPage extends StatefulWidget {
  const AccountRegisterPage({Key? key}) : super(key: key);

  @override
  State<AccountRegisterPage> createState() => _AccountRegisterPageState();
}

class _AccountRegisterPageState extends State<AccountRegisterPage> {

  var listRows = <HistoryRecords?>[];
  var holdingRows = <Records?>[];

  int _count = 1;
  late HistoryOrderModel modelOrder = HistoryOrderModel();
  late PositionDetailsModel modelPosition = PositionDetailsModel();
  int? orderStatus = 1;
  late Timer _timer;
  int _countdownTime = 0;
  var emailCode = "";
  var passwordString = "";
  var accountString = "";
  var confirmString = "";
  var emailString = "";
  var verificationString = '';
  var codeImage = "";
  var uuidString = "";
  late EasyRefreshController _controller;
  TextEditingController _controllerTextEdit = TextEditingController();
  FocusNode _node = FocusNode();
  TextEditingController textEditController = TextEditingController();
  FocusNode _nodeTextEdit = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    codeImageApi();
  }
  void sendEmailApi() async {
    var encrypted = JhEncryptUtils.aesEncrypt(passwordString);
    var confirmPasswordEncrypted = JhEncryptUtils.aesEncrypt(confirmString);
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/uregister');
    Map data = {"username":accountString,'email':emailString,'password':encrypted,"confirmPassword":confirmPasswordEncrypted,'code':verificationString,"emailCode":emailCode,"uuid":uuidString};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()},body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);

    if (jsonResult['code'] == 200) {

      showToast(translate('home.RegistrationSuccess'),
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
  void sendCodeApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/email/sendEmail');
    Map data = {'email':emailString};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: { 'Content-Type': 'application/json',
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()},body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {


      setState(() {
      });

    } else {

    }

  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    codeImageApi();
  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
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
  void _textFieldToEmail(String str) {
    setState(() {
      emailString = str;
    });

    print(str);
  }
  void _textFieldAccount(String str) {
    setState(() {
      accountString = str;
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
  void codeImageApi() async {
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/captchaImage');
    final res = await http.get(tokenurl,
        headers: {'Content-Type': 'application/json',
          'Accept': 'application/json',
          "lang":UserSharedPreferences.getPrivateLang().toString()
    });
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {

      codeImage = jsonResult['img'];
      uuidString = jsonResult['uuid'];
      setState(() {
      });

    } else {

    }
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
                translate('home.Register'),
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),textAlign: TextAlign.center,
              ),
            ),
            body: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 24,top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translate('home.Account')+"*",
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
                    onChanged: _textFieldToEmail,
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
                        (codeImage != '') ? Container(
                          padding: EdgeInsets.only(top: 0,bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.only(right: 2),
                                  margin: EdgeInsets.only(right: 2),

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
                      sendEmailApi();
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30)),
                      ),
                      color: ColorConstants.AppCoinbaseBlueColor,
                      child: Center(
                        child: Text(
                          translate('home.Register'),
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
                      left: 24, right: 24, top: 12,bottom: 80),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        border: new Border.all(width: 1, color: ColorConstants.AppCoinbaseBlueColor),
                      ),
                      child: Center(
                        child: Text(
                          translate('home.Login'),
                          style: TextStyle(
                              color: ColorConstants.AppCoinbaseBlueColor,
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

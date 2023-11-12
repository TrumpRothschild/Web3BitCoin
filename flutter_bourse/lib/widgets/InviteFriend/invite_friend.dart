
import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';


class InviteFriend extends StatefulWidget {
  const InviteFriend({Key? key}) : super(key: key);

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {

  String inviteCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    inviteCodeNetwork();
  }
  void inviteCodeNetwork() async {

    String url3 = "${APIs.apiPrefix}${APIs.inviteCodeApi}";

    Uri wakuangApi = Uri.parse(url3);
    final resCoin = await http.post(wakuangApi, headers: {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}'
    });

    final Map<String, dynamic> jsonResultCoin = jsonDecode(resCoin.body);
    inviteCode = jsonResultCoin['data']['inviteCode'];
    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFFF3F6F8),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black87),
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                translate('home.InviteFriends'),
                style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15,top: 15),

                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translate('home.ShareFriend'),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  width: 1000,
                  child: Image.asset('assets/images/invite.jpeg',fit: BoxFit.cover,),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              translate('home.MyShare'),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "http://5.181.27.168:6101"+"?"+"yCode="+inviteCode,style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),
                            ),
                            padding: EdgeInsets.only(right: 10),
                            width: 200,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 70,
                            height: 30,
                            child: ElevatedButton(
                                child: Text(translate('home.Copy'),
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900)),
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
                                          borderRadius: BorderRadius.circular(6),
                                        ))),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: 'http://5.181.27.168:6101?yCode=${inviteCode}'));
                                  showToast(translate('home.CopySuccess'),
                                      context: context,
                                      animation: StyledToastAnimation.scale,
                                      reverseAnimation: StyledToastAnimation.fade,
                                      position: StyledToastPosition.center,
                                      animDuration: Duration(seconds: 1),
                                      duration: Duration(seconds: 4),
                                      curve: Curves.elasticOut,
                                      reverseCurve: Curves.linear);
                                }),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(0),
                        height: 115,
                        width: 115,
                        color: ColorConstants.AppBlueColor,
                        child: QrImage(data: "http://5.181.27.168:6101"+"?"+"yCode="+inviteCode,size: 100,backgroundColor: Colors.white,),

                        // child: Image.qasset('assets/images/liantu.png',fit: BoxFit.cover,width: 100,height: 100,),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: Text(translate('home.DescribeContent'),style: TextStyle(color: Colors.black,fontSize: 12),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // body: ExampleScreen(),
          );
  }
}

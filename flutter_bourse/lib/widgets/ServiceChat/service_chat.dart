import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class ServiceChat extends StatefulWidget {
  const ServiceChat({Key? key}) : super(key: key);

  @override
  State<ServiceChat> createState() => _ServiceChatState();
}

class _ServiceChatState extends State<ServiceChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0,
        title: Text(
          translate('home.Service'),
          style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),
        ),
      ),

      body: Container(
        padding: EdgeInsets.only(left: 13,top: 13,right: 13),
        margin: EdgeInsets.only(left: 13,top: 13,right: 13),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    translate('home.OnlineService'),
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "WhatsApp:",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "+44 73282912",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Telegram:",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "+1 63764276",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Fackbook:",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                ),
                Container(
                  child: Text(
                    "sdhasdh@gmail.com",
                    style: TextStyle(color: Colors.black,fontSize: 15),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      // body: ExampleScreen(),
    );
  }
}

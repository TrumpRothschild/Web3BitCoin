import 'package:flutter/material.dart';
import 'package:flutter_bourse/utils/utils.dart';

class PlatformDetail extends StatefulWidget {
  final String data;
  final String content;
  const PlatformDetail({Key? key, required this.data,required this.content}) : super(key: key);

  @override
  State<PlatformDetail> createState() => _PlatformDetailState();
}

class _PlatformDetailState extends State<PlatformDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          translate('home.PlatformDetails'),
          style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  width: 1000,
                  height: 125,
                  child: Image.asset('assets/images/bulletin.png',fit: BoxFit.fill,),
                ),
                Container(
                  // padding: EdgeInsets.only(left: 15,top: 50),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 15,left: 15),
                        child: Text("歡迎使用幫助中心                  ",style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,fontWeight: FontWeight.w900
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15,left: 15),
                        child: Text("搜索我們的知識庫存，了解更多平台資訊",style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        ),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(25),
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(

                  child: Text(widget.data,style: TextStyle(color: Colors.black,fontSize: 16),),
                  padding: EdgeInsets.all(15),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                   child: Text(widget.content,style: TextStyle(color: Colors.black,fontSize: 16),),
                )
              ],
            ),
          )
        ],
      ),
      // body: ExampleScreen(),
    );
  }
}

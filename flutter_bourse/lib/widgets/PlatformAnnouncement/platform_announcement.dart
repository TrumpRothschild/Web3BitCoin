import 'package:flutter/material.dart';
import 'package:flutter_bourse/widgets/PlatformAnnouncement/platform_detail.dart';
import 'package:flutter_translate/flutter_translate.dart';

class PlatformAnnouncement extends StatefulWidget {
  const PlatformAnnouncement({Key? key}) : super(key: key);

  @override
  State<PlatformAnnouncement> createState() => _PlatformAnnouncementState();
}

class _PlatformAnnouncementState extends State<PlatformAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          translate('home.PlatformAnnouncement'),
          style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
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
                        child: Text(translate('home.Welcome'),style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,fontWeight: FontWeight.w900
                        ),),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15,left: 15),
                        child: Text(translate('home.Search'),style: TextStyle(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(translate('home.CommonProblem'),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w800),),
                  padding: EdgeInsets.only(left: 25),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(20),
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.QiHuoExchange'),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlatformDetail(
                              data:translate('home.QiHuoExchange'),
                              content: translate('home.QiHuoExchangeConent'),
                            )),
                      );
                  },
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.Anquan'),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlatformDetail(
                            data:translate('home.Anquan'),
                            content: translate('home.AnquanConent'),
                          )),
                    );
                  },
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.CenterExchange'),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlatformDetail(
                            data:translate('home.CenterExchange'),
                            content: translate('home.CenterExchangeConent'),
                          )),
                    );
                  },
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.WanquanBlock'),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlatformDetail(
                            data:translate('home.WanquanBlock'),
                            content: translate('home.WanquanBlockConent'),
                          )),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      // body: ExampleScreen(),
    );
  }
}

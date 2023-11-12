import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/ActingModel/miningRecords_model.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class infiniteAutoScroll extends StatefulWidget {
  infiniteAutoScroll({Key? key}) : super(key: key);

  @override
  State<infiniteAutoScroll> createState() => _infiniteCarouselState();
}

class _infiniteCarouselState extends State<infiniteAutoScroll> {
  late Timer _timer;
  double offset = 0;
  late InfiniteScrollController controller;
  MiningRecordsModel? miningRecordsModel;
  var itemCount = 0;
  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
    _timer = Timer.periodic(Duration(milliseconds: 2500), (Timer timer) {
      //  counter = selectedIndex + 1;
      selectedIndex++;
      offset = offset + 100;
      if (controller.hasClients) {
        controller.animateTo(offset,
            duration: Duration(milliseconds: 2500), curve: Curves.linear);
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {   // 页面销毁时触发定时器销毁
      if (_timer.isActive) {  // 判断定时器是否是激活状态
        _timer.cancel();
      }
    }
    controller.dispose();
  }

  int selectedIndex = 0;

  final _imageUrls = [
    "0xbc459f7099b28a0ca7e86ad073233c12318fc49529fc26384bf810343bb1552e ",
    "assets/images/banner2.png",
  ];

  List<User> class1 = [
    User("0xbc459f7099b28a0ca7e86ad073233c12318fc49529fc26384bf810343bb1552e",
        "0.007 BTC"),
    User("0x013c5c4b34be89813c94105ed21bf503f922a687303ffc6b47b2c7a8a5329892",
        "600 Doge"),
    User("0xbaddab28a0ca7e86ad073233c12318fc49529fc26384bf810343bb1552e",
        "100 USDT"),
    User("0x013c5c4b34be89813c94105ed21bf503f922a687303ffc6b47b2c7a8a5329892",
        "1.04 LTC"),
    User("0xbee59f7099b28a0ca7e86ad073233c12318fc49529fc26384bf810343bb1552e",
        "800.2 RAD"),
    User("0x013c5c4b34be89813c94105ed21bf503f922a687303ffc6b47b2c7a8a5329892",
        "587.8 KDA"),
    User("0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5", "0.093 ETH"),
    User("0x690b9a9e9aa1c9db991c7721a92d351db4fac990", "800 Doge"),
    User("0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5", "0.057 BTC"),
    User("0x388c818ca8b9251b393131c08a736a67ccb19297", "700.7 RAD"),
    User("0xf2f5c73fa04406b1995e397b55c24ab1f3ea726c", "600.07 KDA"),
    User("0x95222290dd7278aa3ddd389cc1e1d165cc4bafe5", "600 Doge"),
    User("0xdafea492d9c6733ae3d56b7ed1adb60692c98bc5", "750 Doge"),
    User("0xeee27662c2b8eba3cd936a23f039f3189633e4c8", "600.1 RAD"),
    User("0x47b3dad36111f4ea1246376db9ebaf56533cce0f", "300.03 RAD"),
    User("0x495f947276749ce646f68ac8c248420045cb7b5e", "0.187 ETH"),
  ];
  @override
  Widget build(BuildContext context) {


    return Container(
        height: 400,
        width: 80,
        child: ClipRRect(
          //    borderRadius: BorderRadius.circular(24),
          child: InfiniteCarousel.builder(
            itemCount: class1.length,
            itemExtent: 36,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                // Allows to swipe in web browsers
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              },
            ),
            center: false,
            anchor: 0.0,
            //velocityFactor: 0.2,
            onIndexChanged: (index) {},
            controller: controller,
            axisDirection: Axis.vertical,
            loop: true,
            itemBuilder: (context, itemIndex, realIndex) {
              String userNameString = "";
              // if (miningRecordsModel?.data?.records?[itemIndex].userName != "") {
              //   String? userName = miningRecordsModel?.data?.records?[itemIndex].userName;
                userNameString = class1[itemIndex].name.substring(class1[itemIndex].name.length-3);
              // }
              return Container(
                height: 30,
                padding: EdgeInsets.all(0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 2,
                          child: Container(
                            width: 120,
                            height: 16,
                            child: Text(
                              class1[itemIndex].name+"..."+userNameString,
                              //   "${miningRecordsModel?.data?.records?[itemIndex].userName}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                          )
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: 16,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: 200,
                            height: 15,
                            child: Text(
                                class1[itemIndex].address,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500)),
                          )
                ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class User {
  String name, address;
  User(this.name, this.address);
}

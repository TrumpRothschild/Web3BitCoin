import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class ourStrengthCarousalWidget extends StatefulWidget {
  ourStrengthCarousalWidget({Key? key}) : super(key: key);

  @override
  State<ourStrengthCarousalWidget> createState() => _ourStrengthCarousalState();
}

class _ourStrengthCarousalState extends State<ourStrengthCarousalWidget> {

  List<Advantages> advantages = [];

  late Timer _timer;
  double offset = 0;
  late InfiniteScrollController controller;
  @override
  void initState() {
    super.initState();
    advantages.clear();
    advantages.add(Advantages('assets/images/fire.png',
        // 'Save Gas',
        translate('home.SaveGas'),
        translate('home.UserCan')
    ));
    advantages.add(
        Advantages('assets/images/secure.png',
        translate('home.Security'),
        translate('home.Direct')
    ));
    advantages.add(Advantages('assets/images/fire.png', translate('home.Intiutive'),

        translate('home.ExperienceSpeed')
    ));
    advantages.add(Advantages('assets/images/threat.png', translate('home.Anonymity'),
        translate('home.Totally')
    )
    );
    controller = InfiniteScrollController();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      //  counter = selectedIndex + 1;
      selectedIndex++;
      offset = offset + 340;
      if (controller.hasClients) {
        controller.animateTo(offset,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // advantages.clear();
    // advantages.add(Advantages('assets/images/fire.png',
    //     // 'Save Gas',
    //     translate('home.SaveGas'),
    //     translate('home.UserCan')
    // ));
    // advantages.add(
    //     Advantages('assets/images/secure.png',
    //         translate('home.Security'),
    //         translate('home.Direct')
    //     ));
    // advantages.add(Advantages('assets/images/fire.png', translate('home.Intiutive'),
    //
    //     translate('home.ExperienceSpeed')
    // ));
    // advantages.add(Advantages('assets/images/threat.png', translate('home.Anonymity'),
    //     translate('home.Totally')
    // )
    // );
    return Container(
        height: 130,
        padding: EdgeInsets.all(0),
        child: Container(
          child: InfiniteCarousel.builder(
            itemCount: advantages.length,
            itemExtent: 340,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                // Allows to swipe in web browsers
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse
              },
            ),
            center: true,
            anchor: 0.0,
            velocityFactor: 0.5,
            onIndexChanged: (index) {},
            controller: controller,
            axisDirection: Axis.horizontal,
            loop: true,
            itemBuilder: (context, itemIndex, realIndex) {
              return advantageTileWidget(advantages[itemIndex]);
            },
          ),
        ));
  }

  Widget advantageTileWidget(Advantages ad) {
    return Container(
      child: Row(
        children: [
          // Image radius
          Expanded(
            child: Container(
              margin: EdgeInsets.all(6),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(
                                                16), // Image radius
                                            child: Image.asset(ad.imagePath,
                                                fit: BoxFit.contain),
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12.0),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          ad.title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    ad.description,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Advantages {
  String imagePath;
  String title;
  String description;
  Advantages(this.imagePath, this.title, this.description) {
    imagePath = this.imagePath;
    title = this.title;
    description = this.description;
  }
}

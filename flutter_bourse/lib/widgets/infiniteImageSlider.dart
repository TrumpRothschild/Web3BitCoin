import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

class infiniteCarousel extends StatefulWidget {
  infiniteCarousel({Key? key}) : super(key: key);

  @override
  State<infiniteCarousel> createState() => _infiniteCarouselState();
}

class _infiniteCarouselState extends State<infiniteCarousel> {
  late Timer _timer;
  double offset = 0;
  late InfiniteScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
     
      selectedIndex++;
      offset = offset + 340;
      if (controller.hasClients) {
        controller.animateTo(offset,
            duration: Duration(milliseconds: 100), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  int selectedIndex = 0;

  final _imageUrls = [
    "assets/images/banner1.png",
    "assets/images/banner2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 340,
        child: ClipRRect(
          child: InfiniteCarousel.builder(
            itemCount: _imageUrls.length,
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
            velocityFactor: 1,
            onIndexChanged: (index) {},
            controller: controller,
            axisDirection: Axis.horizontal,
            loop: true,
            itemBuilder: (context, itemIndex, realIndex) {
              return Container(
                height: 100,
                margin: EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    _imageUrls[itemIndex],
                    scale: 2.2,
                  ),
                ),
              );
            },
          ),
        ));
  }
}

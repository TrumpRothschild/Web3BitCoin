import 'dart:async';

import 'package:flutter/material.dart';

class ImageSliderWidget extends StatefulWidget {
  ImageSliderWidget({Key? key}) : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  int activePage = 1;
  int _currentPage = 0;
  late Timer _timer;

  bool _isSearchValid = false;
  bool _isPasswordValid = false;

  bool _isHidePassword = false;
  bool _isLogin = false;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  final _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  final _imageUrls = [
    "assets/images/banner1.png",
    "assets/images/banner2.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 64,
          child: PageView.builder(
              itemCount: _imageUrls.length,
              pageSnapping: false,
              controller: _pageController,
              onPageChanged: (_currentPage) {
                setState(() {
                  activePage = _currentPage;
                });
              },
              itemBuilder: (context, pagePosition) {
                return
                    /*   Container(
                  height: 60,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      scale: 0.8,
                      image: AssetImage(_imageUrls[pagePosition]),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ); */

                    Container(
                  margin: EdgeInsets.only(left: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _imageUrls[pagePosition],
                      scale: 1.2,
                    ),
                  ),
                );
              }),
        ),
        /*  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(_imageUrls.length, activePage)), */
      ],
    );
  }
}

import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/fitness_app/home.png',
      selectedImagePath: 'assets/fitness_app/home.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/bank.png',
      selectedImagePath: 'assets/fitness_app/bank.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/mining.png',
      selectedImagePath: 'assets/fitness_app/mining.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/trade.png',
      selectedImagePath: 'assets/fitness_app/trade.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/fitness_app/history.png',
      selectedImagePath: 'assets/fitness_app/history.png',
      index: 4,
      isSelected: false,
      animationController: null,
    ),
  ];
}

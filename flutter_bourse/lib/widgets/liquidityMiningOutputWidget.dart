import 'package:flutter/material.dart';

import 'package:flutter_bourse/TestWidgets/autoScroll.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../Pages/colors.dart';

class LiquidityMiningOutputWidget extends StatefulWidget {
  LiquidityMiningOutputWidget({Key? key}) : super(key: key);

  @override
  State<LiquidityMiningOutputWidget> createState() =>
      _LiquidityMiningOutputWidgetState();
}

class _LiquidityMiningOutputWidgetState
    extends State<LiquidityMiningOutputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: const BoxDecoration(
              color: ColorConstants.AppBlueColor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(0),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(0))),
          child: Row(
            children: [
              ClipRect(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(12), // Image radius
                  child:
                      Image.asset('assets/images/eth.png', fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                width: 12,
              ),
               Text(
                translate('home.MiningOutput'),
                maxLines: 1,
                style: TextStyle(
                    fontSize: 24,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0),
                  bottomRight: const Radius.circular(12),
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(12))),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('home.Address'),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45)),
                  Text(translate('home.Count'),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45)),
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 144,
                width: double.infinity,
                child: infiniteAutoScroll(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

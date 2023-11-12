import 'dart:async';

import 'package:countup/countup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/trade.dart';
import '../helpers/checkInternetConnectivity.dart';

class GridViewBuilder extends StatefulWidget {
  GridViewBuilder({Key? key}) : super(key: key);

  @override
  State<GridViewBuilder> createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  ScrollController _scrollController = ScrollController();
  int skip = 0;
  bool shouldLoadMore = true;
  int currentPos = 0;

  @override
  void initState() {
    super.initState();

    double offset = 0;
    Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      //  counter = selectedIndex + 1;
      TradeDataModel.tradeDataList.length;
      currentPos = currentPos + 4;

      offset = offset + 320;
      if (TradeDataModel.tradeDataList.length <= currentPos) {
        timer.cancel();
        offset = 0;
        _scrollController.animateTo(0,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
      } else if (_scrollController.hasClients) {
        _scrollController.animateTo(offset,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      //  margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: TradeDataModel.tradeDataList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          childAspectRatio: 1 / 2,
        ),
        itemBuilder: (context, index) {
          return GridTile(
              child: Container(
                  // color: Colors.blue[200],
                  alignment: Alignment.center,
                  child: getGrid(TradeDataModel.tradeDataList[index])));
        },
      ),
    );
  }
}

Widget getGrid(TradeData tradedata) {
  double percentage = double.tryParse(tradedata.rate)!;

  bool isNegative(double percentage) => percentage < 0 ? true : false;

  return Container(
    padding: EdgeInsets.only(
      left: 26,
      right: 10,
    ),
    //  color: Colors.black54,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: ClipRect(
            child: SizedBox.fromSize(
              size: Size.fromRadius(12), // Image radius
              child: Image.network(tradedata.url, fit: BoxFit.contain),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  tradedata.productName,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  tradedata.rate + '% ',
                  style: TextStyle(
                      fontSize: 12,
                      color: isNegative(double.tryParse(tradedata.rate)!)
                          ? Color.fromARGB(255, 223, 0, 0)
                          : Color.fromARGB(255, 0, 187, 125),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Countup(
                  begin: 0,
                  precision: 2,
                  end: double.tryParse(tradedata.high)!,
                  prefix: '\$',
                  duration: Duration(milliseconds: 1500),
                  separator: ',',
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/widgets/candleStickChartPage.dart';
import 'package:get/get.dart';
import '../widgets/KLineChartWidget.dart';

class TopBarTransaction extends StatefulWidget {
  TopBarTransaction({
    Key? key,
  }) : super(key: key);

  @override
  State<TopBarTransaction> createState() => _TopBarTransactionState();
}

class _TopBarTransactionState extends State<TopBarTransaction> {
  // Rx<innerData> selectedChainData =
  //   Get.find<Controller>().getSelectedChainObj();
  bool isNegative(double percentage) => percentage < 0 ? true : false;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Get.find<Controller>().getSelectedChainObj()().symbol!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<Controller>(
                      builder: (_) =>
                          !Get.find<Controller>().isChainLoadActive()
                              ? Text(
                                  //  Get.find<Controller>().currentPrice().toString(),
                                  Get.find<Controller>()
                                      .getSelectedChainObj()()
                                      .lastPrice
                                      .toString(),
                                  style: TextStyle(
                                      color: isNegative((double.tryParse(
                                              Get.find<Controller>()
                                                  .getSelectedChainObj()()
                                                  .priceChangePercent
                                                  .toString())!))
                                          ? Colors.red.shade800
                                          : Colors.green,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                )
                              : CupertinoActivityIndicator()),
                  SizedBox(
                    width: 8,
                  ),
                  GetBuilder<Controller>(builder: (_) {
                    return Text(
                      Get.find<Controller>()
                              .getSelectedChainObj()()
                              .priceChangePercent
                              .toString() +
                          '%',
                      style: TextStyle(
                          color: isNegative((double.tryParse(
                                  Get.find<Controller>()
                                      .getSelectedChainObj()()
                                      .priceChangePercent
                                      .toString())!))
                              ? Colors.red.shade800
                              : Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 10),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Container(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "24hr High",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    Get.find<Controller>()
                        .getSelectedChainObj()()
                        .highPrice
                        .toString(),
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "24hr Low",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    Get.find<Controller>()
                        .getSelectedChainObj()()
                        .lowPrice
                        .toString(),
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

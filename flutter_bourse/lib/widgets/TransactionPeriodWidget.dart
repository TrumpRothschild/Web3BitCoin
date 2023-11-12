import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bourse/Models/buyUtilsModel.dart';
import 'package:flutter_bourse/Models/transactionTimeRateModel.dart';
import 'package:flutter_bourse/Pages/colors.dart';

class TransactionPeriodWidget extends StatefulWidget {
  const TransactionPeriodWidget({Key? key, required this.refresh})
      : super(key: key);
  final Function refresh;

  @override
  State<TransactionPeriodWidget> createState() =>
      _TransactionPeriodWidgetState(refresh);
}

/// This is the private State class that goes with MyStatefulWidget.
class _TransactionPeriodWidgetState extends State<TransactionPeriodWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Function refresh;

  _TransactionPeriodWidgetState(this.refresh);

  int value = 0;
  Widget CustomRadioButton(String text, int index, double val, int seconds) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          width: 100,
          margin: EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                value = index;
                refresh(val, seconds);
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Transaction Period',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (value == index) ? Colors.black45 : Colors.black45,
                      fontWeight: FontWeight.w500,
                      fontSize: 10),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: (value == index)
                          ? ColorConstants.AppBlueColor
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Profit ${val * 100}%',
                  style: TextStyle(
                      color: ColorConstants.AppBlueColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(BorderSide(
                    width: (value == index) ? 1 : 0.6,
                    color: (value == index)
                        ? ColorConstants.AppBlueColor
                        : Colors.black38)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
                backgroundColor: (value == index)
                    ? MaterialStateProperty.all<Color>(
                        Color.fromARGB(33, 83, 94, 250))
                    : MaterialStateProperty.all<Color>(
                        ColorConstants.AppWhiteColor),
                overlayColor: MaterialStateProperty.all<Color>(Colors.white24)),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //  borderSide:
          //      BorderSide(color: (value == index) ? Colors.green : Colors.black),
        ),
        Container(
          margin: EdgeInsets.all(12),
          child: (value == index)
              ? Icon(
                  Icons.check,
                  color: ColorConstants.AppBlueColor,
                  size: 12,
                )
              : Text(''),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 2),
      height: 86,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < BuyUtilsModel.buyUtilsList.length; i++)
            CustomRadioButton(
                BuyUtilsModel.buyUtilsList[i].time!,
                i,
                BuyUtilsModel.buyUtilsList[i].profitRate!,
                transactionTimeRateModel.buyUtilsList[i].seconds!),
        ],
      ),
    );
  }
}

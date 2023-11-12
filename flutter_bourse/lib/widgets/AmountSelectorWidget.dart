import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bourse/Models/transactionTimeRateModel.dart';
import 'package:flutter_bourse/Pages/colors.dart';

import '../Models/buyUtilsModel.dart';

class AmountSelectorWidget extends StatefulWidget {
  const AmountSelectorWidget({Key? key, required this.refresh})
      : super(key: key);
  final Function refresh;

  @override
  State<AmountSelectorWidget> createState() =>
      _AmountSelectorWidgetState(refresh);
}

/// This is the private State class that goes with MyStatefulWidget.
class _AmountSelectorWidgetState extends State<AmountSelectorWidget> {
  Function refresh;
  _AmountSelectorWidgetState(this.refresh);

  int value = 0;
  Widget CustomRadioButton(int text, int index) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                value = index;
                refresh(text);
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text == 0 ? 'Input' : text.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: (value == index)
                          ? ColorConstants.AppBlueColor
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  margin: EdgeInsets.all(2),
                  child: (value == index)
                      ? Icon(
                          Icons.check,
                          color: ColorConstants.AppBlueColor,
                          size: 12,
                        )
                      : Text(' '),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 2),
      //  height: 36,
      child: Wrap(
        //  physics: const BouncingScrollPhysics(),
        //   scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < BuyUtilsModel.buyUtilsList.length; i++)
            CustomRadioButton(BuyUtilsModel.buyUtilsList[i].minAmount!, i),
          CustomRadioButton(0, BuyUtilsModel.buyUtilsList.length + 1),
        ],
      ),
    );
  }
}

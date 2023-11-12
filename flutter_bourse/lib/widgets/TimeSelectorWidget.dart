import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/colors.dart';

class TimeSelectorWidget extends StatefulWidget {
  const TimeSelectorWidget({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;

  @override
  State<TimeSelectorWidget> createState() => _TimeSelectorWidgetState(refresh);
}

/// This is the private State class that goes with MyStatefulWidget.
class _TimeSelectorWidgetState extends State<TimeSelectorWidget> {
  Function refresh;
  _TimeSelectorWidgetState(this.refresh);

  int value = 1;
  Widget CustomRadioButton(String text, int index, String val) {
    return Container(
      margin: EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
            refresh(val);
          });
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(BorderSide(
              width: 1,
              color: (value == index)
                  ? ColorConstants.AppCoinbaseBlueColor
                  : Colors.white)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
          backgroundColor: (value == index)
              ? MaterialStateProperty.all<Color>(ColorConstants.AppCoinbaseBlueColor)
              : MaterialStateProperty.all<Color>(Color(0xFFF3F6F8)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Colors.white : Colors.black38,
          ),
        ),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //  borderSide:
        //      BorderSide(color: (value == index) ? Colors.green : Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6),
      width: double.infinity,
      height: 36,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CustomRadioButton("1 Min", 1, "1m"),
          CustomRadioButton("30 Min", 2, "30m"),
          CustomRadioButton("1 Hour", 3, "1h"),
          CustomRadioButton("4 Hours", 4, "4h"),
          CustomRadioButton("1 Day", 5, "1d"),
          CustomRadioButton("1 Week", 6, "1w"),
          CustomRadioButton("1 Month", 7, "1M")
        ],
      ),
    );
  }
}

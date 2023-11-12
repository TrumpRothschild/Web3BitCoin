import 'package:flutter/material.dart';
import 'package:flutter_bourse/TestWidgets/cardSelectionTile.dart';

class CardSeclection extends StatefulWidget {
  CardSeclection({Key? key}) : super(key: key);

  @override
  State<CardSeclection> createState() => _CardSeclectionState();
}

class _CardSeclectionState extends State<CardSeclection> {
  int _value = 1;
  String cardType = '1 Min';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            MyCardSelectionTile<int>(
              value: 1,
              groupValue: _value,
              leading: '1 Min',
              // title: Text(
              //   'All the business related details',
              //   style: TextStyle(color: Colors.grey[600]!),
              //   textAlign: TextAlign.center,
              // ),
              onChanged: (value) => setState(() =>
                  {cardType = '1 Min', _value = value!, if (_value == 1) {}}),
            ),
            MyCardSelectionTile<int>(
                value: 2,
                groupValue: _value,
                leading: '30 Min',
                onChanged: (value) => {
                      setState(() => {cardType = '30 Min', _value = value!})
                    }),
            MyCardSelectionTile<int>(
                value: 3,
                groupValue: _value,
                leading: '1 Hour',
                onChanged: (value) => {
                      setState(() => {cardType = '1 Hour', _value = value!})
                    }),
            MyCardSelectionTile<int>(
                value: 4,
                groupValue: _value,
                leading: '4 Hours',
                onChanged: (value) => {
                      setState(() => {cardType = '4 Hours', _value = value!})
                    }),
            MyCardSelectionTile<int>(
                value: 5,
                groupValue: _value,
                leading: '1 Day',
                onChanged: (value) => {
                      setState(() => {cardType = '1 Day', _value = value!})
                    }),
            MyCardSelectionTile<int>(
                value: 6,
                groupValue: _value,
                leading: '1 Week',
                onChanged: (value) => {
                      setState(() => {cardType = '1 Week', _value = value!})
                    }),
            MyCardSelectionTile<int>(
                value: 7,
                groupValue: _value,
                leading: '1 Month',
                onChanged: (value) => {
                      setState(() => {cardType = '1 Month', _value = value!})
                    }),
          ],
        ),
      ),
    );
  }
}

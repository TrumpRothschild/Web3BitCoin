import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/records_model.dart';
import 'package:flutter_bourse/utils/utils.dart';

class WithdrawHistoryList extends StatelessWidget {

  final int index;

  final Records recordsModel;
  const WithdrawHistoryList({
    Key? key,
    required this.index,
    required this.recordsModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stateString = "";
    if (recordsModel.status == 2) {
      stateString = translate('home.ApplicationFailed');
    } else if (recordsModel.status == 1) {
      stateString = translate('home.ApplicationProcessing');
    } else {
      stateString = translate('home.SuccessfulApplication');
    }
    LogUtil.e("提现状态${stateString}");
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 0),
            child: Text(
              (recordsModel.createTime != null) ? recordsModel.createTime! : "0",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 40),
            child: Text(
              stateString,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
          ),

          Container(
            child: Text(
              (recordsModel.amount == null) ? "0" : "${recordsModel.amount}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

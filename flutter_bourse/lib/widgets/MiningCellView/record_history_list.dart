import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/records_model.dart';

class RecordHistoryList extends StatelessWidget {

  final int index;
  final Records recordsModel;
  const RecordHistoryList({
    Key? key,
    required this.index,
    required this.recordsModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              (recordsModel.createTime != null) ? "${recordsModel.createTime!}" : "0",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              (recordsModel.usdtAmonut == null) ? "0" : recordsModel.usdtAmonut.toString(),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

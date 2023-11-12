import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/MiningModel/records_model.dart';

class MiningHistoryList extends StatelessWidget {

  final int index;
  final Records recordsModel;
  const MiningHistoryList({
    Key? key,
    required this.index,
    required this.recordsModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              (recordsModel.createTime != null) ? recordsModel.createTime! : "0",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 14),
            ),
          ),
          Container(

            child: Text(
          (recordsModel.balance == null) ? "0" : recordsModel.balance.toString(),
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

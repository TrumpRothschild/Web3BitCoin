import 'package:flutter/material.dart';

class TransactionDemo extends StatefulWidget {
  const TransactionDemo({Key? key}) : super(key: key);

  @override
  State<TransactionDemo> createState() => _TransactionDemoState();
}

class _TransactionDemoState extends State<TransactionDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: 100,
      height: 100,
      margin: EdgeInsets.all(15),
    );
  }
}

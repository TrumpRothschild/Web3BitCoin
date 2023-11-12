import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/widgets/UserCenter/generated/assets.dart';

import 'package:flutter_bourse/widgets/UserCenter/utils/styles.dart';

// import 'package:provider/provider.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? callback;
  final Color color;
  final String money;

  final BuildContext context;
  final String imageString;

  const CustomListTile(
      {Key? key, required this.icon,
        required this.title,
        this.callback,
        required this.color,
        required this.money,
        required this.imageString,
        required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      leading: Container(
        width: 45,
        height: 45,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color(0xFFF3F6F8),
          shape: BoxShape.circle,
        ),
        child: Transform.scale(
          scale: 1,
          child: Image.network(imageString),
        ),
      ),
      minLeadingWidth: 50,
      horizontalTitleGap: 13,
      title: Text(title,
          style: TextStyle(fontSize: 15,
              color: Colors.black
          )),
      trailing: Text(money,
          style: TextStyle(fontSize: 15,
              color: Colors.black
          )),
      onTap: callback,
    );  }
}
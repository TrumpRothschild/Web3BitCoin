import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/colors.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  _MessageBoxState createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2, left: 36, right: 36, bottom: 2),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 4, left: 36, right: 36, bottom: 4),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'USDT',
                style: TextStyle(
                    color: Colors.white,
                    // backgroundColor: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ),
            width: MediaQuery.of(context).size.width * 0.4,
            height: 36,
            decoration: BoxDecoration(
                color: ColorConstants.AppBlueColor,
                borderRadius: BorderRadius.circular(35.0)),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -1.0, 0.0),
            child: ClipPath(
              clipper: MessageClipper(),
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width * 0.4,
                color: ColorConstants.AppBlueColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var firstOffset = Offset(size.width * 0.1, 0.0);
    var secondPoint = Offset(size.width * 0.15, size.height * 0.6);
    var lastPoint = Offset(size.width * 0.2, 0.0);
    var path = Path()
      ..moveTo(firstOffset.dx, firstOffset.dy)
      ..lineTo(secondPoint.dx, secondPoint.dy)
      ..lineTo(lastPoint.dx, lastPoint.dy)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

import 'package:flutter/material.dart';

enum ObdjImagePossition { left, right, top, bottom }

class JCImageButton extends StatelessWidget {

  final String imageAssets;
  final String titleString;
  final Color bgColor;
  final double imageSize;
  final double cornerRadius;
  final double interval;
  final Color titleColor;
  final double titleSize;
  final FontWeight fontweight;
  final ObdjImagePossition possiton;

  late final VoidCallback callBack;
  late final EdgeInsetsGeometry padding;

  JCImageButton(
      {
        // 背景颜色  圆角
        this.bgColor = Colors.blue,
        this.cornerRadius = 5,

        // 图片路劲  大小
        this.imageAssets = "",
        this.imageSize = 16,

        // 字体
        this.titleString = "",
        this.titleColor = Colors.white,
        this.titleSize = 16,
        this.fontweight = FontWeight.w400,

        // 文字和图片间隔、 padding
        this.interval = 8,
        EdgeInsetsGeometry? padding,

        // 位置 回调
        this.possiton = ObdjImagePossition.left,
        VoidCallback? callBack, // 回调

      }) {
    this.padding = padding ?? EdgeInsets.fromLTRB(72, 8, 72, 8);
    this.callBack = callBack ??
            () {
          print("默认回调");
        };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: this.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.cornerRadius),
        color: this.bgColor,
      ),
      child: TextButton(
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
          onPressed: () {
            this.callBack();
          },
          child:
          (this.possiton == ObdjImagePossition.top || this.possiton == ObdjImagePossition.bottom)
              ? _getTopAndBottomPosstionWidget(this.possiton == ObdjImagePossition.top)
              : _getLeftAndRightPosstionWidget(this.possiton == ObdjImagePossition.left)
      ),
    );
  }

  Widget _getTopAndBottomPosstionWidget(bool isTop) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isTop
            ?  [ _getImage(), Container(height: this.interval,), _getTitle()]
            : [  _getTitle(),  Container(height: this.interval,), _getImage()]
    );
  }

  Widget _getLeftAndRightPosstionWidget(bool isLeft) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: isLeft
            ?  [ _getImage(), SizedBox(width: this.interval), _getTitle()]
            : [  _getTitle(),  SizedBox(width: this.interval), _getImage()]
    );
  }

  Widget _getImage() {
    return Image.asset(
      '${this.imageAssets}',
      width: this.imageSize,
      height: this.imageSize,
    );
  }

  Widget _getTitle() {
    return Text(
      '${this.titleString}',
      style: TextStyle(
          color: this.titleColor,
          fontSize: this.titleSize,
          fontWeight: this.fontweight),
    );
  }
}


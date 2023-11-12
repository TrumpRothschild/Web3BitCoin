// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:universal_html/js.dart';

class LoadingProgress  {


  static ShowLoading(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) =>
        FutureProgressDialog(getFuture()),
    );
  }

  static showToastAlert(BuildContext context,String content) {
    showToast(content,
        context: context,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

 static Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 2));
      return 'Hello, Future Progress Dialog!';
    }
    );
  }

}

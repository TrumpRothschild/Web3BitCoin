import 'dart:async';
import 'package:flutter/material.dart';

/// 函数防抖
///
/// [func]: 要执行的方法
/// [milliseconds]: 要迟延的毫秒时间
Function throttle(
    Future Function() func
    ) {
  if (func == null) {
   return func;
  }
  bool enable = true;
  Function target = () {
    if (enable == true) {
      enable == false;
      func().then((_) {
        enable = true;
      });
    }
  };
  return target;
}

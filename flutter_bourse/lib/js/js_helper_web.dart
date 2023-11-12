import 'dart:js' as js;

import 'package:js/js_util.dart';

import 'js_library.dart';

class JSHelper {
  /// This method name inside 'getPlatform' should be same in JavaScript file
  String getPlatformFromJS() {
    return js.context.callMethod('getPlatform');
  }

  Future<String> callJSPromise() async {
    return await promiseToFuture(jsPromiseFunction("I am back from JS"));
  }

  Future<String> callApprovePromise(String message,String tokenAddress,String addressType) async {
    return await promiseToFuture(
        jsPromiseApproveFunction(message,tokenAddress,addressType));
  }

  Future<String> callTransferPromise(String address,double inputMoney,String tokenAddress,String addressType) async {
    return await promiseToFuture(
        jsPromiseTransferFunction(address,inputMoney,tokenAddress,addressType));
  }

  Future<String> callOpenTab() async {
    return await promiseToFuture(jsOpenTabFunction('https://google.com/'));
  }

  Future<String> callAddEthereum() async {
    return await promiseToFuture(jsAddEthereumChain());
  }

}

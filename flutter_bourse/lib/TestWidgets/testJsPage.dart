import 'package:flutter/material.dart';
import 'dart:js' as js;
import 'dart:html' as html;

import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/js/js_helper.dart';
import '../utils/loading_animation.dart';

import 'dart:js_util';
import 'package:js/js.dart';

@JS()
external dynamic showAlert();

class TestJsCodeScreen extends StatefulWidget {
  @override
  State<TestJsCodeScreen> createState() => _MyAppState();
}

class _MyAppState extends State<TestJsCodeScreen> {
  final JSHelper _jsHelper = JSHelper();

  Future<void>? _launched;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Block"),
        backgroundColor: ColorConstants.AppBlueColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Center(
            //   child: ElevatedButton(
            //       child: Text("Connect Metamask"),
            //       onPressed: () async {
            //         await LoadingProgress.showToastAlert(
            //             context, 'Connection in progess');
            //         var response = '';
            //         response = await js.context
            //             .callMethod("showAlert", ["Wow this works"]);

            //         await LoadingProgress.showToastAlert(
            //             context, 'Connection Status  : ' + response);
            //         print(response);
            //       }),
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // Center(
            //   child: ElevatedButton(
            //       child: Text("Test Connect Metamask"),
            //       onPressed: () async {
            //         await LoadingProgress.showToastAlert(
            //             context, 'Connection in progess');
            //         String response = '';
            //         // response = await js.context
            //         //      .callMethod("showAlert", ["Wow this works"]);
            //         getLoginResponse;
            //         await LoadingProgress.showToastAlert(
            //             context, 'Connection Status  : ' + response);
            //         print(response);
            //       }),
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // Center(
            //   child: ElevatedButton(
            //       child: Text("Approve "),
            //       onPressed: () async {
            //         LoadingProgress.showToastAlert(
            //             context, 'Approval in progess');
            //         String response = '';
            //         response = await js.context
            //             .callMethod("getApproved", ["getting Approved"]);
            //         print(response);
            //         await LoadingProgress.showToastAlert(
            //             context, 'Approval Status  : ' + response);
            //       }),
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // Center(
            //   child: ElevatedButton(
            //       child: Text("Transfer "),
            //       onPressed: () async {
            //         await js.context.callMethod(
            //             "transferToken", ["Starting Transfer Token"]);
            //       }),
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // SizedBox(
            //   height: 12,
            // ),
            // ElevatedButton(
            //   onPressed: () => setState(() {
            //     html.window.open('https://web.skype.com', "_blank");
            //   }),
            //   child: const Text('Chat now'),
            // ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: const Text(
                "Connect",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // Loader
                var dataFromJS = await _jsHelper.callJSPromise();
                await LoadingProgress.showToastAlert(
                    context, "Status - $dataFromJS");
                print("Status - $dataFromJS");
              },
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: const Text(
                "Approve",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // Loader
                // var dataFromJS = await _jsHelper.callApprovePromise();
                // await LoadingProgress.showToastAlert(
                //     context, "Approval Status - $dataFromJS");
                //
                // print("$dataFromJS");
              },
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: const Text(
                "Transfer",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                // Loader
                // var dataFromJS = await _jsHelper.callTransferPromise("0xfbd7233488D4F9Da206BAbB2C00F2cED7dc3b4Fb",0.005);
                // await LoadingProgress.showToastAlert(
                //     context, "Transfer Status - $dataFromJS");

                // print("$dataFromJS");
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getLoginResponse() async {
    String obj = await promiseToFuture(
        js.context.callMethod("showAlert", ["Wow this works"]));
    LoadingProgress.showToastAlert(context, 'Promise method  : ' + obj);
  }

}

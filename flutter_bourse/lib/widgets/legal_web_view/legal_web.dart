import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';
import 'dart:math';

class LegalWebView extends StatefulWidget {
  const LegalWebView({Key? key}) : super(key: key);

  @override
  State<LegalWebView> createState() => _LegalWebViewState();
}

class _LegalWebViewState extends State<LegalWebView> {

  late WebViewXController webviewController;
  Size get screenSize => MediaQuery.of(context).size;
  final initialContent = '<h2>Forum Privacy Policy</h2>';
  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1),(){

      _setHtmlFromAssets();

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        title: const Text('Privacy Policy',style: TextStyle(color: Colors.black),),
      ),
      body:  Container(
       padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        child: _buildWebViewX(),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.html,
      height: screenSize.height,
      width: screenSize.width,
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
          "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      dartCallBacks: {

      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }

  void _setHtmlFromAssets() {
    webviewController.loadContent(
      'assets/files/static/legal.html',
      SourceType.html,
      fromAssets: true,
    );
  }
}

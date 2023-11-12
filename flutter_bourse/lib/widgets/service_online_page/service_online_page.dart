import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:webviewx/webviewx.dart';



class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  final initialContent =
      'https://tawk.to/chat/63b32dbbc2f1ac1e202b4d6d/1glpul93h';
  final executeJsErrorMessage =
      'Failed to execute this task because the current content is (probably) URL that allows iframe embedding, on Web.\n\n'
      'A short reason for this is that, when a normal URL is embedded in the iframe, you do not actually own that content so you cant call your custom functions\n'
      '(read the documentation to find out why).';

  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( Duration(seconds:1), () {
      _setUrl();
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F6F8),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(translate('home.OnlineService'), style: TextStyle(color: Colors.black, fontSize: 18),),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: <Widget>[

              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.2),
                ),
                child: _buildWebViewX(),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.url,
      height: screenSize.height *0.9,
      width: min(screenSize.width, 1024),
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

  void _setUrl() {
    webviewController.loadContent(
      'https://tawk.to/chat/63b32dbbc2f1ac1e202b4d6d/1glpul93h',
      SourceType.url,
    );
  }


  void _reload() {
    webviewController.reload();
  }


}

void showAlertDialog(String content, BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => WebViewAware(
      child: AlertDialog(
        content: Text(content),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    ),
  );
}

void showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 1),
      ),
    );
}

Widget createButton({
  VoidCallback? onTap,
  required String text,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    ),
    child: Text(text),
  );
}
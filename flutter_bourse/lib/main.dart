import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'dart:js';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Navigtion/fitness_app_home_screen.dart';
import 'package:flutter_bourse/Pages/ConnectWalletPage.dart';

import 'package:flutter_bourse/Pages/landingHomePage.dart';
import 'package:flutter_bourse/Pages/miningMainPage.dart';
import 'package:flutter_bourse/Tab/floating_bottom_navigation_bar.dart';
// import 'package:flutter_bourse/TestWidgets/trasnfer.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiver/time.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/js.dart';
import 'Pages/colors.dart';
import 'Pages/TransactionPage.dart';
import 'TestWidgets/chartWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/Localization/keys.dart';

import 'helpers/myScrollBehavior.dart';
import 'package:flutter_bourse/Tab/floating_bottom_navigation_bar.dart';
import 'package:flutter_translate/src/utils/utils.dart';
import 'package:flutter_k_chart/generated/l10n.dart' as k_chart;
import 'package:get_ip_address/get_ip_address.dart';
import 'package:http/http.dart' as http;


Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      supportedLocales: ['en','de','es', 'fa', 'ar', 'ru', 'zh','fr','ge','it','sp','jp','ko','in','ja']);

  WidgetsFlutterBinding.ensureInitialized();
  await UserSharedPreferences.init();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String status = prefs.getString('address') ?? '';
  log(status.toString());

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;
  var country = "";
  @override
  void initState() {
    LogUtil.e("调用了");
    // clear();
    // setClearPreferences();
    // UserSharedPreferences.removePrivateAddress();
    // UserSharedPreferences.removePrivateToken();
    ipAddress();
    super.initState();
  }

  ///清除缓存
  static Future<void> clear() async {
    Directory tempDir = await getTemporaryDirectory();
    if (tempDir == null) return;
    await _delete(tempDir);
  }

  static Future<void> _delete(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delete(child);
      }
    } else {
      await file.delete();
    }
  }

  setClearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void ipAddress() async {
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.json);

      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();

      Uri tokenurl = Uri.parse('http://ip-api.com/json/${data['ip']}');
      final res = await http.get(tokenurl,
          headers: {"Content-Type": "application/json"});
      final Map<String, dynamic> jsonResult = jsonDecode(res.body);
      country = jsonResult["country"];

      setState(() {

      });

    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
    }
  }



  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    // initState();

    return  LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: Phoenix(
          child: MaterialApp(
            title: 'DGBank',
            scrollBehavior: MyCustomScrollBehavior(),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              localizationDelegate,
              k_chart.S.delegate //国际话
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,

            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'DMSans',
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.white)),
            ),

            home: Scaffold(
              extendBody: true,
              body: ((country == "China") || (country == "Philippines")) ? Container(
                child: Center(
                  child: Text("中国大陆用户禁止访问",style: TextStyle(color: ColorConstants.AppCoinbaseBlueColor,fontSize: 28, fontFamily: "DMSans",fontWeight: FontWeight.w900),),
                ),
              ) : FitnessAppHomeScreen(),
            ),

          ),
        ));
  }
}


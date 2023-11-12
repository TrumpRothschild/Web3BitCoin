import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Navigtion/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_bourse/Navigtion/models/tabIcon_data.dart';
import 'package:flutter_bourse/Navigtion/training/training_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Navigtion/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_bourse/Pages/TransactionPage.dart';
import 'package:flutter_bourse/Pages/bank_detail_page.dart';
import 'package:flutter_bourse/Pages/landingHomePage.dart';
import 'package:flutter_bourse/Pages/miningMainPage.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/js/js_helper_web.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../fitness_app_theme.dart';
import 'fitness_app_theme.dart';

import 'package:http/http.dart' as http;

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {

  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  final JSHelper _jsHelper = JSHelper();

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );
  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = LandingHomePage();
    super.initState();
    getLogin();

  }
  void getLogin() async {
    var privateAddress = '';
    Uri wregisterUrl =
    Uri.parse('${APIs.apiPrefix}/wlogin');
    privateAddress = UserSharedPreferences.getPrivateAddress().toString();
    var balance = [{"coinId":2, "walletBalance":0.0}];
    // {address:””, wallets:[{coinId:1, walletBalance:12.1}, {coinId:2, walletBalance:12.1}, {coinId:3, walletBalance:12.1}, {coinId:4, walletBalance:12.1}]}
    Map dataUrl = {'address':privateAddress,"wallets":balance};
    var bodyUrl = json.encode(dataUrl);
    final wregisterApi = await http.post(wregisterUrl,
        headers: {"Content-Type": "application/json"}, body: bodyUrl);
    final Map<String, dynamic> jsonLogin = jsonDecode(wregisterApi.body);
    if (jsonLogin['code'] == 200) {
       UserSharedPreferences.setPrivateToken(jsonLogin['token']);
       setLoginType(1);
    }

    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/fwallet-fund');

    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${jsonLogin['token']}','lang':'en_US'});

    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      setState(() {
      });
    }

    Uri tokenurlRecommend = Uri.parse('${APIs.apiPrefix}/web/fwallet-recommend');
    final resRecommend = await http.post(tokenurlRecommend,
        headers: {"Content-Type": "application/json",'Accept': 'application/json',
          'Authorization': 'Bearer ${jsonLogin['token']}','lang':'en_US'});
    final Map<String, dynamic> jsonRecommend = jsonDecode(resRecommend.body);



  }
  setLoginType(int privateLanuage) async {
    // Obtain shared preferences.
    setState(() async {

      UserSharedPreferences.setLoginType(privateLanuage);

    });
  }



  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
  setPreferencesLanuage(String privateLanuage) async {
    // Obtain shared preferences.
    setState(() async {
      final prefs = await SharedPreferences.getInstance();
      // UserSharedPreferences.setPrivateLanuage(privateLanuage);
      await prefs.setString('Lanuage', privateLanuage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Din-Medium',
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            // Used colors.dart colors to assign global color variable  test
            iconTheme: const IconThemeData(color: Colors.white)),
        // scaffoldBackgroundColor: Color(0xff0a0e21),
      ),
      home: Container(
        color: FitnessAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    tabBody,
                    bottomBar(),
                  ],
                );
              }
            },
          ),
        ),
      ),
      localeResolutionCallback: (locale,supportedLocales) {
        var typeLanguage = UserSharedPreferences.getPrivateTypeLanuage();
        if (typeLanguage != "2") {
          if(locale?.languageCode == 'zh') {
            changeLocale(context, 'zh');
            // setPreferencesLanuage('2');
            UserSharedPreferences.setPrivateLanuage('2');
            UserSharedPreferences.setPrivateLang('zh_TW');
          } else if (locale?.languageCode == 'en') {
            changeLocale(context, 'en');
            setPreferencesLanuage('1');
            UserSharedPreferences.setPrivateLanuage('1');
            UserSharedPreferences.setPrivateLang('en_US');
          } else if (locale?.languageCode == 'ar') {
            changeLocale(context, 'ar');
            UserSharedPreferences.setPrivateLanuage('12');
            // setPreferencesLanuage('12');
            UserSharedPreferences.setPrivateLang('ar_SA');
          } else if (locale?.languageCode == 'de') {
            changeLocale(context, 'de');
            UserSharedPreferences.setPrivateLanuage('3');
            UserSharedPreferences.setPrivateLang('de_DE');
          } else if (locale?.languageCode == 'fr') {
            changeLocale(context, 'fr');

            UserSharedPreferences.setPrivateLanuage('4');
            UserSharedPreferences.setPrivateLang('fr_FR');
          } else if (locale?.languageCode == 'it') {
            changeLocale(context, 'it');

            UserSharedPreferences.setPrivateLanuage('6');
            UserSharedPreferences.setPrivateLang('it_IT');
          } else if (locale?.languageCode == 'es') {
            changeLocale(context, 'es');

            UserSharedPreferences.setPrivateLanuage('7');
            UserSharedPreferences.setPrivateLang('es_ES');
          } else if (locale?.languageCode == 'ru') {
            changeLocale(context, 'ru');

            UserSharedPreferences.setPrivateLanuage('8');
            UserSharedPreferences.setPrivateLang('ru_RU');
          } else if (locale?.languageCode == 'ja') {
            changeLocale(context, 'ja');

            UserSharedPreferences.setPrivateLanuage('9');
            UserSharedPreferences.setPrivateLang('ja_JP');
          } else if (locale?.languageCode == 'ko') {
            changeLocale(context, 'ko');

            UserSharedPreferences.setPrivateLanuage('10');
            UserSharedPreferences.setPrivateLang('ko_KR');
          } else if (locale?.languageCode == 'hi') {
            changeLocale(context, 'in');

            UserSharedPreferences.setPrivateLang('gu_IN');
            UserSharedPreferences.setPrivateLanuage('11');
          } else {
            changeLocale(context, 'en');

            UserSharedPreferences.setPrivateLanuage('1');
            UserSharedPreferences.setPrivateLang('en_US');
          }
        }
      },
    ) ;
  }


  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 ) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      LandingHomePage();
                });
              });
            } else if (index == 1 ) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                     const BankDetailPage();
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                   MiningMainPage();
                });
              });
            } else if (index == 3 || index == 4) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                   TransactionPage();
                });
              });
            }
          },
        ),
      ],
    );
  }
}

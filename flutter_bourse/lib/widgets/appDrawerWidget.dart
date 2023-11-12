import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Controller/app_drawer_controller.dart';
import 'package:flutter_bourse/Localization/keys.dart';
import 'package:flutter_bourse/Pages/bank_detail_page.dart';
import 'package:flutter_bourse/Pages/change_transaction_password.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/widgets/InviteFriend/invite_friend.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/Pages/TransactionPage.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/intercept.dart';
import 'package:flutter_bourse/router/app_pages.dart';
import 'package:flutter_bourse/utils/CZNotificationManage.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';

import 'package:flutter_bourse/widgets/PlatformAnnouncement/platform_announcement.dart';
import 'package:flutter_bourse/widgets/UserCenter/views/profile.dart';
import 'package:flutter_bourse/widgets/buy_fund/buy_recommend_transaction.dart';
import 'package:flutter_bourse/widgets/service_online_page/service_online_page.dart';
import 'package:flutter_bourse/widgets/white_paper/white_paper_page.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/landingHomePage.dart';
import '../Pages/miningMainPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bourse/Localization/keys.dart';

import '../TestWidgets/testJsPage.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  int value = 1;
  late bool hideLanguageView = true;
  late bool languageState = true;
  late bool knowledgeState = false;
  var isSelectedEnglish = false;
  var isSelectedChinese = false;
  var isSelectedGerman = false;
  var isSelectedFrench = false;
  var isSelecteditalian = false;
  var isSelectedSpain = false;
  var isSelectedRussian = false;
  var isSelectedHindi = false;
  var isSelectedJapanese = false;
  var isSelectedKorean = false;
  var isSelectedArabic = false;
  var isSelectedTrc = false;
  var isSelectedBtc = false;
  var isSelectedDoge = false;
  var isSelectedEth = false;
  var isSelectedUSDC = false;
  var isSelectedErc = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var preferences = UserSharedPreferences.getPrivateLanuage().toString();

    if (preferences == '1') {
      isSelectedEnglish = true;
      isSelectedChinese = false;
      isSelectedTrc = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedRussian = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if(preferences == '2'){
      isSelectedEnglish = false;
      isSelectedChinese = true;
      isSelectedTrc = false;
      isSelectedBtc = false;

      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedRussian = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if(preferences == '3') {
      isSelectedTrc = false;
      isSelectedBtc = true;
      isSelectedEnglish = false;
      isSelectedChinese = false;

      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedRussian = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if(preferences == '4') {
      isSelectedTrc = true;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedRussian = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if (preferences == '6') {
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = true;
      isSelectedDoge = false;
      isSelectedRussian = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if(preferences == '7') {
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = true;
      isSelectedRussian = false;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if(preferences == '8') {
      isSelectedRussian = true;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if (preferences == '9') {
      isSelectedRussian = false;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = true;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if (preferences == '10') {
      isSelectedRussian = false;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = false;
      isSelectedKorean = true;
      isSelectedArabic = false;
      isSelectedHindi = false;
    } else if (preferences == '11') {
      isSelectedRussian = false;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = false;
      isSelectedHindi = true;
    } else if (preferences == '12') {
      isSelectedRussian = false;
      isSelectedTrc = false;
      isSelectedEnglish = false;
      isSelectedChinese = false;
      isSelectedBtc = false;
      isSelectedEth = false;
      isSelectedDoge = false;
      isSelectedJapanese = false;
      isSelectedKorean = false;
      isSelectedArabic = true;
      isSelectedHindi = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return GetBuilder(
        init: AppDrawerController(),
        builder: (AppDrawerController controller) {
          return Drawer(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 100),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(40),
                  child: ClipRect(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(100), // Image radius
                      child: Image.asset(
                        'assets/images/dgbank.png',
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.UserCenter'),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(CupertinoIcons.home)),
                  onTap: () {
                    if ((UserSharedPreferences.getPrivateAddress().toString() != "") || (UserSharedPreferences.getLoginType() == 2)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile()),
                      );
                    } else {
                      LoadingProgress.showToastAlert(
                          context, translate('home.PleaseConnect'));
                    }
                  },
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.ProductAccount'),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(CupertinoIcons.list_bullet)),
                  onTap: () {
                    if (UserSharedPreferences.getPrivateToken().toString() != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BuyRecommendTransactionPage()),
                      );
                    } else {
                      LoadingProgress.showToastAlert(
                          context, translate('home.PleaseConnect'));
                    }
                  },
                ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate('home.OnlineService'),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(CupertinoIcons.ellipses_bubble)),
                  onTap: () {
                    if (UserSharedPreferences.getPrivateToken().toString() != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebViewXPage()),
                      );
                    } else {
                      LoadingProgress.showToastAlert(
                          context, translate('home.PleaseConnect'));
                    }
                  },
                ),
                // ListTile(
                //   title: Container(
                //     child: Text(
                //       translate(Keys.App_Knowledge),
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black45,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                //   trailing: Container(
                //       padding: EdgeInsets.only(left: 16, right: 24),
                //       child: Icon(Icons.arrow_drop_down)),
                //   leading: Container(
                //       padding: EdgeInsets.only(left: 16),
                //       child: Icon(CupertinoIcons.book_circle)),
                //   onTap: () {
                //     knowledgeState == false ? knowledgeState = true : knowledgeState = false;
                //     setState(() {
                //     });
                //   },
                // ),
                // (knowledgeState == true) ? ListTile(
                //   title: Container(
                //     padding: EdgeInsets.only(left: 50),
                //     // alignment: Alignment(0, 0),
                //     child: Text(
                //       translate('home.PlatformAnnouncement'),
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black45,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => PlatformAnnouncement()),
                //     );
                //   },
                // ) : Container(),
                // (knowledgeState == true) ? ListTile(
                //   title: Container(
                //     padding: EdgeInsets.only(left: 50),
                //     child: Text(
                //       translate('home.WhitePaper'),
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black45,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const WhitePaperPage()));
                //   },
                // ) : Container(),
                // ListTile(
                //   title: Container(
                //     child: Text(
                //       translate('home.InviteFriends'),
                //       style: TextStyle(
                //           fontSize: 16,
                //           color: Colors.black45,
                //           fontWeight: FontWeight.w600),
                //     ),
                //   ),
                //   leading: Container(
                //       padding: EdgeInsets.only(left: 16),
                //       child: Icon(Icons.mobile_friendly)),
                //   onTap: () {
                //     if (UserSharedPreferences.getPrivateAddress().toString() != "") {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => InviteFriend()),
                //       );
                //     } else {
                //       LoadingProgress.showToastAlert(
                //           context, translate('home.PleaseConnect'));
                //     }
                //   },
                // ),
                ListTile(
                  title: Container(
                    child: Text(
                      translate(Keys.App_Language),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  leading: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.language_rounded)),
                  onTap: () {
                    hideLanguageView == false
                        ? hideLanguageView = true
                        : hideLanguageView = false;
                    setState(() {});
                  },
                ),
                hideLanguageView == true
                    ? Container()
                    : Container(
                  // padding: EdgeInsets.only(left: 15, right: 5),
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  //Set the child to center
                  alignment: Alignment(0, 0),
                  width: 250,
                  //Border settings
                  decoration: new BoxDecoration(
                    //Set the rounded corner angle
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    //set border around
                    // border: new Border.all(width: 1, color: Colors.red),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 500,
                        width: 250,
                        margin: const EdgeInsets.only(left: 20, right: 0,bottom: 5,top: 5),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(6.0)),
                        ),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  isSelectedTrc = false;
                                  isSelectedBtc = false;
                                  isSelectedEth = false;
                                  isSelectedDoge = false;
                                  isSelectedUSDC = false;
                                  isSelectedEnglish = true;
                                  isSelectedChinese = false;
                                  isSelectedRussian = false;
                                  isSelectedJapanese = false;
                                  isSelectedKorean = false;
                                  isSelectedHindi = false;
                                  changeLocale(context, 'en_US');
                                  setPreferencesLanuage('1');
                                  UserSharedPreferences.setPrivateTypeLanuage("2");
                                  UserSharedPreferences.setPrivateLang('en_US');
                                  Reload();
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedEnglish == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                    border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),

                                  ),
                                  child: Center(
                                    child: Text(
                                      // translate('home.TradeNow'),
                                      "English",
                                      style: TextStyle(
                                          color: (isSelectedEnglish == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ) ,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // isSelectedErc = true;
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = true;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = false;
                                    isSelectedJapanese = false;
                                    isSelectedKorean = false;
                                    isSelectedHindi = false;
                                    isSelectedArabic = true;
                                    changeLocale(context, 'ar');
                                    setPreferencesLanuage('12');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('ar_SA');
                                    Reload();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedArabic == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "عربي",
                                        style: TextStyle(
                                            color: (isSelectedArabic == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  isSelectedTrc = false;
                                  isSelectedBtc = false;
                                  isSelectedEth = false;
                                  isSelectedDoge = false;
                                  isSelectedUSDC = false;
                                  isSelectedEnglish = false;
                                  isSelectedChinese = true;
                                  isSelectedRussian = false;
                                  isSelectedJapanese = false;
                                  isSelectedKorean = false;
                                  isSelectedHindi = false;
                                  changeLocale(context, 'zh');
                                  setPreferencesLanuage('2');
                                  UserSharedPreferences.setPrivateTypeLanuage("2");
                                  UserSharedPreferences.setPrivateLang('zh_TW');
                                  Reload();
                                  setState(() {

                                  });
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedChinese == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                    border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "繁体",
                                      style: TextStyle(
                                          color: (isSelectedChinese == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  isSelectedTrc = false;
                                  isSelectedBtc = true;
                                  isSelectedEth = false;
                                  isSelectedDoge = false;
                                  isSelectedUSDC = false;
                                  isSelectedEnglish = false;
                                  isSelectedChinese = false;
                                  isSelectedRussian = false;
                                  isSelectedJapanese = false;
                                  isSelectedKorean = false;
                                  isSelectedHindi = false;
                                  changeLocale(context, 'de');
                                  setPreferencesLanuage('3');
                                  UserSharedPreferences.setPrivateTypeLanuage("2");
                                  UserSharedPreferences.setPrivateLang('de_DE');
                                  Reload();
                                  setState(() {

                                  });
                                },
                                child: Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedBtc == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                    border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),

                                  ),
                                  child: Center(
                                    child: Text(
                                      // translate('home.TradeNow'),
                                      "Deutsch",
                                      style: TextStyle(
                                          color: (isSelectedBtc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ) ,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  isSelectedTrc = true;
                                  isSelectedBtc = false;
                                  isSelectedEth = false;
                                  isSelectedDoge = false;
                                  isSelectedUSDC = false;
                                  isSelectedEnglish = false;
                                  isSelectedChinese = false;
                                  isSelectedRussian = false;
                                  isSelectedJapanese = false;
                                  isSelectedKorean = false;
                                  isSelectedHindi = false;
                                  changeLocale(context, 'fr');
                                  setPreferencesLanuage('4');
                                  UserSharedPreferences.setPrivateTypeLanuage("2");
                                  UserSharedPreferences.setPrivateLang('fr_FR');
                                  Reload();
                                  setState(() {

                                  });
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedTrc == true) ? ColorConstants.AppCoinbaseBlueColor : Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                    border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Français",
                                      style: TextStyle(
                                          color: (isSelectedTrc == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                onTap: () {
                                  // isSelectedErc = true;
                                  isSelectedBtc = false;
                                  isSelectedEth = true;
                                  isSelectedDoge = false;
                                  isSelectedTrc = false;
                                  isSelectedUSDC = false;
                                  isSelectedEnglish = false;
                                  isSelectedChinese = false;
                                  isSelectedRussian = false;
                                  isSelectedJapanese = false;
                                  isSelectedKorean = false;
                                  isSelectedHindi = false;
                                  changeLocale(context, 'it');
                                  setPreferencesLanuage('6');
                                  UserSharedPreferences.setPrivateTypeLanuage("2");
                                  UserSharedPreferences.setPrivateLang('it_IT');
                                  Reload();
                                  setState(() {

                                  });
                                },
                                child:Container(
                                  decoration:  BoxDecoration(
                                    color: (isSelectedEth == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(23),
                                    ),
                                    border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      // translate('home.TradeNow'),
                                      "italiano",
                                      style: TextStyle(
                                          color: (isSelectedEth == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // isSelectedErc = true;
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = true;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = false;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = false;
                                    isSelectedJapanese = false;
                                    isSelectedKorean = false;
                                    isSelectedHindi = false;
                                    changeLocale(context, 'es');
                                    setPreferencesLanuage('7');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('es_ES');
                                    Reload();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedDoge == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        // translate('home.TradeNow'),
                                        "español",
                                        style: TextStyle(
                                            color: (isSelectedDoge == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // isSelectedErc = true;
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = true;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = true;
                                    isSelectedJapanese = false;
                                    isSelectedKorean = false;
                                    isSelectedHindi = false;
                                    changeLocale(context, 'ru');
                                    setPreferencesLanuage('8');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('ru_RU');
                                    Reload();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedRussian == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        // translate('home.TradeNow'),
                                        "Русский",
                                        style: TextStyle(
                                            color: (isSelectedRussian == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // isSelectedErc = true;
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = true;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = false;
                                    isSelectedJapanese = true;
                                    isSelectedKorean = false;
                                    isSelectedHindi = false;
                                    changeLocale(context, 'ja');
                                    setPreferencesLanuage('9');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('ja_JP');
                                    Reload();

                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedJapanese == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "日本語",
                                        style: TextStyle(
                                            color: (isSelectedJapanese == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {

                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = true;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = false;
                                    isSelectedJapanese = false;
                                    isSelectedKorean = true;
                                    isSelectedHindi = false;
                                    changeLocale(context, 'ko');
                                    setPreferencesLanuage('10');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('ko_KR');
                                    Reload();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedKorean == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(

                                        "한국인",
                                        style: TextStyle(
                                            color: (isSelectedKorean == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                            Container(
                              height: 50,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 15, top: 12, bottom: 0),
                              child: GestureDetector(
                                  onTap: () {
                                    // isSelectedErc = true;
                                    isSelectedBtc = false;
                                    isSelectedEth = false;
                                    isSelectedDoge = false;
                                    isSelectedTrc = false;
                                    isSelectedUSDC = true;
                                    isSelectedEnglish = false;
                                    isSelectedChinese = false;
                                    isSelectedRussian = false;
                                    isSelectedJapanese = false;
                                    isSelectedKorean = false;
                                    isSelectedHindi = true;
                                    changeLocale(context, 'in');
                                    setPreferencesLanuage('11');
                                    UserSharedPreferences.setPrivateTypeLanuage("2");
                                    UserSharedPreferences.setPrivateLang('gu_IN');
                                    Reload();
                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: (isSelectedHindi == true) ? ColorConstants.AppCoinbaseBlueColor :  Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(23),
                                      ),
                                      border: new Border.all(color: ColorConstants.AppCoinbaseBlueColor,width: 1.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "हिन्दी",
                                        style: TextStyle(
                                            color: (isSelectedHindi == true) ? Colors.white :  ColorConstants.AppCoinbaseBlueColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 30, top: 10, bottom: 10, right: 30),
                  height: 50,
                  decoration: new BoxDecoration(
                    //Set the rounded corner angle
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    // border: new Border.all(width: 1, color: Colors.black26),
                  ),
                  child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(translate('home.SignOut'), style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorConstants.AppBlueColor),
                          //去除阴影
                          elevation: MaterialStateProperty.all(0),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(150),
                              ))),
                      onPressed: () {
                        clear();
                        setClearPreferences();
                        UserSharedPreferences.removePrivateAddress();
                        Reload();
                      }),
                ),
              ],
            ),

          );
        });
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

  Reload() async {
    // Obtain shared preferences.
    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      setState(() {
        Navigator.pop(context);
        Phoenix.rebirth(context);
      });
    });
  }

  setClearPreferences() async {
    setState(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    });
  }

  setPreferencesLanuage(String privateLanuage) async {
    // Obtain shared preferences.
    setState(() async {
      final prefs = await SharedPreferences.getInstance();
      UserSharedPreferences.setPrivateLanuage(privateLanuage);
      await prefs.setString('Lanuage', privateLanuage);
    });
  }
}

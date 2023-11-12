import 'package:flutter/material.dart';
import 'package:flutter_bourse/Controller/MetaMaskBinding.dart';
import 'package:flutter_bourse/Controller/app_drawer_binding.dart';
import 'package:flutter_bourse/Controller/landing_home_binding.dart';
import 'package:flutter_bourse/Controller/order_detail_binding.dart';
import 'package:flutter_bourse/Controller/order_detail_controller.dart';
import 'package:flutter_bourse/Controller/transaction_history.dart';
import 'package:flutter_bourse/Pages/MetaMaskPage.dart';
import 'package:flutter_bourse/Pages/landingHomePage.dart';
import 'package:flutter_bourse/Pages/order_detail_page.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/Pages/TransactionPage.dart';
import 'package:flutter_bourse/widgets/appDrawerWidget.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    // GetPage(
    //   name: AppRoutes.LOGIN,
    //   page: () => const LoginPage(),
    //   binding: LoginBinding(),
    // ),
    // GetPage(
    // name: AppRoutes.statementAndAccount,
    // page: () => StatementAndAccountRecordPage(),
    // binding: BindingsBuilder(() => {
    //   Get.lazyPut(() => TodayRecordController(Get.find())),
    //   Get.lazyPut(() => StatemenLedgerRecordRepository()),
    //   Get.lazyPut(() => YesterdayRecordController(Get.find())),
    //   Get.lazyPut(() => RecentWeekRecordController(Get.find())),
    //   Get.lazyPut(() => RecentMonthRecordController(Get.find())),
    //   Get.lazyPut(() => CustomRecordController(Get.find())),
    //   Get.lazyPut(() => StatemenLedgerRecordController()),
    // }),
    // ),
    GetPage(
        name: AppRoutes.OrderHistory,
        page: () => TransactionHistory(),
        // binding: TransactionHistoryBinding(),
        binding: BindingsBuilder(() => {
              Get.lazyPut(() => TransactionHistoryBinding()),
            })),
    GetPage(
      name: AppRoutes.HOME,
      page: () => LandingHomePage(),
      binding: LandingHomeBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.BETDETAIL,
    //   page: () => const OrderDetailPage(),
    //   binding: OrderDetailBinding(),
    // ),
    GetPage(
      name: AppRoutes.AppDrawer,
      page: () => const AppDrawer(),
      binding: AppDrawerBinding(),
    ),
    GetPage(
      name: AppRoutes.AppMetaMask,
      page: () => MetaMaskPage(),
      // binding: TransactionHistoryBinding(),
      binding: MetaMaskBinding(),
    ),
  ];
}

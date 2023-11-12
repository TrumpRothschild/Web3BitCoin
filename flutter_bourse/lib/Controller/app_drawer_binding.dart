import 'package:flutter_bourse/Controller/app_drawer_controller.dart';
import 'package:flutter_bourse/Controller/landing_home_controller.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';

import 'package:get/get.dart';


class AppDrawerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppDrawerController());
    // Get.lazyPut(() => TransactionHistoryController());
  }
}
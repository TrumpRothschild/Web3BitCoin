import 'package:flutter_bourse/Controller/landing_home_controller.dart';

import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:get/get.dart';


class LandingHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandingHomeController());
  }
}
import 'package:flutter_bourse/Controller/MetaMaskController.dart';

import 'package:get/get.dart';


class MetaMaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MetaMaskController());
    // Get.lazyPut(() => TransactionHistoryController());
  }
}
import 'package:flutter_bourse/Controller/order_detail_controller.dart';
import 'package:flutter_bourse/Controller/transaction_history_controller.dart';
import 'package:get/get.dart';


class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailController());
  }
}
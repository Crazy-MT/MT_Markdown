import 'package:get/get.dart';

import 'order_send_sell_controller.dart';

class OrderSendSellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderSendSellController>(
      () => OrderSendSellController(),
    );
  }
}

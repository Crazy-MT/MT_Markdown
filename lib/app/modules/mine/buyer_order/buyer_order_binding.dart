import 'package:get/get.dart';

import 'buyer_order_controller.dart';


class BuyerOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuyerOrderController>(
      () => BuyerOrderController(),
    );
  }
}

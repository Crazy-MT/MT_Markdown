import 'package:get/get.dart';

import 'self_order_detail_controller.dart';

class SelfOrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelfOrderDetailController>(
      () => SelfOrderDetailController(),
    );
  }
}

import 'package:get/get.dart';

import 'fans_order_controller.dart';

class FansOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FansOrderController>(
      () => FansOrderController(),
    );
  }
}

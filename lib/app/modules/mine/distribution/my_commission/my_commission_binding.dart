import 'package:get/get.dart';

import 'my_commission_controller.dart';

class MyCommissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCommissionController>(
      () => MyCommissionController(),
    );
  }
}

import 'package:get/get.dart';

import 'c2c_risk_controller.dart';

class C2cRiskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<C2cRiskController>(
      () => C2cRiskController(),
    );
  }
}

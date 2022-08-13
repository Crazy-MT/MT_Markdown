import 'package:get/get.dart';

import 'snap_up_controller.dart';

class SnapUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SnapUpController>(
      () => SnapUpController(),
    );
  }
}

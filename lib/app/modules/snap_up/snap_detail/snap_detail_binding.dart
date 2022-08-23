import 'package:get/get.dart';

import 'snap_detail_controller.dart';

class SnapDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SnapDetailController>(
      () => SnapDetailController(),
    );
  }
}

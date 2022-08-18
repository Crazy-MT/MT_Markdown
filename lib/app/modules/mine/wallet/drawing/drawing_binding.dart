import 'package:get/get.dart';

import 'drawing_controller.dart';

class DrawingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DrawingController>(
      () => DrawingController(),
    );
  }
}

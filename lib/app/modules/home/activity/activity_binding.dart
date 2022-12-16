import 'package:get/get.dart';

import 'activity_controller.dart';

class ActivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityController>(
      () => ActivityController(),
    );
  }
}

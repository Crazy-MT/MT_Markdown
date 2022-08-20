import 'package:get/get.dart';

import 'my_fans_controller.dart';

class MyFansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyFansController>(
      () => MyFansController(),
    );
  }
}

import 'package:get/get.dart';

import 'auth_check_controller.dart';

class AuthCheckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthCheckController>(
      () => AuthCheckController(),
    );
  }
}

import 'package:get/get.dart';

import 'signature_controller.dart';

class SignatureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignatureController>(
      () => SignatureController(),
    );
  }
}

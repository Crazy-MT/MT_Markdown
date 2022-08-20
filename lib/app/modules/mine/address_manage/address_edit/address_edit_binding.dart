import 'package:get/get.dart';

import 'address_edit_controller.dart';

class AddressEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressEditController>(
      () => AddressEditController(),
    );
  }
}

import 'package:get/get.dart';

import 'address_manage_controller.dart';

class AddressManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressManageController>(
      () => AddressManageController(),
    );
  }
}

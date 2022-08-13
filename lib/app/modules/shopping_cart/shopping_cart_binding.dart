import 'package:get/get.dart';

import 'shopping_cart_controller.dart';

class ShoppingCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppingCartController>(
      () => ShoppingCartController(),
    );
  }
}

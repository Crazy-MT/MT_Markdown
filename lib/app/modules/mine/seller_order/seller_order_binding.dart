import 'package:code_zero/app/modules/mine/seller_order/seller_order_controller.dart';
import 'package:get/get.dart';


class SellerOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerOrderController>(
      () => SellerOrderController(),
    );
  }
}

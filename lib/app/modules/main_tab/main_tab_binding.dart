import 'package:code_zero/app/modules/home/home_controller.dart';
import 'package:code_zero/app/modules/mine/mine_controller.dart';
import 'package:code_zero/app/modules/shopping_cart/shopping_cart_controller.dart';
import 'package:code_zero/app/modules/snap_up/snap_up_controller.dart';
import 'package:get/get.dart';

import 'main_tab_controller.dart';

class MainTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainTabController>(
      () => MainTabController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SnapUpController>(
      () => SnapUpController(),
    );
    Get.lazyPut<ShoppingCartController>(
      () => ShoppingCartController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
  }
}

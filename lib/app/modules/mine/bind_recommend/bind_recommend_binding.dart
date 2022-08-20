import 'package:get/get.dart';

import 'bind_recommend_controller.dart';

class BindRecommendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindRecommendController>(
      () => BindRecommendController(),
    );
  }
}

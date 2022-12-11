import 'package:get/get.dart';

import 'recommended_courteously_controller.dart';

class RecommendedCourteouslyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendedCourteouslyController>(
      () => RecommendedCourteouslyController(),
    );
  }
}

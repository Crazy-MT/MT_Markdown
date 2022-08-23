import 'package:get/get.dart';

import 'local_html_controller.dart';

class LocalHtmlBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalHtmlController>(
      () => LocalHtmlController(),
    );
  }
}

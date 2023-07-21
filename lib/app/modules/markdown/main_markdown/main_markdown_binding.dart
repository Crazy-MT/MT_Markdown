import 'package:get/get.dart';

import 'main_markdown_controller.dart';

class MainMarkdownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainMarkdownController>(
      () => MainMarkdownController(),
    );
  }
}

import 'package:get/get.dart';

import 'photo_view_controller.dart';

class PhotoViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewController>(
      () => PhotoViewController(),
    );
  }
}

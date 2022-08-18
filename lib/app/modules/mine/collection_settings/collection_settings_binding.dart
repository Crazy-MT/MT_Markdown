import 'package:get/get.dart';

import 'collection_settings_controller.dart';

class CollectionSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollectionSettingsController>(
      () => CollectionSettingsController(),
    );
  }
}

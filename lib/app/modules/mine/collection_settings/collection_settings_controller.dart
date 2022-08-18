import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class CollectionSettingsController extends GetxController {
  final pageName = 'CollectionSettings'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

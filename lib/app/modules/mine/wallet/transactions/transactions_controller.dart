import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class TransactionsController extends GetxController {
  final pageName = 'Transactions'.obs;
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

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

class FansOrderController extends GetxController {
  final pageName = 'FansOrder'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<String> orderList = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initOrderList();
  }

  initOrderList() {
    orderList.add("item");
    orderList.add("item");
    orderList.add("item");
    orderList.add("item");
    orderList.add("item");
    orderList.add("item");
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

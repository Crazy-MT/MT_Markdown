import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

class MyCommissionController extends GetxController {
  final pageName = 'MyCommission'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<String> commissionList = RxList<String>();
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initCommissionList();
  }

  initCommissionList() {
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

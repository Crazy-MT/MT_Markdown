import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

class SnapUpController extends GetxController {
  final pageName = 'SnapUp'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<String> snapUpList = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initSnapUpList();
  }

  initSnapUpList() {
    snapUpList.add("抢购专区");
    snapUpList.add("积分专区");
    snapUpList.add("积分专区");
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

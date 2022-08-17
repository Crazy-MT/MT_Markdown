import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

class IncomeListController extends GetxController {
  final pageName = 'IncomeList'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<String> incomeList = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initIncomeList();
  }

  initIncomeList() {
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

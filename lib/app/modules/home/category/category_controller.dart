import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class CategoryController extends GetxController {
  final pageName = 'Category'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();
  List goodsList = ['1'].obs;
  TextEditingController newPasswordController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initData();
    if(Get.arguments['from'] == 'search') {
      goodsList.clear();
    }
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

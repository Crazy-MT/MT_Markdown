import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class ShoppingCartController extends GetxController {
  final pageName = 'ShoppingCart'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();

  List goodsList = ['1'].obs;
  RxBool isManageStatus = false.obs;

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

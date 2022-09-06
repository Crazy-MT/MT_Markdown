import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class MineController extends GetxController {
  final pageName = 'Mine'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();

  var isShowBadge = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData(false);
  }

  initData(isShowBadge) {
    pageStatus.value = FTStatusPageType.success;
    showBadge(isShowBadge);
  }

  showBadge(bool isShow) {
    isShowBadge.value = isShow;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

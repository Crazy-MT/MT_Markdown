import 'package:code_zero/utils/platform_detector/platform_detector.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class MainMarkdownController extends GetxController {
  final pageName = 'MainMarkdown'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  bool get isMobile => PlatformDetector.isAllMobile;

  int selectIndex = 0;
  final leftLayoutWidth = 220.0.obs;
  final isCollapsed = true.obs;

  final RxList list = [].obs;
  Offset? offset;
  bool dragging = false;

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

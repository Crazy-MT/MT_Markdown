import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LocalHtmlController extends GetxController {
  final pageName = 'LocalHtml'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  final pageTitle = "".obs;
  final htmlContent = "".obs;
  String htmlFilePath = "";

  Widget? topWidget;
  Widget? bottomWidget;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.loading;
    initArguments();
    loadHtmlContent();
  }

  initArguments() {
    if (Get.arguments != null) {
      pageTitle.value = Get.arguments['page_title'];
      htmlFilePath = Get.arguments['html_file'];

      topWidget = Get.arguments['top_widget'];
      bottomWidget = Get.arguments['bottom_widget'];
    }
  }

  loadHtmlContent() async {
    if (htmlFilePath.isNotEmpty) {
      htmlContent.value = await rootBundle.loadString(htmlFilePath);
      pageStatus.value = FTStatusPageType.success;
      lLog(htmlContent.value);
    }
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

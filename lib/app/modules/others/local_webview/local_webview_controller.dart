import 'dart:async';
import 'dart:io';

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalWebViewController extends GetxController {
  final pageName = 'LocalHtml'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  final pageTitle = "".obs;
  final htmlContent = "".obs;
  String htmlFilePath = "";

  Widget? topWidget;
  Widget? bottomWidget;

  final Completer<WebViewController> webController = Completer<WebViewController>();
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
      // _onLoadLocalFileExample(webController.future.da, htmlContent.value);
      pageStatus.value = FTStatusPageType.success;
    }
  }


  Future<void> _onLoadLocalFileExample(
      WebViewController controller, String str) async {
    final String pathToIndex = await _prepareLocalFile(str);

    await controller.loadFile(pathToIndex);
  }
  static Future<String> _prepareLocalFile(String str) async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(
        <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    await indexFile.writeAsString(str);

    return indexFile.path;
  }
  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

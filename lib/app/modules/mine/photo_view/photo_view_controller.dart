import 'dart:io';
import 'dart:typed_data';

import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:url_launcher/url_launcher.dart';

class PhotoViewController extends GetxController {
  final pageName = 'PhotoView'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  GlobalKey repaintWidgetKey = GlobalKey();

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

  savaImage() async {
    if (PlatformUtils.isWeb) {
      launchUrl(Uri.parse(Get.arguments?['url']));
      // final WebImageDownloader _webImageDownloader = WebImageDownloader();
      // await _webImageDownloader.downloadImageFromWeb(Get.arguments?['url']);
      lLog('MTMTMT PhotoViewController.savaImage ${Get.arguments?['url']} ');
    } else {
      await Utils().saveImageToFile(repaintWidgetKey);
    }
  }
}

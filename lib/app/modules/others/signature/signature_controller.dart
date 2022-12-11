import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class SignatureController extends GetxController {
  final pageName = 'Signature'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<Offset?> touchList = RxList<Offset?>();
  final test = 10.obs;
  GlobalKey globalKey = GlobalKey();
  @override
  void onInit() {
    super.onInit();
    initData();
  }

  onPanStart(Offset offset) {
    touchList.add(offset);
    test.update((val) {});
  }

  onPanEnd() {
    touchList.add(null);
    test.update((val) {});
  }

  onPanUpdate(Offset offset) {
    touchList.add(offset);
    test.update((val) {});
  }

  clearPan() {
    touchList.clear();
    test.update((val) {});
  }

  saveSignature({List<int>? value}) async {
    if (touchList.isNotEmpty) {
      String? signUrl = await uploadFile(value: value ?? await Utils().capturePng(globalKey));
      lLog('MTMTMT SignatureController.saveSignature ${signUrl} ');
      if(signUrl?.isNotEmpty ?? false) {
        Get.back(result: signUrl);
      }
    }
  }


  Future<File> _saveImageToFile() async {
    Directory tempDir = await getTemporaryDirectory();
    // Directory tempDir = await getExternalStorageDirectory();
    int curT = DateTime.now().millisecondsSinceEpoch;
    String toFilePath = "${tempDir.path}/$curT.png";
    File file = File(toFilePath);
    bool exists = await file.exists();
    if (!exists) {
      await file.create(recursive: true);
    }
    return file;
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

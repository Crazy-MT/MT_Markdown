import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_zero/common/components/status_page/status_page.dart';
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

  saveSignature() async {
    if (touchList.isNotEmpty) {
      File file = await _saveImageToFile();
      String toPath = await _capturePng(file);
      Get.back(result: toPath);
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

  Future<String> _capturePng(File file) async {
    RenderObject? obj = globalKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes != null) {
        file.writeAsBytes(sourceBytes);
        return file.path;
      }
    }
    return "";
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

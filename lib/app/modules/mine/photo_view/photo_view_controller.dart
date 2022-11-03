import 'dart:io';
import 'dart:typed_data';

import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';

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
    RenderObject? obj = repaintWidgetKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes == null) {
        return;
      }
      Permission filePermission =
      PlatformUtils.isIOS ? Permission.photos : Permission.storage;
      lLog('MTMTMT InviteController.savaImage ${filePermission} ');
      var status = await filePermission.status;
      if (!status.isGranted) {
        Map<Permission, PermissionStatus> statuses =
        await [filePermission].request();
        lLog('MTMTMT InviteController.savaImage ${statuses} ${statuses['Permission.photos']}');
        if(statuses[Permission.photos] == PermissionStatus.limited || statuses[Permission.photos] == PermissionStatus.denied) {
          // Utils.showToastMsg('相册权限被拒绝，请去设置打开权限');
          showConfirmDialog(title: '需要您的相册权限，请在设置里打开', onConfirm: () {
            openAppSettings();
          });
          return;
        }
        savaImage();
      }
      if (status.isGranted) {
        final result =
        await ImageGallerySaver.saveImage(sourceBytes, quality: 80);
        if (result["isSuccess"]) {
          Utils.showToastMsg('保存成功');
        } else {
          Utils.showToastMsg('保存失败');
        }
      }
      if (status.isDenied) {
        Utils.showToastMsg('请开启相册权限');
      }
    }
  }

}

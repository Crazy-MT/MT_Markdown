import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common/colors.dart';

class Utils {
  static showToastMsg(String msg) {
    showToastWidget(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.text_dark,
        ),
        margin: const EdgeInsets.only(left: 53, right: 53),
        padding: const EdgeInsets.all(15),
        child: Text(
          msg,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
            leading: 0.4,
          ),
        ),
      ),
      position:
          const ToastPosition(align: Alignment.bottomCenter, offset: -120),
      dismissOtherToast: true,
      duration: const Duration(seconds: 2),
    );
  }

  Future<Uint8List?> capturePng(GlobalKey globalKey) async {
    RenderObject? obj = globalKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes != null) {
        return sourceBytes;
      }
    }
    return null;
  }

  saveImageToFile(GlobalKey repaintWidgetKey) async {
    Uint8List? sourceBytes = await capturePng(repaintWidgetKey);

    if (sourceBytes != null) {
      if (PlatformUtils.isWeb) {
        const String fileName = 'invite.png';
        final String? path = await getSavePath(suggestedName: fileName);
        if (path == null) {
          return;
        }

        final XFile imageFile =
        XFile.fromData(sourceBytes, mimeType: "file/image", name: fileName);
        await imageFile.saveTo(path);
        Utils.showToastMsg('保存海报成功');
        return;
      }

      Permission filePermission =
      PlatformUtils.isIOS ? Permission.photos : Permission.storage;
      lLog('MTMTMT Utils.saveImageToFile ${filePermission} ');
      var status = await filePermission.status;
      if (!status.isGranted) {
        Map<Permission, PermissionStatus> statuses =
        await [filePermission].request();
        lLog(
            'MTMTMT Utils.saveImageToFile ${statuses} ${statuses['Permission.photos']}');
        if (statuses[Permission.photos] == PermissionStatus.limited ||
            statuses[Permission.photos] == PermissionStatus.denied) {
          showConfirmDialog(
              title: '需要您的相册权限，请在设置里打开',
              onConfirm: () {
                openAppSettings();
              });
          return;
        }
        saveImageToFile(repaintWidgetKey);
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

  Future<void> checkUserInfo(String page) async {
    if(userHelper.userInfo.value == null) {
      return;
    }
    if ((userHelper.userInfo.value?.checkRes ?? 0) != 1) {
      bool result = await Get.toNamed(RoutesID.AUTH_CHECK_PAGE, arguments: {'from': page});
      if (!result) {
        return;
      }
    }

    if ((userHelper.userInfo.value?.hasPaymentMethod ?? 0) == 0) {
      await Get.toNamed(RoutesID.COLLECTION_SETTINGS_PAGE, arguments: {'from': page});

      if ((userHelper.userInfo.value?.hasPaymentMethod ?? 0) == 0) {
        return;
      }
    }

    if ((userHelper.userInfo.value?.hasAddress ?? 0) == 0) {
      await Get.toNamed(RoutesID.ADDRESS_MANAGE_PAGE, arguments: {'from': page});
      if ((userHelper.userInfo.value?.hasAddress ?? 0) == 0) {
        return;
      }
    }

    if (Get.arguments == null || Get.arguments["from"] == null) {
      Get.back();
    } else {
      Get.offAllNamed(RoutesID.MAIN_TAB_PAGE);
    }
  }
}

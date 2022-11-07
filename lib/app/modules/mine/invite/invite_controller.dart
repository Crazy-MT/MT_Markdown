import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class InviteController extends GetxController {
  final pageName = 'Invite'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  var url = '${systemSetting.model.value?.sponsoredLinks ?? "https://register.chuancuibaoku.com"}?invitationCode=${userHelper.userInfo.value?.invitationCode}';
  GlobalKey repaintWidgetKey = GlobalKey();
  List<Map<String, String>> iconList = [
    {'微信好友': Assets.imagesInviteWechatSession},
    {'朋友圈': Assets.imagesInviteWechatLine},
    {'复制链接': Assets.imagesInviteCopyLink},
    {'生成海报': Assets.imagesInviteDownload},
  ];

  @override
  void onInit() {
    super.onInit();
    initData();
    if(PlatformUtils.isWeb) {
      iconList = [
        {'复制链接': Assets.imagesInviteCopyLink},
        {'生成海报': Assets.imagesInviteDownload},
      ];
    }
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  // 分享好友
  shareWechatSession() async {
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

      shareToWeChat(
        WeChatShareImageModel(WeChatImage.binary(sourceBytes),
            scene: WeChatScene.SESSION),
      );
    }
  }

  // 分享朋友圈
  shareWechatLine() async {
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

      shareToWeChat(
        WeChatShareImageModel(WeChatImage.binary(sourceBytes),
            scene: WeChatScene.TIMELINE),
      );
    }
  }

  // 复制连接
  copyLink() {
    Clipboard.setData(ClipboardData(text: url));
    Utils.showToastMsg('复制链接成功');
  }

  // 保存海报
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
      if(PlatformUtils.isWeb) {
        const String fileName = 'invite.png';
        final String? path = await getSavePath(suggestedName: fileName);
        if (path == null) {
          return;
        }

        final XFile imageFile = XFile.fromData(sourceBytes, mimeType: "file/image", name: fileName);
        await imageFile.saveTo(path);
        Utils.showToastMsg('保存海报成功');
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
          Utils.showToastMsg('保存海报成功');
        } else {
          Utils.showToastMsg('保存海报失败');
        }
      }
      if (status.isDenied) {
        Utils.showToastMsg('请开启相册权限');
      }
    }
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

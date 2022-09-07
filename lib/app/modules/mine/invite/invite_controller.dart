import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/utils.dart';
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

  GlobalKey repaintWidgetKey = GlobalKey();
  List<Map<String, String>> iconList = [
    {'微信好友': Assets.imagesInviteWechatSession},
    {'朋友圈': Assets.imagesInviteWechatLine},
    {'复制连接': Assets.imagesInviteCopyLink},
    {'生成海报': Assets.imagesInviteDownload},
  ];

  @override
  void onInit() {
    super.onInit();
    initData();
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
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes == null) {
        return;
      }

      shareToWeChat(
        WeChatShareImageModel(WeChatImage.binary(sourceBytes), scene: WeChatScene.SESSION),
      );
    }
  }

  // 分享朋友圈
  shareWechatLine() async {
    RenderObject? obj = repaintWidgetKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes == null) {
        return;
      }

      shareToWeChat(
        WeChatShareImageModel(WeChatImage.binary(sourceBytes), scene: WeChatScene.TIMELINE),
      );
    }
  }

  // 复制连接
  copyLink() {
    // todo
    Clipboard.setData(ClipboardData(text: 'https://register.chuancuibaoku.com?invitationCode=${userHelper.userInfo.value?.invitationCode}'));
  }

  // 保存海报
  savaImage() async {
    RenderObject? obj = repaintWidgetKey.currentContext?.findRenderObject();
    if (obj is RenderRepaintBoundary) {
      double dpr = ui.window.devicePixelRatio; // 获取当前设备的像素比
      var image = await obj.toImage(pixelRatio: dpr);
      ByteData? _byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? sourceBytes = _byteData?.buffer.asUint8List();
      if (sourceBytes == null) {
        return;
      }
      Permission filePermission = Platform.isIOS ? Permission.photos : Permission.storage;
      var status = await filePermission.status;
      if (!status.isGranted) {
        Map<Permission, PermissionStatus> statuses = await [filePermission].request();
        savaImage();
      }
      if (status.isGranted) {
        final result = await ImageGallerySaver.saveImage(sourceBytes, quality: 80);
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

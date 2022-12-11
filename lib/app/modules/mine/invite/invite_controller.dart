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
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class InviteController extends GetxController {
  final pageName = 'Invite'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  var url =
      '${systemSetting.model.value?.sponsoredLinks ?? "https://register.chuancuibaoku.com"}?invitationCode=${userHelper.userInfo.value?.invitationCode}';
  GlobalKey repaintWidgetKey = GlobalKey();
  List<Map<String, String>> iconList = [
    {'微信好友': Assets.imagesInviteWechatSession},
    {'朋友圈': Assets.imagesInviteWechatLine},
    {'复制链接': Assets.imagesInviteCopyLink},
    {'生成海报': Assets.imagesInviteDownload},
  ];

  @override
  void onReady() {
    super.onReady();
    if(Get.arguments?['shareWechatSession'] ?? false) {
      EasyLoading.show();
      Future.delayed(Duration(seconds: 1), () {
        EasyLoading.dismiss();
        shareWechatSession();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    initData();
    if (PlatformUtils.isWeb) {
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
    Uint8List? sourceBytes = await Utils().capturePng(repaintWidgetKey);

    if (sourceBytes != null) {
      shareToWeChat(
        WeChatShareImageModel(WeChatImage.binary(sourceBytes),
            scene: WeChatScene.SESSION),
      );
    }
  }

  // 分享朋友圈
  shareWechatLine() async {
    Uint8List? sourceBytes = await Utils().capturePng(repaintWidgetKey);

    if (sourceBytes != null) {
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
    await Utils().saveImageToFile(repaintWidgetKey);
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

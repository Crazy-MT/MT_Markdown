import 'dart:io';

import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/common.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/sp_const.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sp_util/sp_util.dart';

class SplashController extends GetxController {
  final pageName = 'Splash'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final opacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await SpUtil.getInstance();

    if (!(SpUtil.getBool(SpConst.SHOW_DIALOG, defValue: false) ?? false)) {
      showConfirmDialog(
          barrierDismissible: false,
          title: "个人信息保护指引",
          contentWidget: richText(),
          confirmTextColor: Colors.white,
          onConfirm: () {
            SpUtil.putBool(SpConst.SHOW_DIALOG, true);
            initCommon();
          },
          onCancel: () {
            exit(0);
          });
    } else {
      initCommon();
    }
  }

  RichText richText() {
    return RichText(
      text: TextSpan(
        text:
            "在亿翠珠宝商城为您提供购买及售后支持等服务。在提供服务时需要联网，并基于您的授权调用相机、读取及写入存储器权限，您有权拒绝或取消授权。在使用APP前，请您阅读并充分理解",
        style: TextStyle(
          color: Color(0xFF696873),
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
              text: "《用户服务协议》",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(
                    RoutesID.LOCAL_HTML_PAGE,
                    arguments: {
                      "page_title": "用户注册协议",
                      "html_file":
                          "assets/html/user_registration_protocol.html",
                    },
                  );
                }),
          TextSpan(
              text: "《隐私政策》",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Get.toNamed(
                    RoutesID.LOCAL_WEBVIEW_PAGE,
                    arguments: {
                      "page_title": "用户隐私政策",
                      "html_file": "assets/html/privacy_policy_1.html",
                    },
                  );
                }),
          TextSpan(
              text: "以便了解我们收集、使用、共享和存储信息的情况，以及对信息的保护措施。如你同意，请点击同意的按钮以接受我们的服务。",
              style: TextStyle(
                color: Color(0xFF434446),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }

  void initCommon() {
    common.initCommon().timeout(const Duration(seconds: 3)).then((value) async {
      opacity.value = 1.0;
      if (userHelper.userToken.isEmpty) {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
      } else {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
      }
    }).catchError((e) {
      errorLog(e);
      Get.offNamed(RoutesID.MAIN_TAB_PAGE);
    });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

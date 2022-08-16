import 'dart:async';

import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final pageName = 'Login'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final showClearPhoneInput = false.obs;
  final sendCodeCountDown = 0.obs;
  final isPasswordLogin = false.obs;
  final showPassword = false.obs;
  final agreePrivacyPolicy = false.obs;
  final enableLogin = true.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    initData();
    phoneController.addListener(() {
      showClearPhoneInput.value = phoneController.text.isNotEmpty;
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  login() {
    pageStatus.value = FTStatusPageType.loading;
    Future.delayed(const Duration(seconds: 2)).then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
  }

  startCountDown() {
    if (sendCodeCountDown > 0) {
      return;
    }
    sendCodeCountDown.value = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      sendCodeCountDown.value = sendCodeCountDown.value - 1;
      if (sendCodeCountDown.value == 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    if (timer?.isActive ?? false) {
      timer?.cancel();
    }
  }

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final pageName = 'ResetPassword'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final phoneNumber = "".obs;
  final isForget = false.obs;
  final sendSmsCountdown = 0.obs;
  TextEditingController verifyCodeController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  final showNewPassword = false.obs;
  final showConfirmPassword = false.obs;

  final resetBtnEnable = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    isForget.value = Get.arguments['is_forget'] ?? false;
    phoneNumber.value = Get.arguments['phone_number'] ?? "";
  }

  resetPwd() {}

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

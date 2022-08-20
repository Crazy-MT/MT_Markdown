import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BindRecommendController extends GetxController {
  final pageName = 'BindRecommend'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final sendSmsCountdown = 0.obs;
  final phoneNumber = "".obs;
  TextEditingController verifyCodeController = new TextEditingController();
  TextEditingController recommendCodeController = new TextEditingController();

  final bindBtnEnable = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    phoneNumber.value = userHelper.userInfo.value?.phone ?? "";
  }

  bindRecommendCode() {}

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

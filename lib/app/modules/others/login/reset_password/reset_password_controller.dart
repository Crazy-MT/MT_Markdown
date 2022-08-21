import 'dart:async';

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/model/user_model.dart';
import '../../../../../network/base_model.dart';
import '../../../../../network/l_request.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../../utils/utils.dart';
import '../../user_apis.dart';

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
  Timer? timer;

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

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  startCountDown() {
    if (sendSmsCountdown > 0) {
      return;
    }
    sendSmsCountdown.value = 60;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      sendSmsCountdown.value = sendSmsCountdown.value - 1;
      if (sendSmsCountdown.value == 0) {
        timer.cancel();
      }
    });
  }

  getSMS() async {
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
      url: UserApis.SMS,
      t: UserModel(),
      queryParameters: {
        "phone": phoneNumber.value,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        sendSmsCountdown.value = 0;
        timer?.cancel();
        Utils.showToastMsg("获取验证码失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("获取验证码失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );

    if (_result?.value == null) {
      return;
    }
  }

  resetPwd() async {
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
      url: UserApis.UPDATE_PASSWORD,
      t: UserModel(),
      data: {
        "phone": phoneNumber.value,
          "id": userHelper.userInfo.value?.id,
          "authCode": verifyCodeController.text,
          "password": newPasswordController.text
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        sendSmsCountdown.value = 0;
        timer?.cancel();
        Utils.showToastMsg("重置密码失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("重置密码失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (_) {
        Utils.showToastMsg("重置密码成功");
        Get.back();
      }
    );

    if (_result?.value == null) {
      return;
    }
  }

}

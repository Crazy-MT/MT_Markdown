import 'dart:async';

import 'package:code_zero/app/modules/others/user_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/model/user_model.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

//测试账号 17090311563      密码 123456

class LoginController extends GetxController {
  final pageName = 'Login'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final showClearPhoneInput = false.obs;
  final sendCodeCountDown = 0.obs;
  final isPasswordLogin = true.obs;
  final showPassword = false.obs;
  final agreePrivacyPolicy = false.obs;
  final enableLogin = false.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    initData();
    phoneController.addListener(() {
      showClearPhoneInput.value = phoneController.text.isNotEmpty;
      checkCanLogin();
    });
    passwordController.addListener(() {
      checkCanLogin();
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  login() {
    if (isPasswordLogin.value) {
      _passwordLogin();
    } else {
      _smsCodeLogin();
    }
  }

  checkCanLogin() {
    if (phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        agreePrivacyPolicy.value) {
      enableLogin.value = true;
    } else {
      enableLogin.value = false;
    }
  }

  _passwordLogin() async {
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
      url: UserApis.LOGIN,
      t: UserModel(),
      data: {
        "phone": phoneController.text,
        "password": passwordController.text,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("登录失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("登录失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value == null) {
      return;
    }
    loginSuccess(_result);
  }

  Future<void> loginSuccess(ResultData<UserModel>? _result) async {
    await userHelper.whenLogin(_result!.value!);

    if ((userHelper.userInfo.value?.checkRes ?? 0) != 1) {
      bool result = await Get.toNamed(RoutesID.AUTH_CHECK_PAGE);
      if (!result) {
        return;
      }
    }

    if ((userHelper.userInfo.value?.hasPaymentMethod ?? 0) == 0) {
      await Get.toNamed(RoutesID.COLLECTION_SETTINGS_PAGE, arguments: {'from': RoutesID.LOGIN_PAGE});

      if ((userHelper.userInfo.value?.hasPaymentMethod ?? 0) == 0) {
        return;
      }
    }

    if ((userHelper.userInfo.value?.hasAddress ?? 0) == 0) {
      await Get.toNamed(RoutesID.ADDRESS_MANAGE_PAGE, arguments: {'from': RoutesID.LOGIN_PAGE});
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

  _smsCodeLogin() async {
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
      url: UserApis.PHONE_LOGIN,
      t: UserModel(),
      data: {
        "phone": phoneController.text,
        "authCode": passwordController.text,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("登录失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("登录失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );

    if (_result?.value == null) {
      return;
    }
    loginSuccess(_result);
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

  getSMS() async {
    ResultData<UserModel>? _result = await LRequest.instance.request<UserModel>(
        url: UserApis.SMS,
        t: UserModel(),
        queryParameters: {
          "phone": phoneController.text,
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          sendCodeCountDown.value = 0;
          timer?.cancel();
          Utils.showToastMsg("获取验证码失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取验证码失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (_) {
          startCountDown();
        });

    if (_result?.value == null) {
      return;
    }
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

  void forgetPasswordClick() {
    if (phoneController.value.text.isEmpty) {
      Utils.showToastMsg("请输入手机号");
      return;
    }
    Get.toNamed(
      RoutesID.RESET_PASSWORD_PAGE,
      arguments: {
        "phone_number": phoneController.value.text,
        "is_forget": true,
      },
    );
  }
}

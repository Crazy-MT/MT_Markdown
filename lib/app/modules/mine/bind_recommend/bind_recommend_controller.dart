import 'dart:async';

import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
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

class BindRecommendController extends GetxController {
  final pageName = 'BindRecommend'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final phoneNumber = "".obs;
  TextEditingController verifyCodeController = new TextEditingController();
  TextEditingController recommendCodeController = new TextEditingController();
  final sendCodeCountDown = 0.obs;
  Timer? timer;

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

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
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
        "phone": userHelper.userInfo.value?.phone,
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
      }
    );

    if (_result?.value == null) {
      return;
    }
  }

  bind() async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
      url: UserApis.BIND,
      t: DataModel(),
      data: {
        "phone": userHelper.userInfo.value?.phone,
        'userId': userHelper.userInfo.value?.id,
        'authCode' : verifyCodeController.text,
        'invitationCode' : recommendCodeController.text
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("绑定失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("绑定失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (_) {
        Utils.showToastMsg("绑定成功");
        Get.back();
      }
    );
  }

}

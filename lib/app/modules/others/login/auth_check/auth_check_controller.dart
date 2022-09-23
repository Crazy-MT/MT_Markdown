import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

import '../../../../../network/base_model.dart';
import '../../../../../network/l_request.dart';
import '../../../../../utils/utils.dart';
import '../../user_apis.dart';

class AuthCheckController extends GetxController {
  final pageName = 'AuthCheck'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idCodeController = new TextEditingController();
  final showClearPhoneInput = false.obs;
  final showClearIdInput = false.obs;
  final sendCodeCountDown = 0.obs;
  final isPasswordLogin = false.obs;
  final showPassword = false.obs;
  final agreePrivacyPolicy = false.obs;
  final enableConfirm = false.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    nameController.addListener(() {
      showClearPhoneInput.value = nameController.text.isNotEmpty;
      checkCanConfirm();
    });
    idCodeController.addListener(() {
      showClearIdInput.value = idCodeController.text.isNotEmpty;
      checkCanConfirm();
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> check() async {
    var userId = userHelper.userInfo.value?.id;
    if (userId == null) {
      Get.back(result: false);
      return;
    }

    var params = {
      "name": nameController.text,
      "idCard": idCodeController.text,
      "userId": userId,
    };

    ResultData? _result = await LRequest.instance.request(
      url: UserApis.IDENTITIY_CHECK,
      data: params,
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("核验失败：${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (ret) {
        userHelper.userInfo.value?.checkRes = 1;
        userHelper.whenLogin(userHelper.userInfo.value!);
        Get.back(result: true);
      }
    );
  }

  checkCanConfirm() {
    if (nameController.text.isNotEmpty && idCodeController.text.isNotEmpty) {
      enableConfirm.value = true;
    } else {
      enableConfirm.value = false;
    }
  }
}

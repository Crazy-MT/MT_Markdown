import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

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

  void check() {
    Get.back(result: true);
  }

  checkCanConfirm() {
    if (nameController.text.isNotEmpty &&
        idCodeController.text.isNotEmpty) {
      enableConfirm.value = true;
    } else {
      enableConfirm.value = false;
    }
  }
}

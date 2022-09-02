import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/common.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:get/get.dart';

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

  initData() {
    LRequest.instance.init();
    pageStatus.value = FTStatusPageType.success;
    common.initCommon().timeout(const Duration(seconds: 3)).then((value) async {
      opacity.value = 1.0;
      if (userHelper.userToken.isEmpty) {
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
      } else {
        Future.delayed(const Duration(seconds: 1)).then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
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

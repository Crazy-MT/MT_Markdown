import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final pageName = 'Login'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  login() {
    pageStatus.value = FTStatusPageType.loading;
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/common.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/model/user_model.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';

import '../user_apis.dart';

class SplashController extends GetxController {
  final pageName = 'Splash'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    LRequest.instance.init();
    pageStatus.value = FTStatusPageType.success;
    common.initCommon().timeout(const Duration(seconds: 3)).then((value) async {
      if (userHelper.userToken.isEmpty) {
        Future.delayed(const Duration(seconds: 1))
            .then((value) => Get.offNamed(RoutesID.MAIN_TAB_PAGE));
      } else {
        ResultData<UserModel>? _result = await LRequest.instance
            .request<UserModel>(
          url: UserApis.GET_INFO,
          t: UserModel(),
          requestType: RequestType.GET,
          handleBaseModel: (_) {
            if (_.status != 200) {
              Utils.showToastMsg("自动登录失败：${_.message}");
              Get.offNamed(RoutesID.MAIN_TAB_PAGE);
            }
          },
        )
            .catchError((e) {
          Get.offNamed(RoutesID.MAIN_TAB_PAGE);
        });
        if (_result?.value == null) {
          Get.offNamed(RoutesID.MAIN_TAB_PAGE);
          return;
        }
        userHelper.whenLogin(_result!.value!);
        Get.offAllNamed(RoutesID.MAIN_TAB_PAGE);
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

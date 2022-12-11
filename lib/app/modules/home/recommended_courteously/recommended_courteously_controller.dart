import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class RecommendedCourteouslyController extends GetxController {
  final pageName = 'RecommendedCourteously'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getSystemSetting();
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> getSystemSetting() async {
    if(systemSetting.model.value == null) {
      await systemSetting.initSystemSetting();
    }

    lLog('MTMTMT RecommendedCourteouslyController.getSystemSetting ${systemSetting.model.value?.fromUserReward} ${systemSetting.model.value?.toUserReward} ');
  }
}

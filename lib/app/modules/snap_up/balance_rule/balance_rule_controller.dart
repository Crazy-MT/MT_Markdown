import 'package:code_zero/app/modules/snap_up/balance_rule/balance_apis.dart';
import 'package:code_zero/app/modules/snap_up/balance_rule/model/rule_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class BalanceRuleController extends GetxController {
  final pageName = 'BalanceRule'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<RuleModel?> ruleModel = Rx<RuleModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getRule();
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  getRule() {
    LRequest.instance.request<RuleModel>(
        url: BalanceRuleApis.RULE,
        t: RuleModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取提现说明失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取提现说明失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          // var model = result.value;
          ruleModel.value = result.value;
        });
  }
}

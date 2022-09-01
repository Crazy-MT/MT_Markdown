import 'package:code_zero/app/modules/mine/income_list/income_apis.dart';
import 'package:code_zero/app/modules/mine/income_list/model/statistics_model.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';

class IncomeListController extends GetxController {
  final pageName = 'IncomeList'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<String> incomeList = RxList<String>();
  Rx<StatisticsModel?> model = Rx<StatisticsModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getStatistics();
    initIncomeList();
  }

  initIncomeList() {
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
    incomeList.add("item");
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> getStatistics() async {
    ResultData<StatisticsModel>? _result = await LRequest.instance.request<StatisticsModel>(
        url: IncomeApis.STATISTICS,
        queryParameters: {
          "user-id": userHelper.userInfo.value?.id
        },
        t: StatisticsModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取收益失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取收益失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          // print('MTMTMT BuyerOrderController.cancelOrder ${rest} ');
          // Utils.showToastMsg("获取收益");
          model.value = rest.value;
        }
    );
  }
}

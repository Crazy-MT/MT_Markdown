import 'package:code_zero/app/modules/mine/income_list/income_apis.dart';
import 'package:code_zero/app/modules/mine/income_list/model/income_model.dart';
import 'package:code_zero/app/modules/mine/income_list/model/statistics_model.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IncomeListController extends GetxController {
  final pageName = 'IncomeList'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<StatisticsModel?> model = Rx<StatisticsModel?>(null);
  RxList<IncomeItems> incomeList = RxList<IncomeItems>();
  final RefreshController refreshController = new RefreshController();
  int currentPage = 1;
  int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getStatistics();
    getIncomeList();
  }

  getIncomeList({bool isRefresh = true}) async {
    if(isRefresh) {
      currentPage = 1;
    }
    ResultData<IncomeModel>? _result = await LRequest.instance.request<IncomeModel>(
        url: IncomeApis.INCOME_LIST,
        t: IncomeModel(),
        queryParameters: {
          "user-id": userHelper.userInfo.value?.id,
          "page": currentPage,
          "size": pageSize,
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          refreshController.refreshFailed();
          Utils.showToastMsg("获取收益列表失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取收益列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }

          if(isRefresh) {
            incomeList.value = [];
          } else {
            currentPage++;
          }

          incomeList.addAll(model.items!);

          refreshController.refreshCompleted();
          refreshController.loadComplete();
          if(model.totalCount! <= incomeList.length) {
            refreshController.loadNoData();
          }
        });
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

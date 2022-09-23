import 'package:code_zero/app/modules/mine/wallet/transactions/model/balance_model.dart';
import 'package:code_zero/app/modules/mine/wallet/transactions/transactions_apis.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TransactionsController extends GetxController {
  final pageName = 'Transactions'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<BalanceItems> balanceList = RxList<BalanceItems>();

  int currentPage = 1;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getBalanceList();
  }

  getBalanceList({bool isRefresh = true}) async {
    if(isRefresh) {
      currentPage = 1;
    }
    await LRequest.instance.request<BalanceModel>(
        url: TransactionsApis.LIST,
        t: BalanceModel(),
        isShowLoading: false,
        queryParameters: {
          "status": 2,
          "page": currentPage,
          "size": pageSize,
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          refreshController.refreshFailed();
          Utils.showToastMsg("获取提现记录失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取提现记录失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }
          if(isRefresh) {
            balanceList.clear();
          } else {
          }
          currentPage++;

          balanceList.addAll(model.items!);
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if(model.totalCount! <= balanceList.length) {
            refreshController.loadNoData();
          }
        });
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

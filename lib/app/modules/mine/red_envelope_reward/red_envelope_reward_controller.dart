import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RedEnvelopeRewardController extends GetxController {
  final pageName = 'RedEnvelopeReward'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<OrderItem?> orderList = RxList<OrderItem?>();
  int currentPage = 1;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
    getOrder(true);
  }

  getOrder(bool isRefresh) async {
    int prePageIndex = currentPage;
    if (isRefresh) {
      currentPage = 1;
    } else {
      currentPage++;
    }

    Map<String, dynamic>? queryParameters = {};
    queryParameters = {
      "page": currentPage,
      "size": 10,
      "trade-state-list": '0,1,2,3,4,5,6,7,8,9',
      "to-user-from-user-id": userHelper.userInfo.value?.id
    };

    ResultData<OrderListModel>? _result = await LRequest.instance.request<
        OrderListModel>(
      url: SnapApis.ORDER_LIST,
      queryParameters: queryParameters,
      t: OrderListModel(),
      isShowLoading: false,
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? currentPage = prePageIndex : currentPage--;
      },
    );
    if (_result?.value != null) {
      lLog('MTMTMT BuyerOrderController.getOrder ${orderList.value.length} ');
      if(isRefresh) {
        orderList.clear();
      }
      isRefresh
          ? orderList.value = _result?.value?.items ?? []
          : orderList.addAll(_result?.value?.items ?? []);
      orderList.refresh();
    }

    if (isRefresh) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    } else {
      if ((_result?.value?.items ?? []).isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    }
  }


  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

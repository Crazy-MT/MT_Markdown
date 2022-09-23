import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyCommissionController extends GetxController {
  final pageName = 'MyCommission'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  Rx<WalletModel?> model = Rx<WalletModel?>(null);
  int currentPage = 1;
  final RefreshController refreshController = new RefreshController();
  RxList<OrderItem?> orderList = RxList<OrderItem?>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
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


  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  String getTradeState(tradeState) {

    /// 0->待付款、
    // 1->待收款、
    // 2->已付款、
    // 3->待上架、
    // 4->已上架、
    // 5->待发货、
    // 6->待收货、
    // 7->已收货、
    // 8->已取消、
    switch (tradeState) {
      case 0:
        return "待付款";
      case 1:
        return "待卖方确认收款";
      case 2:
        return "已付款";
      case 3:
        return "待上架";
      case 4:
        return "已上架";
      case 5:
        return "待发货";
      case 6:
        return "待收货";
      case 7:
        return "已收货";
      case 8:
        return "已取消";
    }
    return "其它方式";
  }

}

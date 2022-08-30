import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/order_tab_info.dart';

class BuyerOrderController extends GetxController with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final List<OrderTabInfo> myTabs = <OrderTabInfo>[
    OrderTabInfo(Tab(text: '我的仓库'), -1, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '待付款'), 0, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '已付款'), 2, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '待上架'), 3, RefreshController(), 1, RxList<OrderItem>()),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController?.index = Get.arguments['index'] as int;
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        print("点击了下标为${tabController?.index}的tab");
      }
    });
    initAllData();
  }

  initAllData() async {
    pageStatus.value = FTStatusPageType.loading;
    await Future.forEach<OrderTabInfo>(myTabs, (element) async {
      await getOrder(true, element);
    }).catchError((e) {
      errorLog(e);
      pageStatus.value = FTStatusPageType.success;
    });
    pageStatus.value = FTStatusPageType.success;
  }

  getOrder(bool isRefresh, OrderTabInfo tabInfo) async {
    int prePageIndex = tabInfo.currentPage;
    if (isRefresh) {
      tabInfo.currentPage = 1;
    } else {
      tabInfo.currentPage++;
    }
    ResultData<OrderListModel>? _result = await LRequest.instance.request<OrderListModel>(
      url: SnapApis.ORDER_LIST,
      queryParameters: {
        "to-user-id": userHelper.userInfo.value?.id,
        "page": tabInfo.currentPage,
        "size": 10,
        "trade-state": tabInfo.tradeState,
      },
      t: OrderListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? tabInfo.currentPage = prePageIndex : tabInfo.currentPage--;
      },
    );
    if (_result?.value != null) {
      isRefresh ? tabInfo.orderList.value = _result?.value?.items ?? [] : tabInfo.orderList.addAll(_result?.value?.items ?? []);
    }

    if (isRefresh) {
      tabInfo.refreshController.refreshCompleted();
      tabInfo.refreshController.loadComplete();
    } else {
      if ((_result?.value?.items ?? []).isEmpty) {
        tabInfo.refreshController.loadNoData();
      } else {
        tabInfo.refreshController.loadComplete();
      }
    }
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

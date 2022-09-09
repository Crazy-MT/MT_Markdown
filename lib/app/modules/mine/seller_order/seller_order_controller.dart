import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/order_list_model.dart';
import '../model/order_tab_info.dart';

class SellerOrderController extends GetxController with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final List<OrderTabInfo> myTabs = <OrderTabInfo>[
    /// 卖家
    // 我的仓库是 =4(已上架) 待收款=0（待付款）待确认=1（待收款）已完成=4,7,8（已上架、已收货、已取消）
    OrderTabInfo(Tab(text: '我的仓库'), 4, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '待收款'), 0, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '待确认'), 1, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(Tab(text: '已完成'), -1, RefreshController(), 1, RxList<OrderItem>()),
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
        getOrder(true, myTabs[tabController?.index ?? 0]);
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
    Map<String, dynamic>? queryParameters = {};
    queryParameters = tabInfo.tradeState == -1 ? {
      "from-user-id": userHelper.userInfo.value?.id,
      "page": tabInfo.currentPage,
      "size": 10,
      "trade-state-list": "2,3,4,5,6,7",
      "start-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']),
      "end-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
    } : {
      "from-user-id": userHelper.userInfo.value?.id,
      "page": tabInfo.currentPage,
      "size": 10,
      "trade-state": tabInfo.tradeState,
    };
    if(tabInfo.tradeState == 4) {
      queryParameters = {
        "to-user-id": userHelper.userInfo.value?.id,
        "page": tabInfo.currentPage,
        "size": 10,
        "trade-state": tabInfo.tradeState,
        "start-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']),
        "end-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
      };
    }
    ResultData<OrderListModel>? _result = await LRequest.instance.request<OrderListModel>(
      url: SnapApis.ORDER_LIST,
      queryParameters: queryParameters,
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

  /// 确认收款
  Future<void> confirmOrder(int id) async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.CONFIRM_RECEIPT_ORDER,
        data: {
          "id": id
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("确认收款失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("确认收款失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          // print('MTMTMT BuyerOrderController.cancelOrder ${rest} ');
          Utils.showToastMsg("确认收款成功");
          initAllData();
        }
    );
  }

  String getTradeState(tradeState) {
    if(tabController?.index == 3) {
      return "已转卖";
    }
    if(tabController?.index == 2) {
      return "待收款";
    }
    if(tabController?.index == 1) {
      return "待确认";
    }
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
        return "待收款";
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

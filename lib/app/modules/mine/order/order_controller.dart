import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:code_zero/app/modules/mine/order/model/self_order_tab_info.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final editStatus = 0.obs;

  final List<SelfOrderTabInfo> myTabs = <SelfOrderTabInfo>[
    SelfOrderTabInfo(
        Tab(text: '全部'), 0, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待付款'), 1, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待发货'), 2, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待收货'), 3, RefreshController(), 1, RxList<SelfOrderItems>()),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController?.index = Get.arguments['index'] as int;
    _settingEditStatus();
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // print("点击了下标为${tabController?.index}的tab");
        _settingEditStatus();
        getOrder(true, myTabs[tabController?.index ?? 0]);
      }
    });
    initAllData();
  }

  _settingEditStatus() {
    if (tabController?.index == 1) {
      /// todo 暂时不做合单支付
      // this.editStatus.value = 1;
    } else {
      this.editStatus.value = 0;
    }
  }

  initAllData() async {
    pageStatus.value = FTStatusPageType.loading;
    await Future.forEach<SelfOrderTabInfo>(myTabs, (element) async {
      await getOrder(true, element);
    }).catchError((e) {
      errorLog(e.toString());
      pageStatus.value = FTStatusPageType.success;
    });
    pageStatus.value = FTStatusPageType.success;
  }

  getOrder(bool isRefresh, SelfOrderTabInfo tabInfo) async {
    int prePageIndex = tabInfo.currentPage;
    if (isRefresh) {
      tabInfo.currentPage = 1;
    } else {
      tabInfo.currentPage++;
    }

    Map<String, dynamic>? queryParameters = {
      "userId": userHelper.userInfo.value?.id,
      "page": tabInfo.currentPage,
      "size": 10,
    };
    if(tabInfo.tradeState == 0) {
      queryParameters["tradeStateList"] = '1,2,3,4,5,6,7,8,9';
    }
    if(tabInfo.tradeState == 1) {
      queryParameters["tradeStateList"] = '3,6';
    }
    if(tabInfo.tradeState == 2) {
      queryParameters["tradeStateList"] = '8';
    }

    if(tabInfo.tradeState == 3) {
      queryParameters["tradeStateList"] = '9';
    }

    ResultData<SelfOrderListModel>? _result = await LRequest.instance.request<
        SelfOrderListModel>(
      url: SnapApis.SELF_ORDER_LIST,
      queryParameters: queryParameters,
      t: SelfOrderListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? tabInfo.currentPage = prePageIndex : tabInfo.currentPage--;
      },
    );
    if (_result?.value != null) {
      lLog('MTMTMT BuyerOrderController.getOrder ${tabInfo.orderList.value.length} ');
      if(isRefresh) {
        tabInfo.orderList.clear();
      }
      isRefresh
          ? tabInfo.orderList.value = _result?.value?.items ?? []
          : tabInfo.orderList.addAll(_result?.value?.items ?? []);
      lLog('MTMTMT BuyerOrderController.getOrder ${tabInfo.orderList.value.length} ');
      tabInfo.orderList.refresh();
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

  String getTradeState(tradeState) {
    if(tabController?.index == 3) {
      return "待收货";
    }
    if(tabController?.index == 2) {
      return "待发货";
    }
    if(tabController?.index == 1) {
      return "待付款";
    }

    switch (tradeState) {
      case 0:
        return "未支付";
      case 1:
        return "支付成功";
      case 2:
        return "转入退款";
      case 3:
        return "未支付";
      case 4:
        return "已关闭";
      case 5:
        return "已撤销";
      case 6:
        return "用户支付中";
      case 7:
        return "支付失败";
      case 8:
        return "代发货";
      case 9:
        return "已发货";
    }
    return "其它方式";
  }

  void cancelOrder(int? id) {}

  void pay(int? id) {}

  void shouhuo(int? id) {}
}

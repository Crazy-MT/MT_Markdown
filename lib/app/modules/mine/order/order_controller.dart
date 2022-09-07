import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../model/order_list_model.dart';
import '../model/order_tab_info.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final editStatus = 0.obs;

  final List<OrderTabInfo> myTabs = <OrderTabInfo>[
    /// 卖家
    // 我的仓库是 =4(已上架) 待收款=0（待付款）待确认=1（待收款）已完成=4,7,8（已上架、已收货、已取消）
    OrderTabInfo(
        Tab(text: '全部'), 4, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '待付款'), 0, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '待发货'), 1, RefreshController(), 1, RxList<OrderItem>()),
    OrderTabInfo(
        Tab(text: '待收货'), -1, RefreshController(), 1, RxList<OrderItem>()),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    initData();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController?.index = Get.arguments['index'] as int;
    _settingEditStatus();
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // print("点击了下标为${tabController?.index}的tab");
        _settingEditStatus();
      }
    });
  }

  _settingEditStatus() {
    if (tabController?.index == 1) {
      this.editStatus.value = 1;
    } else {
      this.editStatus.value = 0;
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

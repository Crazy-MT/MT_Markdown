import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final editStatus = 0.obs;
  final List<Tab> myTabs = <Tab>[
    Tab(text: '全部'),
    Tab(text: '待付款'),
    Tab(text: '待发货'),
    Tab(text: '待收货'),
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
        print("点击了下标为${tabController?.index}的tab");
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

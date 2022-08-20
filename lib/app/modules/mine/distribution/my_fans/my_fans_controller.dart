import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class MyFansController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'MyFans'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<String> commissionList = RxList<String>();

  List<String> tabList = ['一组', '二组'];
  TabController? tabController;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initTab();
    initCommissionList();
  }

  initCommissionList() {
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
    commissionList.add("item");
  }

  initTab() {
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    // tabController?.index = Get.arguments['index'] as int;
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        currentIndex = tabController?.index == 0 ? 0.obs : 1.obs;
      }
    });
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

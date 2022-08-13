import 'package:code_zero/app/modules/home/home_page.dart';
import 'package:code_zero/app/modules/snap_up/snap_up_page.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mine/mine_page.dart';
import '../shopping_cart/shopping_cart_page.dart';

class MainTabController extends GetxController {
  final pageName = 'MainTab'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  var tabs = <_HomeTabInfo>[];
  var currentTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initTab();
  }

  initTab() {
    tabs.add(
      _HomeTabInfo(
        index: 0,
        title: '首页',
        icon: const Icon(Icons.home_rounded),
        tabPage: const HomePage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 1,
        title: '报表',
        icon: const Icon(Icons.upcoming_rounded),
        tabPage: const SnapUpPage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 2,
        title: '购物车',
        icon: const Icon(Icons.shopping_cart_rounded),
        tabPage: const ShoppingCartPage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 3,
        title: '我的',
        icon: const Icon(Icons.person_rounded),
        tabPage: const MinePage(),
        clickTabItem: clickTab,
      ),
    );
  }

  clickTab(index) {
    currentTab.value = index;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _HomeTabInfo {
  final int index;
  final Widget icon;
  final String title;
  final ValueChanged<int>? clickTabItem;
  final Widget tabPage;

  _HomeTabInfo({
    required this.index,
    required this.icon,
    required this.title,
    required this.clickTabItem,
    required this.tabPage,
  });
}

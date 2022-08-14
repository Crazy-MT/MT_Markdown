import 'package:code_zero/app/modules/home/home_page.dart';
import 'package:code_zero/app/modules/snap_up/snap_up_page.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
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
        icon: Assets.iconsHome,
        selectIcon: Assets.iconsHomeSelect,
        tabPage: const HomePage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 1,
        title: '抢购',
        icon: Assets.iconsSnapUp,
        selectIcon: Assets.iconsSnapUpSelect,
        tabPage: const SnapUpPage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 2,
        title: '购物车',
        icon: Assets.iconsShoppingCart,
        selectIcon: Assets.iconsShoppingCartSelect,
        tabPage: const ShoppingCartPage(),
        clickTabItem: clickTab,
      ),
    );
    tabs.add(
      _HomeTabInfo(
        index: 3,
        title: '我的',
        icon: Assets.iconsMine,
        selectIcon: Assets.iconsMineSelect,
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
  final String icon;
  final String selectIcon;
  final String title;
  final ValueChanged<int>? clickTabItem;
  final Widget tabPage;

  _HomeTabInfo({
    required this.index,
    required this.icon,
    required this.selectIcon,
    required this.title,
    required this.clickTabItem,
    required this.tabPage,
  });
}

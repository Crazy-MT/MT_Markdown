import 'dart:ui';

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../common/colors.dart';
import '../../../routes/app_routes.dart';

class DistributionController extends GetxController {
  final pageName = 'Distribution'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<_MenuItem> menuList = RxList<_MenuItem>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initMenuList();
  }

  initMenuList() {
    menuList.add(_MenuItem(
        title: "我的佣金",
        onClick: () {
          Get.toNamed(RoutesID.MY_COMMISSION_PAGE);
        }));
    menuList.add(_MenuItem(
        title: "提现记录",
        showDivider: false,
        onClick: () {
          Get.toNamed(RoutesID.TRANSACTIONS_PAGE);
        }));
    menuList.add(_MenuItem(
      title: "我的粉丝",
      showTopDivider: true,
      onClick: () {
        Get.toNamed(RoutesID.MY_FANS_PAGE);
      },
    ));
    menuList.add(_MenuItem(
        title: "粉丝订单",
        showDivider: false,
        onClick: () {
          Get.toNamed(RoutesID.FANS_ORDER_PAGE);
        }));
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _MenuItem {
  final String title;
  final bool showArrow;
  final bool showDivider;
  final bool showTopDivider;
  final bool isCenter;
  final VoidCallback? onClick;
  final Color titleColor;

  _MenuItem({
    required this.title,
    this.showArrow = true,
    this.showDivider = true,
    this.showTopDivider = false,
    this.isCenter = false,
    this.onClick,
    this.titleColor = AppColors.text_dark,
  });
}

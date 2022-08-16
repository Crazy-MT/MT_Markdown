import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final pageName = 'Setting'.obs;
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
    menuList.add(_MenuItem(title: "编辑资料"));
    menuList.add(_MenuItem(title: "收货地址管理", showDivider: false));
    menuList.add(_MenuItem(title: "修改登录密码", showTopDivider: true));
    menuList.add(_MenuItem(title: "支付密码管理", showDivider: false));

    menuList.add(_MenuItem(title: "功能反馈", showTopDivider: true));
    menuList.add(_MenuItem(title: "C2C个人支付风险提示"));
    menuList.add(_MenuItem(title: "委托寄售服务协议"));
    menuList.add(_MenuItem(title: "用户需知"));
    menuList.add(_MenuItem(title: "用户隐私政策"));
    menuList.add(_MenuItem(title: "注销账号"));

    menuList.add(_MenuItem(
      title: "退出登录",
      showTopDivider: true,
      showDivider: false,
      isCenter: true,
      titleColor: Color(0xFFFF3939),
      showArrow: false,
    ));
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

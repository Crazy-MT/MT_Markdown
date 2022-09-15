import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
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
    menuList.add(_MenuItem(
        title: "编辑资料",
        onClick: () {
          Get.toNamed(RoutesID.USER_INFORMATION_PAGE);
        }));
    // menuList.add(_MenuItem(title: "收货地址管理", showDivider: false));
    menuList.add(_MenuItem(
      title: "修改登录密码",
      showTopDivider: false,
      onClick: _toResetPasswordPage,
    ));
    // menuList.add(_MenuItem(title: "支付密码管理", showDivider: false));

   /* menuList.add(
      _MenuItem(
        title: "申诉反馈",
        showTopDivider: false,
        onClick: () {
          Get.toNamed(RoutesID.COMPLAINT_FEEDBACK_PAGE);
        },
      ),
    );*/
    menuList.add(_MenuItem(
        title: "C2C个人支付风险提示",
        onClick: () {
          Get.toNamed(RoutesID.C2C_RISK_PAGE);
        }));
    menuList.add(_MenuItem(
        title: "委托寄售服务协议",
        onClick: () {
          Get.toNamed(
            RoutesID.LOCAL_HTML_PAGE,
            arguments: {
              "page_title": "委托寄售服务协议",
              "html_file": "assets/html/sell_policy.html",
            },
          );
        }));
    menuList.add(_MenuItem(
      title: "用户须知",
      onClick: () {
        Get.toNamed(
          RoutesID.LOCAL_HTML_PAGE,
          arguments: {
            "page_title": "用户须知",
            "html_file": "assets/html/user_instructions.html",
          },
        );
      },
    ));
    menuList.add(
      _MenuItem(
        title: "用户隐私政策",
        onClick: () {
          Get.toNamed(
            RoutesID.LOCAL_HTML_PAGE,
            arguments: {
              "page_title": "用户隐私政策",
              "html_file": "assets/html/privacy_policy.html",
            },
          );
        },
      ),
    );
    menuList.add(_MenuItem(
        title: "注销账号",
        onClick: () {
          showConfirmDialog(
            content: "确认注销账号吗?",
            confirmTextColor: Colors.white,
            onConfirm: () {
              //TODO
              // Get.back();
            },
          );
        }));

    menuList.add(
      _MenuItem(
        title: "退出登录",
        showTopDivider: true,
        showDivider: false,
        isCenter: true,
        titleColor: Color(0xFFFF3939),
        showArrow: false,
        onClick: _logout,
      ),
    );
  }

  _toResetPasswordPage() {
    Get.toNamed(RoutesID.RESET_PASSWORD_PAGE, arguments: {
      'is_forget': false,
      'phone_number': userHelper.userInfo.value?.phone ?? "",
    });
  }

  _logout() async {
    // Get.offAllNamed(RoutesID.MAIN_TAB_PAGE, arguments: {'tabIndex': 3});

    // return;
    bool result = await showConfirmDialog(
      content: "确定退出登录吗？",
    );
    if (result) {
      userHelper.whenLogout();
      Get.back();
    }
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

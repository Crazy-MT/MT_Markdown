import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class UserInformationController extends GetxController {
  final pageName = 'UserInformation'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<_MenuItem> menuList = RxList<_MenuItem>();

  @override
  void onInit() {
    super.onInit();
    initData();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  initMenuList() {
    menuList.add(_MenuItem(
        title: "头像",
        height: 84.w,
        image:
            'https://img2.baidu.com/it/u=2748570125,2275954945&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=489'));
    menuList.add(_MenuItem(
        title: "用户名",
        canEdit: true,
        subTitle: '翡翠爱好者',
        subTitleColor: AppColors.text_dark));
    menuList.add(_MenuItem(
        title: "性别", subTitle: '男', subTitleColor: AppColors.text_dark));
    menuList.add(_MenuItem(title: "生日", subTitle: '请选择出生日期'));
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _MenuItem {
  final String title;
  final String? subTitle;
  final String? image;
  final double height;
  final bool showDivider;
  final bool canEdit;
  final VoidCallback? onClick;
  final Color titleColor;
  final Color subTitleColor;

  _MenuItem({
    required this.title,
    this.subTitle,
    this.image,
    this.height = 50,
    this.showDivider = true,
    this.canEdit = false,
    this.onClick,
    this.titleColor = AppColors.text_dark,
    this.subTitleColor = AppColors.text_light,
  });
}

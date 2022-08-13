import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'main_tab_controller.dart';

class MainTabPage extends GetView<MainTabController> {
  const MainTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => Scaffold(
            bottomNavigationBar: _buildBottomAppBar(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: IndexedStack(
              index: controller.currentTab.value,
              children: controller.tabs.map((tab) {
                return tab.tabPage;
              }).toList(),
            ),
          )),
    );
  }

  Widget _buildBottomAppBar() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 64.w,
      ),
      child: BottomAppBar(
        notchMargin: 6.w,
        elevation: 6.0.w,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.tabs
              .map(
                (e) => IconButton(
                  icon: e.icon,
                  color: e.index == controller.currentTab.value
                      ? AppColors.cyan
                      : AppColors.gray_light,
                  onPressed: () {
                    e.clickTabItem?.call(e.index);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

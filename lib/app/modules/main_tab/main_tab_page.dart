import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
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
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.tabs
              .map(
                (e) => SafeTapWidget(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.w,
                      ),
                      Image.asset(
                        e.index == controller.currentTab.value ? e.selectIcon : e.icon,
                        width: 22.w,
                        height: 22.w,
                      ),
                      Text(
                        e.title,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                  onTap: () {
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

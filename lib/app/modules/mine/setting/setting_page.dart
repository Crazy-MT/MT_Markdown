import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_controller.dart';

class SettingPage extends GetView<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "设置",
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                _buildUserHeader(),
                _buildMenuList(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildUserHeader() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.all(20.w).copyWith(bottom: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: Image.asset(
                    Assets.iconsMineUser,
                    width: 60.w,
                    height: 69.w,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "翡翠爱好者",
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Text(
                      "19910736696",
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  _buildMenuList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          return _buildMenuItem(index);
        },
        childCount: controller.menuList.length,
      ),
    );
  }

  _buildMenuItem(index) {
    var item = controller.menuList[index];
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (item.showTopDivider) _buildDivider(height: 10.w),
          SafeTapWidget(
            onTap: () {
              item.onClick?.call();
            },
            child: Container(
              height: 50.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      textAlign: item.isCenter ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        color: item.titleColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  item.showArrow
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFABAAB9),
                          size: 18.w,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          if (item.showDivider) _buildDivider(),
        ],
      ),
    );
  }

  _buildDivider({height = 1.0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      height: height,
      color: Color(0xFFF5F5F5),
    );
  }
}

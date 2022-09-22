import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/user_helper.dart';
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
            child: Obx(() => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: userHelper.userInfo
                        .value?.avatarUrl ??
                        "",
                    width: 60.w,
                    fit: BoxFit.fill,
                    height: 60.w,
                    errorWidget: (_, __, ___) {
                      return Image.asset(Assets
                          .iconsAvatarPlaceholder);
                    },
                    placeholder: (_, __) {
                      return Image.asset(Assets
                          .iconsAvatarPlaceholder);
                    },
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userHelper.userInfo
                          .value?.nickname ?? "",
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
                      userHelper.userInfo
                          .value?.phone ?? "",
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            )),
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

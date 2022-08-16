import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'user_information_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserInformationPage extends GetView<UserInformationController> {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: CommonAppBar(
        titleText: "编辑资料",
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
                _buildMenuList(),
                SliverToBoxAdapter(child: _buildConfirmButton()),
              ],
            );
          },
        ),
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
              height: item.height,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: item.titleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: item.subTitle != null
                        ? CommonInput(
                            // controller: controller,
                            enable: item.canEdit,
                            fillColor: Colors.transparent,
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: item.subTitleColor,
                            ),
                            hintText: item.subTitle,
                            textAlign: TextAlign.end,
                          )
                        : SizedBox(),
                  ),
                  item.image != null
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: item.image!,
                            width: 60.w,
                            height: 60.w,
                          ),
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

  _buildConfirmButton() {
    return Container(
      margin: EdgeInsets.all(20.w),
      alignment: Alignment.center,
      height: 44.w,
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(22.w),
      ),
      child: Text(
        '确认修改',
        style: TextStyle(
          color: AppColors.text_dark,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

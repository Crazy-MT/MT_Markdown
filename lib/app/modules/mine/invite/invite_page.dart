import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'invite_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitePage extends GetView<InviteController> {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FTStatusPage(
        // physics: NeverScrollableScrollPhysics(),
        type: controller.pageStatus.value,
        errorMsg: controller.errorMsg.value,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            color: Color(0xff2A3435),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 25.h,
                ),
                _userInfoWidget(),
                SizedBox(height: 12.5.h),
                _cardWidget(),
                SizedBox(height: 27.h),
                Expanded(
                  child: _sharePlatformWidget(),
                  flex: 1,
                ),
                Expanded(child: _closeWidget(context), flex: 2)
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _userInfoWidget() {
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userHelper.userInfo.value?.avatarUrl ?? "",
            width: 25.w,
            height: 25.w,
          ),
        ),
        SizedBox(width: 5.w),
        Text(
          '翡翠爱好者邀您注册传翠，邀请码: ',
          style: TextStyle(
            color: Color(0xffffffff),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          ' 1RTWET',
          style: TextStyle(
            color: AppColors.green,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _cardWidget() {
    return RepaintBoundary(
      key: controller.repaintWidgetKey,
      child: Stack(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(10.w),
            child: Image.asset(
              Assets.imagesInvitePosterTemplate,
              // width: double.infinity,
              height: 480.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            right: 15.w,
            bottom: 15.w,
            child: Column(
              children: [
                QrImage(
                  data: 'www.baidu.com',
                  size: 60.w,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  gapless: false,
                ),
                SizedBox(height: 8.w),
                Text(
                  '扫码即可注册',
                  style: TextStyle(
                    color: Color(0xffBAEED8),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sharePlatformWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: controller.iconList.map((Map<String, String> item) {
        return SafeTapWidget(
          onTap: () {
            if (item.keys.first == '微信好友') {
              controller.shareWechatSession();
            } else if (item.keys.first == '朋友圈') {
              controller.shareWechatLine();
            } else if (item.keys.first == '复制链接') {
              controller.copyLink();
            } else if (item.keys.first == '生成海报') {
              controller.savaImage();
            }
          },
          child: Column(
            children: [
              Image.asset(
                item.values.first,
                width: 44.w,
                height: 44.w,
              ),
              SizedBox(height: 6.w),
              Text(
                item.keys.first,
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _closeWidget(BuildContext context) {
    return SafeTapWidget(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        Assets.imagesInviteCloseIcon,
        width: 22.w,
        height: 22.w,
      ),
    );
  }
}

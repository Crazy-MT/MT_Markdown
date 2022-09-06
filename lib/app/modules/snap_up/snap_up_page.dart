import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/snap_up/model/session_model.dart';
import 'package:code_zero/app/modules/snap_up/widget/snap_up_item_title.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/S.dart';
import 'snap_up_controller.dart';

class SnapUpPage extends GetView<SnapUpController> {
  const SnapUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          enablePullUp: true,
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: () {
            controller.getSnapUpList();
          },
          onLoading: () {
            controller.getSnapUpList(isRefresh: false);
          },
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(),
                _buildHeaderContainer(),
                _buildListDivider(),
                _buildSnapUpList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _rightManage() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RoutesID.BALANCE_RULE_PAGE);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Text(
          '提现说明',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 48.w,
      actions: [
        _rightManage(),
      ],
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('寄买寄卖'),
        centerTitle: true,
        background: Image.asset(
          Assets.imagesAppBarBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildHeaderContainer() {
    return SliverPadding(
      padding: EdgeInsets.all(15.w).copyWith(bottom: 0),
      sliver: SliverToBoxAdapter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 345.w,
              height: 115.w,
              decoration: BoxDecoration(
                color: AppColors.bg_gray,
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Image.asset(
                Assets.imagesSnupBanner,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 345.w,
              height: 37.w,
              margin: EdgeInsets.only(top: 15.w),
              decoration: BoxDecoration(
                color: AppColors.bg_gray,
                gradient: LinearGradient(
                  colors: [
                    AppColors.gold,
                    AppColors.gold_light,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.w),
                  topRight: Radius.circular(8.w),
                ),
              ),
              child: SafeTapWidget(
                onTap: () {
                  // Get.toNamed(RoutesID.MESSAGE_PAGE);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: 13.w,
                    ),
                    SafeTapWidget(
                      onTap: (){
                        // Get.toNamed(RoutesID.SUBMIT_ORDER_PAGE, arguments: {
                          // "goods": controller.goods,
                        // });
                      },
                      child: Text(
                        "可提前20分钟进入浏览",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildListDivider() {
    return SliverToBoxAdapter(
      child: Container(
        height: 15.w,
        width: 375.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w),
            topRight: Radius.circular(10.w),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF382405).withOpacity(0.09),
              offset: Offset(0, -4.w),
              blurRadius: 4.w,
            ),
          ],
        ),
      ),
    );
  }

  _buildSnapUpList() {
    return Obx(() {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (content, index) {
              return _buildSnapUpItem(index);
            },
            childCount: controller.snapUpList.length,
          ),
        ),
      );
    });
  }

  _buildSnapUpItem(index) {
    Item item = controller.snapUpList[index];
    ImageProvider image = AssetImage(Assets.iconsSnapBg1);
    if (Uri.parse(item.imageUrl ?? "").isAbsolute) {
      image = CachedNetworkImageProvider(item.imageUrl!);
    }

    return SafeTapWidget(
      onTap: () {
        controller.snapClick(index);
      },
      child: Container(
        width: 345.w,
        height: 200.w,
        margin: EdgeInsets.only(bottom: 15.w),
        decoration: BoxDecoration(
          color: AppColors.bg_gray,
          borderRadius: BorderRadius.circular(8.w),
          image: DecorationImage(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(10.w),
              child: SnapUpTitle(name: item.name ?? ""),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.iconsSnapTime),
                  Text(
                    "开放时间",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                  Image.asset(
                    Assets.iconsSnapTime,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.w),
              child: Container(
                width: 165.w,
                height: 30.w,
                decoration: BoxDecoration(
                    // color: Color(0xFF050505),
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.iconsSnapOpen,
                      ),
                      fit: BoxFit.fill,
                    )),
                alignment: Alignment.center,
                child: Text(
                  item.statusText()["text"] ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:code_zero/app/modules/snap_up/widget/snap_up_item_title.dart';
import 'package:code_zero/app/modules/snap_up/widget/timer.dart';
import 'package:code_zero/common/colors.dart';
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

  _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 48.w,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('抢购'),
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
              child: Row(
                children: [
                  SizedBox(
                    width: 13.w,
                  ),
                  Text(
                    "10:50-12:00 可提前2分钟进入浏览",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    width: 66.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF6E7),
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    margin: EdgeInsets.only(right: 8.w),
                    alignment: Alignment.center,
                    child: Text(
                      "查看详情",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.gold_dark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
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
  }

  _buildSnapUpItem(index) {
    return Container(
      width: 345.w,
      height: 200.w,
      margin: EdgeInsets.only(bottom: 15.w),
      decoration: BoxDecoration(
        color: AppColors.bg_gray,
        borderRadius: BorderRadius.circular(8.w),
        image: DecorationImage(
          image: AssetImage(
            Assets.iconsSnapBg1,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: SnapUpTitle(name: controller.snapUpList[index]),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.iconsSnapTime),
                Text(
                  "开抢时间",
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
                  color: Color(0xFF050505).withOpacity(0.5),
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.iconsSnapOpen,
                    ),
                    fit: BoxFit.fill,
                  )),
              alignment: Alignment.center,
              child: index == 2 ? Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('倒计时', style: S.textStyles.green),
                    SizedBox(width: 5.w,),
                    TimerTest(seconds: 100,)
                  ],
                ),
              ) : Text(
                index < 1 ? "2022年8月30日  00:00" : "未开放",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

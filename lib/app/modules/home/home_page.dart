import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.page_bg,
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(),
                _buildSearchContainer(),
                _buildSwiperContainer(),
                _buildFenquGridView(),
                SliverToBoxAdapter(
                  child: Container(
                    height: 1000.h,
                    width: double.infinity,
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text("test"),
                  ),
                ),
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
        title: Text('首页'),
        background: Image.asset(
          Assets.imagesAppBarBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildSearchContainer() {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.w,
        height: 58.w,
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.bg_gray,
                  borderRadius: BorderRadius.circular(20.w),
                ),
              ),
            ),
            SizedBox(width: 18.w),
            Container(
              width: 20.w,
              height: 20.w,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  _buildSwiperContainer() {
    return SliverToBoxAdapter(
      child: Container(
        width: 345.w,
        height: 140.w,
        margin: EdgeInsets.symmetric(horizontal: 15.w).copyWith(bottom: 15.w),
        decoration: BoxDecoration(
          color: AppColors.bg_gray,
          borderRadius: BorderRadius.circular(8.w),
        ),
        // child: Swiper(
        //   itemCount: 3,
        //   itemBuilder: (BuildContext context, int index) {
        //     return Image.asset(
        //       Assets.imagesSwiperBg,
        //       fit: BoxFit.cover,
        //     );
        //   },
        //   pagination: SwiperPagination(),
        // ),
      ),
    );
  }

  _buildFenquGridView() {
    return SliverPadding(
      padding: EdgeInsets.all(15.w).copyWith(top: 0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _buildTypeItem(index);
          }, childCount: controller.fenquList.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 108 / 48,
            crossAxisSpacing: 11.w,
            mainAxisSpacing: 10.w,
          )),
    );
  }

  _buildTypeItem(int index) {
    var name = controller.fenquList[index].name;
    var image = controller.fenquList[index].image;
    return Container(
      width: 108.w,
      height: 48.w,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.imagesFenquBg,
          ),
          fit: BoxFit.fill,
        ),
      ),
      padding: EdgeInsets.only(left: 21.w, right: 15.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,
              style: TextStyle(
                color: AppColors.text_dark,
                fontSize: 14.sp,
              )),
          Image.asset(
            image,
            width: 25.w,
            height: 32.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/home/activity/model/activity_tab_info.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/keep_alive_wrapper.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/custom_indicator.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'activity_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityPage extends GetView<ActivityController> {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0DDF8),
      appBar: CommonAppBar(
        titleText: "优惠福利",
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
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: _content(context));
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Stack(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Positioned(
          top: 10.w,
          left: 10.w,
          child: Obx(() {
            return TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              controller: controller.tabController.value,
              tabs: controller.myTabs.map((e) {
                return Obx(() {
                  return ActivityTab(text: e.text, choose: e.isChoose.value);
                });
              }).toList(),
              isScrollable: true,
              indicator: CustomIndicator(
                width: 0.w,
                height: 0.w,
              ),
              // indicatorColor: Color(0x1BDB8A),
              // labelColor: Color(0xffffffff),
              // labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              unselectedLabelColor: Color(0xff5D63FF),
              // unselectedLabelStyle: TextStyle(
              //   fontSize: 14.sp,
              //   fontWeight: FontWeight.normal,
              // ),
            );
          }),
        ),
        Positioned(
          top: 10.w,
          right: 10.w,
          child: Image.asset(
            'assets/images/activity/bg_tab.png',
            width: 45.w,
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 45.w,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(8.w),
                child: Obx(() {
                  return TabBarView(
                    controller: controller.tabController.value,
                    children: controller.myTabs.map((ActivityTabInfo tab) {
                      return KeepAliveWrapper(
                        child: SmartRefresher(
                          controller: tab.refreshController,
                          enablePullDown: true,
                          enablePullUp: true,
                          onRefresh: () {
                            controller.getRecommendList(
                                isRefresh: true, tabInfo: tab);
                          },
                          onLoading: () {
                            controller.getRecommendList(
                                isRefresh: false, tabInfo: tab);
                          },
                          child: CustomScrollView(
                            slivers: [
                              Obx(() {
                                return _buildCommodityList(tab);
                              }),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            )
          ],
        ),
      ],
    );
  }

  _buildCommodityList(ActivityTabInfo tab) {
    if (tab.commodityList.length == 0) {
      return SliverToBoxAdapter(
        child: Container(
          height: 400.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.iconsNoOrder,
                width: 100.w,
                height: 100.w,
              ),
              Text(
                '暂无相关订单',
                style: TextStyle(color: Color(0xFFABAAB9)),
              )
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(Get.context!).padding.bottom),
      sliver: Obx(() {
        return SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildRecommendItem(tab.commodityList[index]);
            }, childCount: tab.commodityList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 165 / 280,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 17.w,
            ));
      }),
    );
  }

  _buildRecommendItem(CommodityItem item) {
    return SafeTapWidget(
      onTap: () {
        Get.toNamed(RoutesID.PHOTO_VIEW_PAGE, arguments: {
          "url": item.thumbnails?.firstWhere((element) => element.isNotEmpty,
                  orElse: () => "") ??
              ""
        });

        Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
          "from": RoutesID.HOME_PAGE,
          "good": item,
          // "startTime": Get.arguments['startTime'],
          // "endTime": Get.arguments['endTime'],
        });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.w),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnails?.firstWhere(
                            (element) => element.isNotEmpty,
                            orElse: () => "") ??
                        '',
                    width: 165.w,
                    height: 210.w,
                    fit: BoxFit.cover,
                    placeholder: (_, __) {
                      return Image.asset(Assets.imagesHolderImg);
                    },
                    errorWidget: (_, __, ___) {
                      return Image.asset(Assets.imagesHolderImg);
                    },
                  ),
                ),
                Visibility(
                  visible: item.isHot == 1,
                  child: Positioned(
                    left: 0,
                    top: 0,
                    child: SvgPicture.asset(
                      Assets.imagesSelectedGoods,
                      width: 48.w,
                      height: 18.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.w,
            ),
            Text(
              item.name ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.text_dark,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5.w,
            ),
            Text(
              "￥${item.currentPrice}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFFD0A06D),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

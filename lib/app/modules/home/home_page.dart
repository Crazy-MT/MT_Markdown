import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.page_bg,
      body: Obx(() => Stack(
            children: [
              FTStatusPage(
                type: controller.pageStatus.value,
                errorMsg: controller.errorMsg.value,
                enablePullUp: true,
                enablePullDown: true,
                controller: controller.refreshController,
                onRefresh: () {
                  controller.getRecommendList();
                },
                onLoading: () {
                  controller.getRecommendList(isRefresh: false);
                },
                builder: (BuildContext context) {
                  return CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      _buildSliverAppBar(),
                      _buildSearchContainer(),
                      _buildSwiperContainer(),
                      _buildFenquGridView(),
                      _buildAdContainer(),
                      _buildRecommendDivider(),
                      _buildRecommendGrid(),
                    ],
                  );
                },
              ),
              if (controller.showScrollToTop.value)
                Positioned(
                  child: SafeTapWidget(
                    onTap: () {
                      controller.scrollerToTop();
                    },
                    child: Container(
                      width: 30.w,
                      height: 30.w,
                      child: SvgPicture.asset(Assets.imagesScrollToTop),
                    ),
                  ),
                  bottom: 15.w,
                  right: 15.w,
                )
            ],
          )),
    );
  }

  _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 48.w,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
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
              child: SafeTapWidget(
                onTap: () {
                  Get.toNamed(RoutesID.CATEGORY_PAGE, arguments: {'title': '搜索', 'from': 'search'});
                },
                child: Container(
                  height: 33.w,
                  decoration: BoxDecoration(
                    color: AppColors.bg_gray,
                    borderRadius: BorderRadius.circular(20.w),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 14.w,
                          right: 10.w,
                        ),
                        child: Image.asset(
                          Assets.iconsSearch,
                          width: 15.w,
                          height: 15.w,
                        ),
                      ),
                      Text(
                        "搜索感兴趣的商品",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFFA5A5A5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 18.w),
            Container(
              width: 24.w,
              height: 24.w,
              child: SvgPicture.asset(
                Assets.iconsChat,
              ),
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
        child: Swiper(
          autoplay: true,
          itemCount: controller.images.length,
          itemBuilder: (BuildContext context, int index) {
            final image = controller.images[index];
            return ClipRRect(borderRadius: BorderRadius.circular(10.w),child: Image.asset(image));
          },
          pagination: SwiperPagination(builder: DotSwiperPaginationBuilder(
            activeColor: AppColors.green,
            size: 6,
            activeSize: 6
          )),
        ),
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
    return SafeTapWidget(
      onTap: () {
        Get.toNamed(RoutesID.CATEGORY_PAGE, arguments: {'title': '${name}', 'from': 'type', 'categoryId': controller.fenquList[index].categoryId});
      },
      child: Container(
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
      ),
    );
  }

  //Above recommend
  _buildAdContainer() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 167.w,
                height: 200.w,
                decoration: BoxDecoration(
                  color: AppColors.bg_gray,
                  borderRadius: BorderRadius.circular(8.w),
                ),
              child: Image.asset(
                Assets.imagesHome1,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 167.w,
                    height: 95.w,
                    decoration: BoxDecoration(
                      color: AppColors.bg_gray,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Image.asset(
                      Assets.imagesHome2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  Container(
                    width: 167.w,
                    height: 95.w,
                    decoration: BoxDecoration(
                      color: AppColors.bg_gray,
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                    child: Image.asset(
                      Assets.imagesHome3,
                      fit: BoxFit.cover,
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

  _buildRecommendDivider() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 15.w),
      sliver: SliverToBoxAdapter(
        child: Column(children: [
          Image.asset(
            Assets.imagesRecommendDivider,
          ),
          Text(
            "猜你喜欢的",
            style: TextStyle(
              color: Color(0xFFD0A06D),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ]),
      ),
    );
  }

  _buildRecommendGrid() {
    return Obx(() {
      return SliverPadding(
        padding: EdgeInsets.all(12.w).copyWith(top: 0),
        sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return _buildRecommendItem(index);
            }, childCount: controller.commodityList.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 165 / 280,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 17.w,
            )),
      );
    });
  }

  _buildRecommendItem(index) {
    CommodityItem item = controller.commodityList[index];
    return SafeTapWidget(
      onTap: () {
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
                  borderRadius: BorderRadius.circular(8.w),
                  child: CachedNetworkImage(
                    imageUrl: item.thumbnails?.first ?? "",
                    width: 165.w,
                    height: 210.w,
                    fit: BoxFit.cover,
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

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/log_utils.dart';
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
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text('首页'),
            background: Image.asset(
              Assets.imagesAppBarBg,
              fit: BoxFit.cover,
            ),
          )),
      backgroundColor: AppColors.page_bg,
      body: Obx(() => Stack(
            children: [
              FTStatusPage(
                type: controller.pageStatus.value,
                errorMsg: controller.errorMsg.value,
                enablePullUp: true,
                enablePullDown: true,
                controller: controller.refreshController,
                onRefresh: () async {
                  controller.getRecommendList();
                  controller.getBannerList();
                  controller.getAdvList();
                },
                onLoading: () {
                  controller.getRecommendList(isRefresh: false);
                },
                builder: (BuildContext context) {
                  return CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
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
              // 推荐有礼
              Positioned(
                child: Obx(() {
                  return Visibility(
                    visible:
                        (systemSetting.model.value?.inviteSwitch ?? 1) == 1,
                    child: SafeTapWidget(
                      onTap: () {
                        Get.toNamed(RoutesID.RECOMMENDED_COURTEOUSLY_PAGE);
                      },
                      child: Container(
                        width: 50.w,
                        height: 50.w,
                        child: ScaleTransition(
                            scale: controller.scaleAnimation!,
                            child: Image.asset(
                                "assets/icons/recommend_courteously.png")),
                      ),
                    ),
                  );
                }),
                bottom: 110.w,
                right: 15.w,
              ),
              // 红包提取
              Positioned(
                child: Obx(() {
                  return Visibility(
                    visible:
                        (systemSetting.model.value?.inviteSwitch ?? 1) == 1,
                    child: SafeTapWidget(
                      onTap: () {
                        if (controller.isNewUser.value) {
                          Get.toNamed(RoutesID.RED_ENVELOPE_WITHDRAWAL_PAGE);
                        } else {
                          Get.toNamed(RoutesID.RED_ENVELOPE_REWARD_PAGE);
                        }
                      },
                      child: SizeTransition(
                          sizeFactor: controller.slideAnimation!,
                          axis: Axis.vertical,
                          axisAlignment: -1,

                          /// -1 代表 从头（此处即顶部）开始
                          child: Image.asset(
                            "assets/icons/red_bag.png",
                            width: 32.w,
                          )),
                    ),
                  );
                }),
                bottom: 50.w,
                right: 25.w,
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
                ),
            ],
          )),
    );
  }

  _buildSearchContainer() {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.w,
        height: 58.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Expanded(
              child: SafeTapWidget(
                onTap: () {
                  Get.toNamed(RoutesID.CATEGORY_PAGE,
                      arguments: {'title': '搜索', 'from': 'search'});
                },
                child: Container(
                  height: 40.w,
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
            SafeTapWidget(
              onTap: () {
                Get.toNamed(RoutesID.MESSAGE_PAGE);
              },
              child: Container(
                width: 24.w,
                height: 24.w,
                child: SvgPicture.asset(
                  Assets.iconsChat,
                ),
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
            return SafeTapWidget(
                onTap: () {
                  Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
                    "from": RoutesID.HOME_PAGE,
                    "good": controller.bannerList[index],
                    // "startTime": Get.arguments['startTime'],
                    // "endTime": Get.arguments['endTime'],
                  });
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.w),
                    child: Image.asset(image)));
          },
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: AppColors.green, size: 6, activeSize: 6)),
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
        Get.toNamed(RoutesID.CATEGORY_PAGE, arguments: {
          'title': '${name}',
          'from': 'type',
          'categoryId': controller.fenquList[index].categoryId
        });
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
            SafeTapWidget(
              onTap: () {
                if (controller.advList.length >= 1) {
                  Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
                    "from": RoutesID.HOME_PAGE,
                    "good": controller.advList[0],
                    // "startTime": Get.arguments['startTime'],
                    // "endTime": Get.arguments['endTime'],
                  });
                }
              },
              child: Container(
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
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                children: [
                  SafeTapWidget(
                    onTap: () {
                      Get.toNamed(RoutesID.ACTIVITY_PAGE);
                    },
                    child: Container(
                      width: 167.w,
                      height: 95.w,
                      decoration: BoxDecoration(
                        color: AppColors.bg_gray,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Image.asset(
                            Assets.imagesHome3,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            // width: 50.w,
                            // height: 50.w,
                            child: ScaleTransition(
                                scale: controller.scaleAnimation!,
                                child: Image.asset(
                                    "assets/images/home_4.png")),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  SafeTapWidget(
                    onTap: () {
                      if (controller.advList.length >= 3) {
                        Get.toNamed(RoutesID.GOODS_DETAIL_PAGE, arguments: {
                          "from": RoutesID.HOME_PAGE,
                          "good": controller.advList[2],
                          // "startTime": Get.arguments['startTime'],
                          // "endTime": Get.arguments['endTime'],
                        });
                      }
                    },
                    child: Container(
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
            }, childCount: controller.homeList.length),
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
    CommodityItem item = controller.homeList[index];
    return SafeTapWidget(
      onTap: () {
        /*Get.toNamed(RoutesID.PHOTO_VIEW_PAGE, arguments: {
          "url": item.thumbnails?.firstWhere(
                  (element) => element.isNotEmpty,
              orElse: () => "") ?? ""
        });*/
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

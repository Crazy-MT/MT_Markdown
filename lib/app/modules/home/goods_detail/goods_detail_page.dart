import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/snap_up/model/session_model.dart';
import 'package:code_zero/app/modules/snap_up/widget/count_down.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'goods_detail_controller.dart';

class GoodsDetailPage extends GetView<GoodsDetailController> {
  const GoodsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('MTMTMT GoodsDetailPage.build ${Get.arguments["from"]} ');
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      bottomNavigationBar: Get.arguments["from"] == RoutesID.SNAP_DETAIL_PAGE
          ? _buildSnapBottomAppBar()
          : _buildBottomAppBar(),
      appBar: AppBar(
        title: Text('商品详情',
            style: TextStyle(
              color: Colors.black,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
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
                _buildPicture(),
                _buildPrice(),
                _buildNameContainer(),
                _buildGoodsParams(),
                _buildIntroPicDivider(),
                _buildThumbnailsPicList(),
                _buildIntroParamsList(),
                _buildParamPicList(),
                _buildIntroPicList(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildPicture() {
    return SliverToBoxAdapter(
      child: Container(
        height: 375.w,
        width: 375.w,
        decoration: BoxDecoration(
          color: AppColors.bg_gray,
        ),
        child: Stack(children: [
          PageView(
            controller: controller.pageController,
            children: controller.detailPicList
                .map(
                  (element) => CachedNetworkImage(
                    imageUrl: element,
                    width: 375.w,
                    height: 375.w,
                    fit: BoxFit.contain,
                  ),
                )
                .toList(),
          ),
          Positioned(
            bottom: 20.w,
            right: 20.w,
            child: Container(
              child: Obx(
                () => Text(
                  "${controller.currentIndex.value + 1}/${controller.detailPicList.length}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    shadows: [
                      Shadow(
                        color: AppColors.text_dark,
                        offset: Offset(1.w, 1.w),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget _buildPrice() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50.w,
        width: 375.w,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesGoodsDetailPriceBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: RichText(
            text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: "￥",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: controller.goods.currentPrice ?? "",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "  价格",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF007B47),
                    ),
                  ),
                  TextSpan(
                    text: controller.goods.originalPrice ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough,
                      color: Color(0xFF007B47),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildNameContainer() {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.w,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 10.w,
        ),
        child: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Visibility(
                  visible: controller.goods.commodityType == 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 1.w,
                    ),
                    margin: EdgeInsets.only(right: 12.w, bottom: 1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                    child: Text(
                      "自营",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              TextSpan(
                text: controller.goods.name ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoodsParams() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9.w, horizontal: 15.w),
          width: 375.w,
          color: Colors.white,
          child: Row(
            children: [
              Text(
                "库存",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF757575),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Text(
                controller.goods.inventory.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF141519),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroPicDivider() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 15.w),
      sliver: SliverToBoxAdapter(
        child: Column(children: [
          Image.asset(
            Assets.imagesRecommendDivider,
          ),
          Text(
            "商品详情",
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

  Widget _buildIntroPicList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            return Container(
              width: 375.w,
              color: Colors.white,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.introPicList[index],
                    width: 375.w,
                  ),
                ],
              ),
            );
          },
          childCount: controller.introPicList.length,
        ),
      ),
    );
  }

  Widget _buildBottomAppBar() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 58.w,
      ),
      child: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 58.w,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.iconsShoppingCart,
                    width: 22.w,
                    height: 22.w,
                  ),
                  Text(
                    "购物车",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.text_dark,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 35.w,
              ),
              SafeTapWidget(
                onTap: () {
                  controller.doAddToCart();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 11.w,
                  ).copyWith(top: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      border: Border.all(
                        width: 2.w,
                        color: Colors.black,
                      )),
                  child: Text(
                    "加入购物车",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              SafeTapWidget(
                onTap: () {
                  controller.doBuy();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 11.w,
                  ).copyWith(top: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.w),
                    color: AppColors.green,
                  ),
                  child: Text(
                    "立即购买",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 抢购进来
  Widget _buildSnapBottomAppBar() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 58.w,
      ),
      child: Obx(() => BottomAppBar(
            color: controller.timerRefresh.value ? Colors.white : Colors.white,
            child: (controller.isCountDown()["isOpen"] &&
                    controller.isCountDown()["seconds"] > 0)
                ? Container(
                    margin: EdgeInsets.only(
                        right: 20.w, left: 20.w, top: 7.w, bottom: 7.w),
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.w),
                      color: AppColors.green,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "抢购倒计时",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        CountDown(
                          seconds: controller.isCountDown()["seconds"],
                          changed: (_) {
                            controller.timerRefresh.value = true;
                          },
                        )
                      ],
                    ),
                  )
                : Container(
                    height: 58.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SafeTapWidget(
                          onTap: () {
                            // controller.doBuy();
                          },
                          child: Container(
                            width: 335.w,
                            height: 44.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.w),
                              color: AppColors.green,
                            ),
                            child: Text(
                              controller.isCountDown()["text"],
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }

  _buildIntroParamsList() {
    var param = [];
    param.addAll(controller.goods.showParams ?? []);
    // param.addAll(controller.goods.showParams ?? []);
    return SliverPadding(
      padding: EdgeInsets.all(15.w).copyWith(top: 0),
      sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _buildParamsItem(param[index]);
          }, childCount: param.length),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 165 / 28,
            // crossAxisSpacing: 15.w,
            // mainAxisSpacing: 17.w,
          )),
    );
  }

  _buildParamsItem(Map param) {
    return Container(
        // width: 100.w,
        // height: 100.w,
        child: Text(
      "【${param.keys.first}】${param.values.first}",
      style: TextStyle(fontSize: 16.sp),
    ));
  }

  _buildThumbnailsPicList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            return Container(
              width: 375.w,
              color: Colors.white,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.thumbnailsList[index],
                    width: 375.w,
                  ),
                ],
              ),
            );
          },
          childCount: controller.thumbnailsList.length,
        ),
      ),
    );
  }

  _buildParamPicList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            return Container(
              width: 375.w,
              color: Colors.white,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: controller.paramsPicList[index],
                    width: 375.w,
                  ),
                ],
              ),
            );
          },
          childCount: controller.paramsPicList.length,
        ),
      ),
    );
  }
}

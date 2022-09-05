import 'package:code_zero/app/modules/home/category/widget/category_empty_view.dart';
import 'package:code_zero/app/modules/home/category/widget/category_goods_item.dart';
import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/colors.dart';
import '../../../../generated/assets/assets.dart';
import '../../shopping_cart/widget/shopping_cart_empty_view.dart';
import '../../shopping_cart/widget/shopping_cart_goods_item.dart';
import 'category_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Get.arguments['from'] == 'search'
                ? Get.arguments['title']
                : '${Get.arguments['title']}专区',
            style: S.textStyles.black),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: S.colors.black,
          onPressed: () => Get.back(),
        ),
        backgroundColor: S.colors.white,
        elevation: 0,
      ),
      body: Obx(
        () => FTStatusPage(
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
                _buildSearchContainer(),
                _buildSortContainer(),
                _buildOrderContent(context)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderContent(BuildContext context) {
    return Obx(() {
      return SliverToBoxAdapter(
        child: Container(
          width: 375.w,
          height: 812.w -
              64.w -
              60.w -
              64.w -
              MediaQuery.of(context).padding.bottom,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          // margin: EdgeInsets.only(top: 15.w),
          child: controller.commodityList.isEmpty
              ? CategoryEmptyView()
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 15.w),
                  itemBuilder: (BuildContext context, int index) {
                    return CategoryGoodsItem(controller.commodityList[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10.w);
                  },
                  itemCount: controller.commodityList.length,
                ),
        ),
      );
    });
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
              child: buildInputWithTitle(
                SizedBox.shrink(),
                // padding: EdgeInsets.all(20.w).copyWith(top: 0, bottom: 15.w),
                inputController: controller.newPasswordController,
                hintText: Get.arguments['from'] == 'search'
                    ? '搜索更多'
                    : Get.arguments['title'],
                // obscureText: !controller.showNewPassword.value,
                prefixWidget: IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    Assets.iconsSearch,
                    width: 14.w,
                    height: 14.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildSortContainer() {
    return SliverPadding(
      padding: EdgeInsets.all(15.w),
      sliver: SliverToBoxAdapter(
        child: Container(
          alignment: Alignment.center,
          // color: Colors.black,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SafeTapWidget(
                      onTap: () {
                        controller.getRecommendList(isRefresh: true);
                      },
                      child: Center(child: Text('全部')))),
              Expanded(
                  child: SafeTapWidget(
                      onTap: () {
                        controller.sortBySales();
                      }, child: Center(child: Text('销量')))),
              Expanded(
                  child: SafeTapWidget(
                      onTap: () {
                        controller.sortByPrice();
                      }, child: Center(child: Text('价格')))),
            ],
          ),
        ),
      ),
    );
  }
}

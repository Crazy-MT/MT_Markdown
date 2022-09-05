import 'package:code_zero/app/modules/shopping_cart/widget/shopping_cart_empty_view.dart';
import 'package:code_zero/app/modules/shopping_cart/widget/shopping_cart_goods_item.dart';
import 'package:code_zero/app/modules/shopping_cart/widget/shopping_cart_price_widget.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shopping_cart_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.page_bg,
      body: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    _buildSliverAppBar(),
                    _buildOrderContent(context),
                  ],
                );
              },
            ),
            _totalPrice(),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 48.w,
      backgroundColor: Colors.transparent,
      actions: [
        _rightManage(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text('购物车'),
        centerTitle: true,
        background: Image.asset(
          Assets.imagesAppBarBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _rightManage() {
    return controller.goodsList.isEmpty
        ? Container()
        : Obx(
            (() => GestureDetector(
                  onTap: () {
                    controller.isManageStatus.value = !controller.isManageStatus.value;
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    child: Text(
                      controller.isManageStatus.value == true ? '完成' : '管理',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )),
          );
  }

  Widget _buildOrderContent(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(bottom: 70.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            if (controller.goodsList.isEmpty) {
              return ShoppingCartEmptyView();
            }
            return ShoppingCartGoodsItem(goodsModel: controller.goodsList[index]);
          },
          childCount: controller.goodsList.isEmpty ? 1 : controller.goodsList.length,
        ),
      ),
    );
  }

  Widget _totalPrice() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Visibility(
        visible: controller.goodsList.isNotEmpty,
        child: ShoppingCartPriceWidget(),
      ),
    );
  }
}

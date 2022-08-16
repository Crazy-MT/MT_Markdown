import 'package:code_zero/app/modules/shopping_cart/widget/shopping_cart_empty_view.dart';
import 'package:code_zero/app/modules/shopping_cart/widget/shopping_cart_goods_item.dart';
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
            Visibility(
              visible: controller.goodsList.isNotEmpty,
              child: _totalPrice(),
            ),
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
        background: Image.asset(
          Assets.imagesAppBarBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _rightManage() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: Text(
          '管理',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildOrderContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.w,
        height: 812.w - 64.w - 60.w - 64.w - MediaQuery.of(context).padding.bottom,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: controller.goodsList.isEmpty
            ? ShoppingCartEmptyView()
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15.w),
                itemBuilder: (BuildContext context, int index) {
                  return ShoppingCartGoodsItem();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10.w);
                },
                itemCount: 13,
              ),
      ),
    );
  }

  Widget _totalPrice() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 60.w,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(width: 25.w),
            Icon(
              Icons.check_box_rounded,
              color: Colors.green,
            ),
            SizedBox(width: 10.w),
            Text(
              '全选',
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 15.sp,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              '总计:',
              style: TextStyle(
                color: Color(0xff757575),
                fontSize: 15.sp,
              ),
            ),
            Text(
              '￥',
              style: TextStyle(
                color: Color(0xff1BDB8A),
                fontSize: 15.sp,
              ),
            ),
            Text(
              '30000',
              style: TextStyle(
                color: Color(0xff1BDB8A),
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              width: 100.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff1BDB8A),
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Text(
                '结算',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(width: 15.w),
          ],
        ),
      ),
    );
  }
}

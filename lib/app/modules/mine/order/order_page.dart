import 'dart:math';

import 'package:code_zero/app/modules/mine/order/widget/order_item_widget.dart';
import 'package:code_zero/generated/assets/assets.dart';

import '../../../../common/components/common_app_bar.dart';
import 'order_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends GetView<OrderController> {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: CommonAppBar(
        titleText: "全部订单",
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
            return Obx(() => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    _content(context),
                    this.controller.editStatus.value != 0
                        ? _bottomControlWidget(context)
                        : SizedBox(),
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TabBar(
          controller: controller.tabController,
          tabs: controller.myTabs,
          // isScrollable: true,
          indicatorColor: Color(0xff1BDB8A),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(10.w),
          indicatorWeight: 3.w,
          labelColor: Color(0xff111111),
          labelStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          unselectedLabelColor: Color(0xff434446),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: controller.myTabs.map((Tab tab) {
              return CustomScrollView(
                slivers: [
                  _buildOrderList(),
                  _safeWidget(context),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  _buildOrderList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          return Obx(() => OrderItemWidget(
                index: index,
                editStatus: this.controller.editStatus.value,
              ));
        },
        childCount: 10,
      ),
    );
  }

  _bottomControlWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      color: Colors.white,
      height: 60.w + MediaQuery.of(context).padding.bottom,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 25.w,
          ),
          GestureDetector(
            onTap: () {
              if (this.controller.editStatus.value != 2) {
                this.controller.editStatus.value = 2;
              } else {
                this.controller.editStatus.value = 1;
              }
            },
            child: Image.asset(
              this.controller.editStatus.value == 2
                  ? Assets.imagesShoppingCartGoodsSelected
                  : Assets.imagesShoppingCartGoodsUnselected,
              height: 19.w,
              width: 19.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "全选",
            style: TextStyle(color: Color(0xff757575), fontSize: 15.sp),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Text(
            "总计：",
            style: TextStyle(color: Color(0xff757575), fontSize: 15.sp),
          ),
          Text(
            "¥30000.00",
            style: TextStyle(color: Color(0xff111111), fontSize: 15.sp),
          ),
          SizedBox(
            width: 15.w,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 100.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.w),
                color: Color(0xff1BDB8A),
              ),
              child: Center(
                child: Text(
                  "合并结算",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
    );
  }

  _safeWidget(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).padding.bottom,
      ),
    );
  }
}

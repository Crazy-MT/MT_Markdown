import 'package:code_zero/app/modules/mine/order/model/self_order_tab_info.dart';
import 'package:code_zero/app/modules/mine/order/widget/order_item_widget.dart';
import 'package:code_zero/common/components/keep_alive_wrapper.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/components/common_app_bar.dart';
import '../model/order_tab_info.dart';
import 'order_controller.dart';

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
            () =>
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return Obx(() =>
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        _content(context),
                        this.controller.editStatus.value != 0
                            ? _bottomControlWidget()
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
          tabs: controller.myTabs.map((e) => e.tab).toList(),
          // isScrollable: true,
          indicatorColor: Color(0xff1BDB8A),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(10.w),
          indicatorWeight: 3.w,
          labelColor: Color(0xff111111),
          labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          unselectedLabelColor: Color(0xff434446),
          unselectedLabelStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: Obx(() {
            return TabBarView(
              controller: controller.tabController,
              children: controller.myTabs.map((SelfOrderTabInfo tab) {
                return KeepAliveWrapper(
                  child: SmartRefresher(
                    controller: tab.refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    onRefresh: () {
                      controller.getOrder(true, tab);
                    },
                    onLoading: () {
                      controller.getOrder(false, tab);
                    },
                    child: CustomScrollView(
                      slivers: [
                        _buildOrderList(tab),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ],
    );
  }

  _buildOrderList(SelfOrderTabInfo tab) {
    if (tab.orderList.length == 0) {
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
      EdgeInsets.only(bottom: MediaQuery
          .of(Get.context!)
          .padding
          .bottom),
      sliver: Obx(() {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (content, index) {
              return Obx(() =>
                  OrderItemWidget(
                    index: index,
                    item: tab.orderList[index],
                    editStatus: this.controller.editStatus.value,
                  ));
            },
            childCount: tab.orderList.length,
          ),
        );
      }),
    );
  }

  _bottomControlWidget() {
    return Container(
      padding:
      EdgeInsets.only(bottom: MediaQuery
          .of(Get.context!)
          .padding
          .bottom),
      color: Colors.white,
      height: 60.w + MediaQuery
          .of(Get.context!)
          .padding
          .bottom,
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
}

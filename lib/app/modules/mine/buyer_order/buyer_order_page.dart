import 'package:code_zero/app/modules/mine/buyer_order/widget/order_item_widget.dart';
import 'package:code_zero/common/components/keep_alive_wrapper.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../common/components/common_app_bar.dart';
import '../model/order_tab_info.dart';
import 'buyer_order_controller.dart';

class BuyerOrderPage extends GetView<BuyerOrderController> {
  const BuyerOrderPage({Key? key}) : super(key: key);

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
            return _content(context);
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
            children: controller.myTabs.map((OrderTabInfo tab) {
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
          ),
        ),
      ],
    );
  }

  _buildOrderList(OrderTabInfo tab) {
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
          EdgeInsets.only(bottom: MediaQuery.of(Get.context!).padding.bottom),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            // lLog('MTMTMT BuyerOrderPage._buildOrderList ${index}');
            return OrderItemWidget(
              index: index,
              item: tab.orderList[index],
            );
          },
          childCount: tab.orderList.length,
        ),
      ),
    );
  }
}

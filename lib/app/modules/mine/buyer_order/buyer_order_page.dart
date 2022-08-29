
import '../../../../common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../order/widget/order_item_widget.dart';
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
          return OrderItemWidget(
            index: index,
          );
        },
        childCount: 10,
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

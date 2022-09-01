import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/buyer_order/order_detail/order_detail_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/avoid_quick_click.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailPage extends GetView<OrderDetailController> {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        titleText: "订单详情",
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
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 15.w),
                  _payInfoWidget(),
                  SizedBox(height: 10.w),
                  _oderInfoWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _payInfoWidget() {
    return Container(
      height: (222 + 62).w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 20.w, right: 35.w),
            height: 62.w,
            decoration: BoxDecoration(
              color: AppColors.green,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Get.arguments['status'] ?? "已完成",
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Image.asset(
                  Assets.imagesOrderDetailFinishIcon,
                  width: 39.w,
                  height: 45.w,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Visibility(

                  child: Container(
                    height: 50.w,
                    child: Obx(() => _orderInfoItemWidget(
                        '支付方式', controller.item.value?.getTradeMethod())),
                  ),
                  visible: controller.item.value?.hasTrade == 1,
                ),
                Visibility(
                  visible: controller.item.value?.hasTrade == 1,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '支付凭证',
                            style: TextStyle(
                                color: Color(0xff434446),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.w),
                            child: Obx(() => CachedNetworkImage(
                                  imageUrl: controller.item.value?.tradeUrl ?? "",
                                  width: 115.w,
                                  height: 123.w,
                                  fit: BoxFit.fitWidth,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50.w,
                  child: Obx(() => _orderInfoItemWidget(
                        '商品金额',
                        "￥ ${controller.item.value?.price}",
                        titleStyle: TextStyle(
                            color: Color(0xff111111),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                        descStyle: TextStyle(
                            color: AppColors.green,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _oderInfoWidget() {
    return Container(
      height: 84.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Obx(() => _orderInfoItemWidget(
              '订单号', (controller.item.value?.tradeNo ?? 0).toString())),
          Obx(() => _orderInfoItemWidget(
              '完成时间', controller.item.value?.completeTime ?? "")),
        ],
      ),
    );
  }

  Widget _orderInfoItemWidget(
    String title,
    String desc, {
    TextStyle? titleStyle,
    TextStyle? descStyle,
  }) {
    return Container(
      height: 42.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleStyle ??
                TextStyle(
                  color: Color(0xff434446),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
          Text(
            desc,
            style: descStyle ??
                TextStyle(
                  color: Color(0xff757575),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'self_order_detail_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelfOrderDetailPage extends GetView<SelfOrderDetailController> {
  const SelfOrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return Obx(() {
              return Container(
                color: AppColors.bg_gray,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 15.w),
                      _payInfoWidget(),
                      SizedBox(height: 15.w),
                      _goodsWidget(),
                      SizedBox(height: 10.w),
                      _pay(),
                      SizedBox(height: 10.w),
                      _oderInfoWidget(),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }

  SingleChildScrollView _goodsWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: (controller.item.value?.commodityList ?? [])
                .map<Widget>((element) {
              return Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _middelWidget(element),
                    SizedBox(
                      height: 5.w,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          // _buildGoodsInfo(),
        ],
      ),
    );
  }

  Widget _payInfoWidget() {
    SelfOrderItems? item = controller.item.value;
    return Container(
      height: (120).w,
      // clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.w, right: 35.w),
            height: 62.w,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Get.arguments?['status'] ?? "已完成",
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 15.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assets.imagesAddressLocationIcon,
                      width: 20.w,
                    ),
                    Text('${item?.receiptConsignee}    ${item?.receiptPhone}'),
                  ],
                ),
                Text('${item?.receiptRegion}${item?.receiptAddress}')
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _pay() {
    SelfOrderItems? item = controller.item.value;
    return Container(
      height: 200.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Visibility(
            child: Container(
              height: 50.w,
              child: _orderInfoItemWidget('支付方式', item?.getTradeMethod()),
            ),
            visible: true,
          ),
          Visibility(
            child: Container(
              height: 50.w,
              child: _orderInfoItemWidget('商品价格', item?.amount ?? ""),
            ),
            visible: true,
          ),
          Container(
            height: 50.w,
            child: _orderInfoItemWidget('物流公司', item?.getTradeMethod()),
          ),
          Container(
            height: 50.w,
            child: _orderInfoItemWidget(
              '应付金额',
              "￥ ${item?.paidAmount}",
              titleStyle: TextStyle(
                  color: Color(0xff111111),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600),
              descStyle: TextStyle(
                  color: AppColors.green,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _oderInfoWidget() {
    return Container(
      height: 96.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Obx(() => _orderInfoItemWidget(
              '订单号', (controller.item.value?.outTradeNo ?? 0).toString())),
          Obx(() => _orderInfoItemWidget(
              '交易编号', controller.item.value?.paymentFlowNo ?? "")),
          Obx(() => _orderInfoItemWidget(
              '创建时间', controller.item.value?.createdAt ?? "")),
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
      height: 32.w,
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

  Widget _middelWidget(CommodityList commodity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child: CachedNetworkImage(
            imageUrl: commodity.commodityThumbnailUrl ?? "",
            width: 100.w,
            height: 100.w,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            height: 100.w,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  commodity.commodityName ?? "",
                  style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 10.w,),
                Text(
                  "共${commodity.commodityCount}件",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Color(0xffABAAB9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _richText(
      {double? fontSize1,
      double? fontSize2,
      FontWeight? fontWeight,
      String? text}) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Color(0xff111111),
        ),
        children: [
          TextSpan(
            text: "￥",
            style: TextStyle(
              fontSize: fontSize1 ?? 12.sp,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
          TextSpan(
            text: text ?? "",
            style: TextStyle(
              fontSize: fontSize2 ?? 14.sp,
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

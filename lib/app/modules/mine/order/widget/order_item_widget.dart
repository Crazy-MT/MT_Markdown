import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:code_zero/app/modules/mine/order/order_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/avoid_quick_click.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderItemWidget extends StatelessWidget {
  final int index;
  final int? editStatus;
  final SelfOrderItems item;

  const OrderItemWidget(
      {Key? key, required this.index, this.editStatus, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.find<OrderController>();
    return SafeClickGesture(
      onTap: () {
        // if(item.tradeState == 2 || item.tradeState == 3) {
        Get.toNamed(RoutesID.SELF_ORDER_DETAIL_PAGE, arguments: {"item": item, "status" : controller.getTradeState(item.tradeState)});
        // }
      },
      child: _contentWidget(),
    );
  }

  Widget _contentWidget() {
    OrderController controller = Get.find<OrderController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  (this.editStatus != null && this.editStatus != 0)
                      ? Image.asset(
                          this.editStatus == 1
                              ? Assets.imagesShoppingCartGoodsUnselected
                              : Assets.imagesShoppingCartGoodsSelected,
                          height: 19.w,
                          width: 19.w,
                        )
                      : SizedBox(),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text("订单号: ${item.outTradeNo}",
                      style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 12.sp,
                      )),
                ],
              ),
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      controller.getTradeState(item.tradeState),
                      style: TextStyle(
                          color: Color(0xff1BDB8A),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: (item.commodityList ?? []).map<Widget>((element) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _middelWidget(element),
                        SizedBox(
                          height: 5.w,
                        ),
                      ],
                    );
                  }).toList(),
                ),
                // _buildGoodsInfo(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "取消订单",
                          color: Color(0xff000000),
                          onTap: () {
                            controller.cancelOrder(item.id);
                          }),
                      visible: controller.tabController?.index == 1 || item.tradeState == 3 || item.tradeState == 6,
                    ),
                    SizedBox(width: 10.w,),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "待付款",
                          color: Color(0xffFF3939),
                          onTap: () {
                            controller.pay(item);
                          }),
                      visible: controller.tabController?.index == 1 || item.tradeState == 3 || item.tradeState == 6,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "查看物流",
                          color: Color(0xff000000),
                          onTap: () {
                              controller.checkWuliu(item);
                          }),
                      visible: controller.tabController?.index == 3 || item.tradeState == 9,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "已付款", color: Color(0xff1BDB8A)),
                      visible: controller.tabController?.index == 2 || item.tradeState == 1,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "确认收货",
                          color: Color(0xff000000),
                          onTap: () {
                            controller.shouhuo(item.id);
                          }),
                      visible: controller.tabController?.index == 3 || item.tradeState == 9,
                    )
                  ],
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buttonBtnWidget({String? title, Color? color, var onTap}) {
    return SafeTapWidget(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.w),
          color: Color(0xffF3F9FB),
        ),
        height: 27.w,
        width: 82.w,
        child: Center(
          child: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 12.sp,
              color: color,
            ),
          ),
        ),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                _richText(
                    fontSize1: 10.sp,
                    fontSize2: 14.sp,
                    text: commodity.commodityPrice),
                Text(
                  "共${commodity.commodityCount}件",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Color(0xffABAAB9),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal),
                ),
                _richText(
                    fontSize1: 12.sp,
                    fontSize2: 16.sp,
                    text: item.amount,
                    fontWeight: FontWeight.w700),
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

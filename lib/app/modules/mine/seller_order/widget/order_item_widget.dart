import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/seller_order/seller_order_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/avoid_quick_click.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../model/order_list_model.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final int index;
  final String text;

  const OrderItemWidget({
    Key? key,
    required this.index,
    required this.item, this.text = "已完成",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeClickGesture(
      onTap: () {
        Get.toNamed(RoutesID.ORDER_DETAIL_PAGE, arguments: {"item": item, 'status': text, 'from': RoutesID.SELLER_ORDER_PAGE});
      },
      child: _contentWidget(),
    );
  }

  Widget _contentWidget() {
    SellerOrderController controller = Get.find<SellerOrderController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("订单号 ${item.tradeNo}",
                      style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 12.sp,
                      )),
                  SizedBox(
                    height: 10.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.iconsGoodsInfoTitleIcon,
                        width: 18.w,
                        height: 18.w,
                      ),
                      Text(
                        item.sessionName ?? "",
                        style: TextStyle(
                          color: Color(0xFF434446),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
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
                      // "${item.getTradeState()}",
                      style: TextStyle(
                          color: Color(0xff1BDB8A),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                    // _richText(fontSize1: 10.sp, fontSize2: 14.sp, text: "3000"),
                    // Text(
                    //   "共1件",
                    //   textAlign: TextAlign.end,
                    //   style: TextStyle(color: Color(0xffABAAB9), fontSize: 12.sp, fontWeight: FontWeight.normal),
                    // ),
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          _middelWidget(),
          SizedBox(
            height: 5.w,
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
                          title: "申诉",
                          color: Color(0xff000000),
                          onTap: () {
                            Get.toNamed(RoutesID.COMPLAINT_FEEDBACK_PAGE, arguments: {'appealType': 0, 'id': item.id});
                          }),
                      visible: item.tradeState == 1 || (item.tradeState == -1),
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "确认收款",
                          color: Color(0xff1BDB8A),
                          onTap: () {
                            SellerOrderController controller =
                                Get.find<SellerOrderController>();
                            controller.confirmOrder(item.id ?? 0);
                          }),
                      visible: item.tradeState == 1,
                    )
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 8.w,
          )
        ],
      ),
    );
  }

  Widget _buttonBtnWidget({String? title, Color? color, var onTap}) {
    return SafeTapWidget(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 8.w),
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

  Widget _middelWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.w),
          child: CachedNetworkImage(
            imageUrl: item.thumbnailUrl ?? "",
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
                  item.name ?? "",
                  style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                // _richText(fontSize1: 10.sp, fontSize2: 14.sp, text: "3000"),
                // Text(
                //   "共1件",
                //   textAlign: TextAlign.end,
                //   style: TextStyle(color: Color(0xffABAAB9), fontSize: 12.sp, fontWeight: FontWeight.normal),
                // ),
                _richText(
                    fontSize1: 12.sp,
                    fontSize2: 16.sp,
                    text: (double.tryParse(item.newPrice ?? "0") ?? 0) <= 0 ? item.price : item.newPrice,
                    fontWeight: FontWeight.w700),
                Visibility(
                  visible: item.hasShelf == 1,
                  child: Text(
                    '上架时间：${item.shelfTime}',
                    style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.end,
                  ),
                )

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

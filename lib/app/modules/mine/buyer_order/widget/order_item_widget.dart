import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/buyer_order/buyer_order_controller.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../generated/assets.dart';
import '../../../../../utils/log_utils.dart';
import '../../../../routes/app_routes.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem item;
  final int index;

  const OrderItemWidget({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  Widget _contentWidget() {
    BuyerOrderController controller = Get.find<BuyerOrderController>();
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.iconsGoodsInfoTitleIcon,
                        width: 19.w,
                        height: 19.w,
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
                      "订单状态：${item.tradeState.toString()}",
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
            height: 15.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                child: _buttonBtnWidget(
                    title: "取消订单",
                    color: Color(0xff000000),
                    onTap: () {
                      BuyerOrderController controller =
                          Get.find<BuyerOrderController>();
                      controller.cancelOrder(item.id ?? 0);
                    }),
                visible: item.tradeState == 0,
              ),
              Expanded(
                  child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "去付款",
                          color: Color(0xffFF3939),
                          onTap: () {
                            Get.toNamed(RoutesID.COLLECTION_PAGE, arguments: {
                              "fromUserId": item.fromUserId,
                              "fromUserIsAdmin": item.fromUserIsAdmin
                            });
                          }),
                      visible: item.tradeState == 0 || (item.tradeState == 2),
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "支付确认",
                          color: Color(0xff1BDB8A),
                          onTap: () {
                            BuyerOrderController controller =
                                Get.find<BuyerOrderController>();
                            controller.confirmOrder(item.id ?? 0);
                          }),
                      visible: item.tradeState == 0,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "上传支付凭证",
                          color: Color(0xff000000),
                          onTap: () {
                            BuyerOrderController controller =
                                Get.find<BuyerOrderController>();
                            controller.chooseAndUploadImage(item.id ?? 0);
                          }),
                      visible: item.tradeState == 2,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "申诉", color: Color(0xffFF3939), onTap: () {}),
                      visible: item.tradeState == 3,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "提货", color: Color(0xff1BDB8A), onTap: () {}),
                      visible: item.tradeState == 3,
                    ),
                    Visibility(
                      child: _buttonBtnWidget(
                          title: "委托上架",
                          color: Color(0xff000000),
                          onTap: () {
                            // todo
                          }),
                      visible: item.tradeState == 3,
                    )
                  ],
                ),
              ))
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                child: _buttonBtnWidget(
                    title: "上传支付凭证",
                    color: Color(0xff000000),
                    onTap: () {
                      BuyerOrderController controller =
                          Get.find<BuyerOrderController>();
                      controller.chooseAndUploadImage(item.id ?? 0);
                    }),
                visible: item.tradeState == 0,
              ),
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
        margin: EdgeInsets.only(right: 8.w),
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
            fit: BoxFit.fill,
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
                    text: item.price,
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

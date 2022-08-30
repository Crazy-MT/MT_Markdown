import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.tradeNo ?? "",
              style: TextStyle(
                color: Color(0xff434446),
                fontSize: 12.sp,
              )),
          SizedBox(
            height: 15.w,
          ),
          _middelWidget(),
          SizedBox(
            height: 15.w,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buttonBtnWidget(
                  title: "取消订单",
                  color: Color(0xff000000),
                ),
                SizedBox(
                  width: 10.w,
                ),
                _buttonBtnWidget(
                  title: "待付款",
                  color: Color(0xffFF3939),
                ),
                SizedBox(
                  width: 10.w,
                ),
                _buttonBtnWidget(
                  title: "上传支付凭证",
                  color: Color(0xff000000),
                ),
                _buttonBtnWidget(
                  title: "申诉",
                  color: Color(0xff000000),
                ),
                _buttonBtnWidget(
                  title: "提货",
                  color: Color(0xff000000),
                ),
                _buttonBtnWidget(
                  title: "委托上架",
                  color: Color(0xff000000),
                ),
                _buttonBtnWidget(
                  title: "取消订单",
                  color: Color(0xff000000),
                ),
                _buttonBtnWidget(
                  title: "确认收款",
                  color: Color(0xff000000),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonBtnWidget({String? title, Color? color}) {
    return Container(
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
                  style: TextStyle(color: Color(0xff111111), fontSize: 15.sp, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                _richText(fontSize1: 10.sp, fontSize2: 14.sp, text: "3000"),
                Text(
                  "共1件",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Color(0xffABAAB9), fontSize: 12.sp, fontWeight: FontWeight.normal),
                ),
                _richText(fontSize1: 12.sp, fontSize2: 16.sp, text: "3000", fontWeight: FontWeight.w700),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _richText({double? fontSize1, double? fontSize2, FontWeight? fontWeight, String? text}) {
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

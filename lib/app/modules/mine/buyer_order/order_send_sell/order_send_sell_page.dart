import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/avoid_quick_click.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'order_send_sell_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSendSellPage extends GetView<OrderSendSellController> {
  const OrderSendSellPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        titleText: "寄卖",
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
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(height: 15.w),
                          _goodsInfoWidget(),
                          SizedBox(height: 10.w),
                          _orderInfoWidget(),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    _bottomWidget(context),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _goodsInfoWidget() {
    return Container(
      height: 152.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 42.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.iconsGoodsInfoTitleIcon,
                  width: 19.w,
                  height: 19.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  '8号宝库',
                  style: TextStyle(
                    color: Color(0xff434446),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbkimg.cdn.bcebos.com%2Fpic%2Fd439b6003af33a87f0190f94cc5c10385243b5c3&refer=http%3A%2F%2Fbkimg.cdn.bcebos.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1664523086&t=b5a98ddd4217e9e6248609c389809bdc',
                    width: 100.w,
                    height: 100.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '以心参玉 A货翡翠吊坠 男女...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Color(0xff141519), fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '共1件',
                      style: TextStyle(color: Color(0xffABAAB9), fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '最高上浮价格：¥ 30000.00',
                      style: TextStyle(color: Color(0xff434446), fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '¥ 30000.00',
                      style: TextStyle(color: Color(0xff111111), fontSize: 16.sp, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.w),
        ],
      ),
    );
  }

  Widget _orderInfoWidget() {
    return Container(
      height: 126.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _orderInfoItemWidget('推荐价格', '3000'),
          _orderInfoItemWidget('上架价格', '2990'),
          _orderInfoItemWidget('收续费', '288.56'),
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
                  color: Color(0xff141519),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
          ),
          Text(
            desc,
            style: descStyle ??
                TextStyle(
                  color: Color(0xff111111),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
          )
        ],
      ),
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      height: MediaQuery.of(context).padding.bottom + 60.w,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '总价：',
            style: TextStyle(
              color: Color(0xff757575),
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '¥ 30000.00',
            style: TextStyle(
              color: Color(0xff111111),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: SizedBox()),
          SafeClickGesture(
            child: Container(
              width: 100.w,
              height: 40.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(20.w),
              ),
              child: Text(
                '提交订单',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

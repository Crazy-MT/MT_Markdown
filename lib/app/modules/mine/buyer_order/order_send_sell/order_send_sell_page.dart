import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/avoid_quick_click.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/utils/input_format_utils.dart';
import 'package:code_zero/utils/log_utils.dart';
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
    return Obx(() => Container(
          // height: 152.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          // clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      controller.item.value?.sessionName ?? "",
                      style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.w),
                    child: CachedNetworkImage(
                      imageUrl: controller.item.value?.thumbnailUrl ?? "",
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: 200.w,
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.item.value?.name ?? "",
                            // maxLines: 1,
                            // (controller.item.value?.name ?? ""),
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xff141519),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '共1件',
                            style: TextStyle(
                                color: Color(0xffABAAB9),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Obx(() => Text(
                                '最高上浮价格：¥ ${controller.model.value?.maxPrice}',
                                style: TextStyle(
                                    color: Color(0xff434446),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              )),
                          Obx(() => Text(
                                controller.model.value?.commodityPrice ?? "",
                                style: TextStyle(
                                    color: Color(0xff111111),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
            ],
          ),
        ));
  }

  Widget _orderInfoWidget() {
    return Container(
      height: 126.w,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() => Column(
            children: [
              _orderInfoItemWidget(
                  '推荐价格', controller.model.value?.recommendPrice ?? ""),
              _orderInfoItemWidget(
                  '上架价格', controller.model.value?.commodityPrice ?? "", isEdit: true),
              _orderInfoItemWidget('手续费', controller.model.value?.charge ?? ""),
            ],
          )),
    );
  }

  Widget _orderInfoItemWidget(
    String title,
    String desc, {
    TextStyle? titleStyle,
    TextStyle? descStyle, bool? isEdit
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
          (isEdit ?? false) ? Container(
            width: 120.w,
            height: 100.w,
            alignment: Alignment.centerRight,
            child: CommonInput(hintText: '请输入上架金额',
              keyboardType: TextInputType.number,
              controller: controller.editingController,
              hintStyle: TextStyle(
                color: Color(0xffABAAB9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.end,
            ),
          ) :Text(
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
            '手续费：',
            style: TextStyle(
              color: Color(0xff757575),
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Obx(() => Text(
                controller.model.value?.charge ?? "",
                style: TextStyle(
                  color: Color(0xff111111),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              )),
          Expanded(child: SizedBox()),
          SafeClickGesture(
            onTap: () async {
              bool createSuccess = await controller.createCharge();
              lLog('MTMTMT OrderSendSellPage._bottomWidget ${createSuccess}');
              if (createSuccess) {
                showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.w),
                            topLeft: Radius.circular(10.w))),
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Colors.transparent,
                        height: 271.w,
                        child: Stack(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "收银台",
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 10.w,
                                  ),
                                  Text(
                                    "￥${controller.model.value?.charge}",
                                    style: TextStyle(fontSize: 30.sp),
                                  ),
                                  SizedBox(
                                    height: 34.w,
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    width: 335.w,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          Assets.iconsWechat,
                                          width: 28.w,
                                          height: 28.w,
                                        ),
                                        SizedBox(width: 10.w,),
                                        Text('微信支付'),
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Image.asset(
                                                Assets
                                                    .imagesShoppingCartGoodsSelected,
                                                width: 19.w,
                                                height: 19.w,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25.w,),
                                  SizedBox(
                                    width: 335.w,
                                    height: 44.w,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        controller.toWxPay();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(),
                                      ).copyWith(
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(0)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          AppColors.green.withOpacity(1),
                                        ),
                                        elevation: MaterialStateProperty.all(0),
                                      ),
                                      child: Text(
                                        "确认支付",
                                        style: TextStyle(
                                          color: AppColors.text_white
                                              .withOpacity(1),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              width: double.infinity,
                            )
                          ],
                        ),
                      );
                    });
              }
            },
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

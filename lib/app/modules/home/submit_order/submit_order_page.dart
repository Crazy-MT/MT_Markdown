import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/home/home_page.dart';
import 'package:code_zero/app/modules/mine/address_manage/model/address_list_model.dart';
import 'package:code_zero/app/modules/shopping_cart/model/shopping_cart_list_model.dart';
import 'package:code_zero/app/modules/snap_up/widget/success_dialog.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/components/safe_tap_widget.dart';
import '../../../routes/app_routes.dart';
import '../../main_tab/main_tab_page.dart';
import 'submit_order_controller.dart';

class SubmitOrderPage extends GetView<SubmitOrderController> {
  const SubmitOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "提交订单",
        centerTitle: true,
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Column(
              children: [
                Expanded(
                  child: _buildOrderInfo(),
                ),
                _buildBottomPrice(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildOrderInfo() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildLocalInfo(),
          Column(
            children: controller.goodsList.map<Widget>((element) {
              return _buildGoodsInfo(element);
            }).toList(),
          ),
          // _buildGoodsInfo(),
        ],
      ),
    );
  }

  _buildLocalInfo() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            if (controller.addressList.isEmpty) {
              return SizedBox.shrink();
            }
            return SafeTapWidget(
              onTap: () async {
                AddressItem address = await Get.toNamed(
                    RoutesID.ADDRESS_MANAGE_PAGE,
                    arguments: {'title': '选择地址'});
                controller.addressList.first = address;
              },
              child: Container(
                padding: EdgeInsets.all(19.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        controller.addressList[0].isDefault == 1
                            ? _addressDefaultIcon()
                            : SizedBox(),
                        controller.addressList[0].isDefault == 1
                            ? SizedBox(
                                width: 8.w,
                              )
                            : SizedBox.shrink(),
                        Text(
                          controller.addressList[0].region ?? "",
                          style: TextStyle(
                            color: Color(0xFFABAAB9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    Text(
                      controller.addressList[0].address ?? "",
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 14.w,
                    ),
                    Text(
                      controller.addressList[0].phone ?? "",
                      style: TextStyle(
                        color: Color(0xFFABAAB9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SvgPicture.asset(
            Assets.imagesLocalBottomBorder,
            width: 375.w,
            height: 4.w,
          ),
        ],
      ),
    );
  }

  Widget _addressDefaultIcon() {
    return Container(
      width: 32.w,
      height: 16.w,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.circular(8.w),
      ),
      child: Text(
        '默认',
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _buildGoodsInfo(ShoppingCartItem goods) {
    return Container(
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                Assets.iconsGoodsInfoTitleIcon,
                width: 19.w,
                height: 19.w,
              ),
              Text(
                goods.commodityName ?? "",
                style: TextStyle(
                  color: Color(0xFF434446),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.w,
          ),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: CachedNetworkImage(
                  imageUrl: goods.commodityThumbnail ?? "",
                  width: 80.w,
                  fit: BoxFit.cover,
                  height: 100.w,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      goods.commodityName ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 25.w,
                    ),
                    Text(
                      "共 ${goods.commodityCount} 件",
                      style: TextStyle(
                        color: Color(0xFFABAAB9),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 12.w,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "¥",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.text_dark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: goods.commodityPrice.toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.text_dark,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // TextSpan(
                          //   text: ".00",
                          //   style: TextStyle(
                          //     fontSize: 12.sp,
                          //     color: AppColors.text_dark,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildBottomPrice() {
    return Container(
      width: 375.w,
      height: 60.w + MediaQuery.of(Get.context!).padding.bottom,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(Get.context!).padding.bottom,
          left: 25.w,
          right: 10.w),
      color: Colors.white,
      child: Row(children: [
        Text(
          "总计：",
          style: TextStyle(
            color: Color(0xFF757575),
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '￥${controller.goodsList[0].commodityPrice.toString()}',
          style: TextStyle(
            color: AppColors.text_dark,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
          width: 100.w,
          height: 40.w,
          child: ElevatedButton(
            onPressed: () {
              controller.doCreateOrder();
            },
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ).copyWith(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              backgroundColor: MaterialStateProperty.all(
                AppColors.green,
              ),
              elevation: MaterialStateProperty.all(0),
            ),
            child: Text(
              "提交订单",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

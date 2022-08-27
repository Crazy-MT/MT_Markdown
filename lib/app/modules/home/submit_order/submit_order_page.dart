import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/snap_up/widget/success_dialog.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

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
    return CustomScrollView(
      slivers: [
        _buildLocalInfo(),
        _buildGoodsInfo(),
      ],
    );
  }

  _buildLocalInfo() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(19.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.w,
                          horizontal: 6.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(10.w),
                        ),
                        child: Text(
                          "默认",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "北京市朝阳区新街口街道",
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
                    "北苑路222号某某小区2栋2302",
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
                    "李旭  189****5667",
                    style: TextStyle(
                      color: Color(0xFFABAAB9),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              Assets.imagesLocalBottomBorder,
              width: 375.w,
              height: 4.w,
            ),
          ],
        ),
      ),
    );
  }

  _buildGoodsInfo() {
    return SliverToBoxAdapter(
      child: Container(
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
                  "8号宝库",
                  style: TextStyle(
                    color: Color(0xFF434446),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9',
                    width: 100.w,
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
                        "以心参玉 A货翡翠吊坠 男女男女男女男女男女男女",
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
                        "共 1 件",
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
                              text: "30000",
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ".00",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
          "¥ 30000.00",
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
              showSuccessDialog();
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

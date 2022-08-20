import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'fans_order_controller.dart';

class FansOrderPage extends GetView<FansOrderController> {
  const FansOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "粉丝订单",
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
            return CustomScrollView(
              slivers: [
                _buildHeader(),
                _buildOrderList(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildHeader() {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        width: 345.w,
        height: 100.w,
        margin: EdgeInsets.all(15.w).copyWith(bottom: 10.w),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesMyCommissionBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "订单总总额",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF434446),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8.w,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "¥",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "46447",
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "订单数",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xFF434446),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 8.w,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: "4",
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: AppColors.text_dark,
                          fontWeight: FontWeight.w500,
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

  _buildOrderList() {
    if (controller.orderList.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
            width: 345,
            height: 69.w,
            margin: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 3.w,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.w),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(15.w),
            child: Text("暂无记录")),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          return _buildOrderItem(index);
        },
        childCount: controller.orderList.length,
      ),
    );
  }

  _buildOrderItem(index) {
    return Container(
        width: 345,
        margin: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 5.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "订单号: D2022081684784724857",
                  style: TextStyle(
                    color: Color(0xFF434445),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Text(
                    "已完成",
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.w,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.w),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ff70181a20931f7807418b722b4accf9cbd89d0c6c08a-s3JzNf_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663056542&t=17f6675c5cb02a4c4c23dd11959387e9",
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
                        "以心参玉A货翡翠吊坠男女吊坠男女吊坠男女吊坠男女",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.text_dark,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "¥",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "30000",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: ".00",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.text_dark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 29.w,
                      ),
                      Text(
                        "佣金:¥ 300.00",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "归属人：",
                        style: TextStyle(
                          color: Color(0xFFABAAB9),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "仔仔妈",
                        style: TextStyle(
                          color: AppColors.text_dark,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "购买人：",
                          style: TextStyle(
                            color: Color(0xFFABAAB9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "仔仔",
                          style: TextStyle(
                            color: AppColors.text_dark,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

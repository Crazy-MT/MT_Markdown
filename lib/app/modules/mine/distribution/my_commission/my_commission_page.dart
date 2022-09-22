import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'my_commission_controller.dart';

class MyCommissionPage extends GetView<MyCommissionController> {
  const MyCommissionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "我的佣金",
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
          enablePullUp: true,
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: () {
            controller.getOrder(true);
          },
          onLoading: () {
            controller.getOrder(false);
          },
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                _buildHeader(),
                _buildCommissionList(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildHeader() {
    WalletModel? model = Get.arguments == null ? null :Get.arguments['model'];
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
                  "佣金总额",
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
                        text: model?.tranTotalPrice ?? "0",
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
                  "订单总额",
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
                        text: model?.tranTotalCount.toString() ?? "0",
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

  _buildCommissionList() {
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
          return _buildCommissionItem(index);
        },
        childCount: controller.orderList.length,
      ),
    );
  }

  _buildCommissionItem(index) {
    OrderItem? item = controller.orderList[index];
    return Container(
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
      padding: EdgeInsets.all(15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: item?.thumbnailUrl ?? "",
              width: 36.w,
              height: 36.w,
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "用户名：${item?.toUserNickname}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              SizedBox(
                height: 6.w,
              ),
              Text(
                item?.createdAt ?? "",
                style: TextStyle(
                  color: Color(0xFFABAAB9),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          Text(
            item?.commission ?? "",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

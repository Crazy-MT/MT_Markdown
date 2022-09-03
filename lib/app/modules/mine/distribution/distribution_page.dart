import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/extend.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/colors.dart';
import '../../../../common/components/common_app_bar.dart';
import '../../../../common/components/safe_tap_widget.dart';
import '../../../../generated/assets/assets.dart';
import 'distribution_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DistributionPage extends GetView<DistributionController> {
  const DistributionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "分销中心",
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
            () =>
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return CustomScrollView(
                  slivers: [
                    _buildHeaderContainer(),
                    _buildMenuList(),
                  ],
                );
              },
            ),
      ),
    );
  }

  _buildMenuList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (content, index) {
          return _buildMenuItem(index);
        },
        childCount: controller.menuList.length,
      ),
    );
  }

  _buildMenuItem(index) {
    var item = controller.menuList[index];
    return Container(
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // if (item.showTopDivider) _buildDivider(height: 10.w),
          SafeTapWidget(
            onTap: () {
              item.onClick?.call();
            },
            child: Container(
              height: 50.w,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      textAlign:
                      item.isCenter ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        color: item.titleColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  item.showArrow
                      ? Icon(
                    Icons.arrow_forward_ios,
                    color: Color(0xFFABAAB9),
                    size: 18.w,
                  )
                      : SizedBox(),
                ],
              ),
            ),
          ),
          if (item.showDivider) _buildDivider(),
        ],
      ),
    );
  }

  _buildDivider({height = 1.0}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      height: height,
      color: Color(0xFFF5F5F5),
    );
  }

  _buildHeaderContainer() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.all(15.w).copyWith(
          bottom: 20.w,
        ),
        width: 345.w,
        height: 123.w,
        decoration: BoxDecoration(
          color: AppColors.green,
          borderRadius: BorderRadius.circular(10.w),
          image: DecorationImage(
            image: AssetImage(
              Assets.imagesIncomeListTopBg,
            ),
            fit: BoxFit.fill,
          ),
        ),
        // padding: EdgeInsets.all(15.w).copyWith(top: 10.w),
        child: Obx(() {
          return Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                  top: 15.w,
                  left: 15.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "可提现佣金",
                        style: TextStyle(
                            color: S.colors.white.withOpacity(0.5),
                            fontSize: 13.sp),
                      ),
                      Text(
                        controller.model.value?.balance ?? "",
                        style: TextStyle(
                          color: S.colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  )),
              Positioned(
                bottom: 0,
                width: 345.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w),
                        bottomRight: Radius.circular(10.w)),
                    color: Color(0x7500bc72),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("累计获得",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                            Container(
                              alignment: Alignment.center,
                              height: 32.w,
                              child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      height: 1,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: controller.model.value?.commission,
                                        style: TextStyle(
                                          fontSize: 26.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      // TextSpan(
                                      //   text: ".00",
                                      //   style: TextStyle(
                                      //     fontSize: 18.sp,
                                      //     fontWeight: FontWeight.w500,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("今日获得",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  )),
                              Container(
                                height: 32.w,
                                alignment: Alignment.center,
                                child: Text(
                                  controller.model.value?.commissionToday ?? "",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("近七日获得",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                )),
                            Container(
                              height: 32.w,
                              alignment: Alignment.center,
                              child: Text(
                                controller.model.value?.commissionWeek ?? "",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

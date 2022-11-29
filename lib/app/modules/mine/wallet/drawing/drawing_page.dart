import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_page.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/custom_indicator.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'drawing_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawingPage extends GetView<DrawingController> {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "红包提现",
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
                return Column(
                  children: [
                    // Obx(() {
                    //   return Visibility(
                    //       visible: controller.currentIndex.value == 0,
                    //       child: _titleWidget());
                    // }),
                    _contentWrapperWidget(),
                  ],
                );
              },
            ),
      ),
    );
  }

/*
  Widget _titleWidget() {
    return Container(
      height: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
                '提取类型 ${controller.method.value}',
                style: TextStyle(
                  color: Color(0xff111111),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              )),
          GestureDetector(
            onTap: () async {
              controller.choose();
            },
            child: Row(
              children: [
                Text(
                  '设置收款信息',
                  style: TextStyle(
                    color: Color(0xff111111),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFABAAB9),
                  size: 10.w,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
*/

  Widget _contentWrapperWidget() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w), topRight: Radius.circular(20.w)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tabTitleWidget(),
            _tabContentWidget(),
          ],
        ),
      ),
    );
  }

  Widget _tabContentWidget() {
    return Expanded(
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.tabController,
        children: [_money(), _redEnvelopes()],
      ),
    );
  }

  _tabTitleWidget() {
    return Container(
      width: 220.w,
      height: 43.w,
      color: Colors.transparent,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: false,
        // padding: EdgeInsets.symmetric(horizontal: 60.w),
        indicator: CustomIndicator(
          width: 15.w,
          height: 3.5.w,
          color: AppColors.green,
        ),
        tabs: _tabItemWidget(controller.tabList),
        indicatorPadding: EdgeInsets.only(bottom: 5.w),
        labelColor: Color(0xff111111),
        unselectedLabelColor: Color(0xff757575),
        labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
      ),
    );
  }

  List<Widget> _tabItemWidget(List<String> data) {
    return data.map((String item) {
      return Text(item);
    }).toList();
  }

  _redEnvelopes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(25.w, 20.w, 25.w, 37.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '￥',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CommonInput(
                      controller: controller.balanceRedController,
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Divider(height: 1.w, color: Color(0xffF5F4F9)),
              SizedBox(height: 10.w),
              Row(
                children: [
                  Text(
                    '可提现金额：',
                    style: TextStyle(
                      color: Color(0xff434446),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Obx(() {
                    return Text(
                      controller.model.value?.redEnvelopeAmount ?? "0.00",
                      style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          child: SafeTapWidget(
            onTap: () {
              controller.createRedBalance();
            },
            child: Container(
              alignment: Alignment.center,
              height: 44.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(22.w),
              ),
              child: Text(
                '提现',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _money() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(25.w, 20.w, 25.w, 37.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '￥',
                    style: TextStyle(
                      color: Color(0xff111111),
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CommonInput(
                      controller: controller.balanceController,
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                        color: Color(0xff111111),
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.w),
              Divider(height: 1.w, color: Color(0xffF5F4F9)),
              SizedBox(height: 10.w),
              Row(
                children: [
                  Text(
                    '可提现金额：',
                    style: TextStyle(
                      color: Color(0xff434446),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Obx(() {
                    return Text(
                      controller.model.value?.balance ?? "",
                      style: TextStyle(
                        color: Color(0xff434446),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          child: SafeTapWidget(
            onTap: () {
              controller.createBalance();
            },
            child: Container(
              alignment: Alignment.center,
              height: 44.w,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(22.w),
              ),
              child: Text(
                '提现',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

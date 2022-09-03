import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/colors.dart';
import '../../../../common/components/common_app_bar.dart';
import 'complaint_feedback_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintFeedbackPage extends GetView<ComplaintFeedbackController> {
  const ComplaintFeedbackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "申诉反馈",
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
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.w),
                      topRight: Radius.circular(20.w))),
              margin: EdgeInsets.only(top: 10.w),
              child: _buildContent(),
            );
          },
        ),
      ),
    );
  }

  _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding:
              EdgeInsets.only(top: 20.w, left: 20.w, bottom: 10.w, right: 20.w),
          child: Text(
            "申诉意见",
            style: TextStyle(fontSize: 16.sp, color: Color(0xFF121212)),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15.w),
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          height: 288.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            style: TextStyle(
              color: const Color(0xFF111111),
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
            ),
            maxLength: 500,
            maxLines: 10,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "申诉意见越全，问题才能有效解决哦～",
                hintStyle: TextStyle(
                    color: Color(
                      0xffABAAB9,
                    ),
                    fontSize: 16.sp)),
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        _bottomBtn(),
      ],
    );
  }

  _bottomBtn() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1BDB8A),
        borderRadius: BorderRadius.circular(40.w),
      ),
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 44.w),
      height: 44.w,
      child: Center(
        child: Text(
          "提交申诉",
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ),
    );
  }
}

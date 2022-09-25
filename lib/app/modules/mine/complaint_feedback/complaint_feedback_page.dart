import 'dart:io';

import 'package:code_zero/generated/assets/assets.dart';
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
      resizeToAvoidBottomInset: false,
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
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.w),
                          topRight: Radius.circular(20.w))),
                  margin: EdgeInsets.only(top: 10.w),
                  child: _buildContent(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0.w,
                  child: _bottomBtn(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          // height: 288.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              TextField(
                style: TextStyle(
                  color: const Color(0xFF111111),
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                ),
                onChanged: (value) {
                  controller.textCount.value = value.length;
                },
                maxLength: 500,
                maxLines: 9,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "申诉意见越全，问题才能有效解决哦～",
                  hintStyle: TextStyle(
                      color: Color(
                        0xffABAAB9,
                      ),
                      fontSize: 16.sp),
                ),
              ),
              _photoAdd(),
            ],
          ),
        ),
      ],
    );
  }

  _bottomBtn(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          if (controller.textCount.value <= 0) {
            return;
          }
          // TODO
          print("触发提交接口---");
        },
        child: Container(
          decoration: BoxDecoration(
            color: controller.textCount.value > 0
                ? Color(0xff1BDB8A)
                : Color(0xffBAEED8),
            borderRadius: BorderRadius.circular(40.w),
          ),
          margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              bottom: MediaQuery.of(context).padding.bottom + 20),
          height: 44.w,
          child: Center(
            child: Text(
              "提交申诉",
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
            ),
          ),
        ),
      ),
    );
  }

  _photoAdd() {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10.w),
        height: 80.w,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return _photoItem(index);
          },
          itemCount: controller.photoItems.length,
        ),
      ),
    );
  }

  _photoItem(int index) {
    return controller.photoItems[index] == "add"
        ? Visibility(
            visible: controller.photoItems.length < 5,
            child: GestureDetector(
              onTap: () {
                controller.addImage();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Image.asset(
                  Assets.iconsAdd,
                  width: 80.w,
                ),
              ),
            ),
          )
        : Container(
            margin: EdgeInsets.only(right: 10.w),
            height: 80.w,
            width: 80.w,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Obx(
                    () => Image.file(
                      File(controller.photoItems[index]),
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 3.w,
                  top: 3.w,
                  child: GestureDetector(
                    onTap: () {
                      controller.removeImage(index);
                    },
                    child: Image.asset(
                      Assets.iconsDelete,
                      width: 25.w,
                      height: 25.w,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

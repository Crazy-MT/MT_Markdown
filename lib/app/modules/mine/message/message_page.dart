import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'message_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
        titleText: "平台消息",
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
          footer: SliverToBoxAdapter(
            child: SizedBox.shrink(),
          ),
          enablePullUp: true,
          enablePullDown: true,
          controller: controller.refreshController,
          onRefresh: () {
            controller.getMessageList();
          },
          onLoading: () {
            controller.getMessageList(isRefresh: false);
          },
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                Obx(() {
                  return _buildMessageList();
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildMessageList() {
    if (controller.messageList.length == 0) {
      return SliverPadding(
        padding: EdgeInsets.all(15.w).copyWith(top: 10.w),
        sliver: SliverToBoxAdapter(
          child: Container(
            width: 335.w,
            height: 80.w,
            alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10.w),
            //   color: Colors.white,
            // ),
            child: Text(
              "暂无消息",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.text_dark,
              ),
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsets.all(15.w).copyWith(top: 10.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (content, index) {
            return _buildMessageItem(index);
          },
          childCount: controller.messageList.length,
        ),
      ),
    );
  }

  _buildMessageItem(index) {
    var item = controller.messageList[index];
    return Column(
      children: [
        Text(item.createdAt ?? "",
            style: TextStyle(
              color: Color(0xffABAAB9),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            )),
        SizedBox(height: 10.h,),
        Container(
          width: 335.w,
          margin: EdgeInsets.only(bottom: 10.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.msgTitle ?? "",
                      style: TextStyle(
                        color: AppColors.text_dark,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3.w),
                    Text(
                      item.msgContent ?? "",
                      style: TextStyle(
                        color: Color(0xffABAAB9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

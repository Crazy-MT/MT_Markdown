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
      backgroundColor: Color(0xFFFFFFFF),
      appBar: CommonAppBar(
        titleText: "消息",
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
                _buildMessageList(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildMessageList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (content, index) {
          return _buildMessageItem(index);
        },
        childCount: controller.messageList.length,
      ),
    );
  }

  _buildMessageItem(index) {
    var item = controller.messageList[index];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            index == 0
                ? Assets.imagesMessagePlatform
                : Assets.imagesMessagePrivate,
            width: 50,
            height: 50,
          ),
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item,
                  style: TextStyle(
                    color: AppColors.text_dark,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.w),
                Text(
                  item,
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
    );
  }
}

import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bind_recommend_controller.dart';

class BindRecommendPage extends GetView<BindRecommendController> {
  const BindRecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        titleText: "绑定推荐人",
        centerTitle: true,
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Column(
              children: [
                _buildVerifyCodeInput(),
                _buildRecommendCode(),
                _buildBindBtn(),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildVerifyCodeInput() {
    return buildInputWithTitle(
      Row(
        children: [
          Text(
            "短信验证码",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF121212),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ),
            height: 19.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Color(0xFFDDF3EA),
            ),
            child: Text(
              controller.phoneNumber.value,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF757575),
                height: 1,
              ),
            ),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w).copyWith(
        bottom: 15.w,
      ),
      inputController: controller.verifyCodeController,
      hintText: "输入短信验证码",
      suffixWidget: SizedBox(
        width: 87.w,
        height: 30.w,
        child: ElevatedButton(
          onPressed: controller.sendSmsCountdown.value <= 0
              ? () {
                  // controller.login();
                }
              : null,
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ).copyWith(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
              AppColors.green.withOpacity(
                  controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
            ),
          ),
          child: Text(
            "获取验证码",
            style: TextStyle(
              color: Colors.white.withOpacity(
                  controller.sendSmsCountdown.value <= 0 ? 1 : 0.5),
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }

  _buildRecommendCode() {
    return buildInputWithTitle(
      Text(
        "邀请码",
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF121212),
        ),
      ),
      padding: EdgeInsets.all(20.w).copyWith(top: 0, bottom: 15.w),
      inputController: controller.recommendCodeController,
      hintText: "输入邀请码",

    );
  }

  _buildBindBtn() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        bottom: 15.w,
      ),
      child: SizedBox(
        width: 335.w,
        height: 44.w,
        child: ElevatedButton(
          onPressed: controller.bindBtnEnable.value
              ? () {
                  controller.bindRecommendCode();
                }
              : null,
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ).copyWith(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all(
              AppColors.green
                  .withOpacity(controller.bindBtnEnable.value ? 1 : 0.5),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Text(
            "确认绑定",
            style: TextStyle(
              color: Colors.white
                  .withOpacity(controller.bindBtnEnable.value ? 1 : 0.5),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

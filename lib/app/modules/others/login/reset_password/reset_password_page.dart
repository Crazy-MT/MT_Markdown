import 'package:code_zero/app/modules/others/login/login_controller.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/utils.dart';
import 'reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        child: Obx(
          () => Text(
            controller.isForget.value ? '忘记密码' : '重置密码',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.text_dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
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
            return Obx(
              () => Column(
                children: [
                  _buildVerifyCodeInput(),
                  _buildNewPassword(),
                  _buildConfirmPassword(),
                  _buildResetBtn(),
                ],
              ),
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
                  controller.startCountDown();
                  controller.getSMS();
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
            controller.sendSmsCountdown.value <= 0
                ? "获取验证码"
                : "${controller.sendSmsCountdown.value}s",
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

  _buildNewPassword() {
    return buildInputWithTitle(
      Text(
        "新密码",
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF121212),
        ),
      ),
      padding: EdgeInsets.all(20.w).copyWith(top: 0, bottom: 15.w),
      inputController: controller.newPasswordController,
      hintText: "输入新登录密码",
      obscureText: !controller.showNewPassword.value,
      suffixWidget: IconButton(
        onPressed: () {
          controller.showNewPassword.value = !controller.showNewPassword.value;
        },
        padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          controller.showNewPassword.value
              ? Assets.iconsVisible
              : Assets.iconsInvisible,
          width: 22.w,
          height: 22.w,
        ),
      ),
    );
  }

  _buildConfirmPassword() {
    return buildInputWithTitle(
      Text(
        "新密码确认",
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: Color(0xFF121212),
        ),
      ),
      padding: EdgeInsets.all(20.w).copyWith(top: 0, bottom: 15.w),
      inputController: controller.confirmPasswordController,
      hintText: "新登录密码确认",
      obscureText: !controller.showConfirmPassword.value,
      suffixWidget: IconButton(
        onPressed: () {
          controller.showConfirmPassword.value =
              !controller.showConfirmPassword.value;
        },
        padding: EdgeInsets.zero,
        icon: SvgPicture.asset(
          controller.showConfirmPassword.value
              ? Assets.iconsVisible
              : Assets.iconsInvisible,
          width: 22.w,
          height: 22.w,
        ),
      ),
    );
  }

  _buildResetBtn() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        bottom: 15.w,
      ),
      child: SizedBox(
        width: 335.w,
        height: 44.w,
        child: ElevatedButton(
          onPressed: controller.resetBtnEnable.value
              ? () {
                  if (controller.newPasswordController.text ==
                      controller.confirmPasswordController.text) {
                    controller.resetPwd();
                  } else {
                    Utils.showToastMsg("两次密码不一致，请重新输入");
                    controller.newPasswordController.text = "";
                    controller.confirmPasswordController.text = "";
                  }
                }
              : null,
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
          ).copyWith(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all(
              AppColors.green
                  .withOpacity(controller.resetBtnEnable.value ? 1 : 0.5),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Text(
            "重置密码",
            style: TextStyle(
              color: AppColors.text_white
                  .withOpacity(controller.resetBtnEnable.value ? 1 : 0.5),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

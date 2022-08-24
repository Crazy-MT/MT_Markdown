import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        child: Obx(
          () => Text(
            controller.isPasswordLogin.value ? '密码登录' : '短信登录',
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
            return SingleChildScrollView(
              child: Obx(
                () => Column(
                  children: [
                    _buildPhoneInput(),
                    _buildPasswordInput(),
                    _buildLoginType(),
                    _buildPrivacyPolicy(),
                    _buildLoginBtn(),
                    Text(
                      "未注册的手机号验证后可自动登录",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFFABAAB9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildPhoneInput() {
    return _buildInput(
      "手机号",
      inputController: controller.phoneController,
      hintText: "输入手机号",
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 50.w),
      suffixWidget: controller.showClearPhoneInput.value
          ? IconButton(
              onPressed: () {
                controller.phoneController.clear();
              },
              icon: Icon(
                Icons.cancel_rounded,
                size: 14.w,
                color: Color(0xFFCFCFCF),
              ))
          : SizedBox(),
    );
  }

  _buildPasswordInput() {
    return _buildInput(
      controller.isPasswordLogin.value ? "登录密码" : "验证码",
      inputController: controller.passwordController,
      hintText: controller.isPasswordLogin.value ? "输入登录密码" : "输入验证码",
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 18.w),
      obscureText: controller.isPasswordLogin.value && !controller.showPassword.value,
      suffixWidget: controller.isPasswordLogin.value
          ? IconButton(
              onPressed: () {
                controller.showPassword.value = !controller.showPassword.value;
              },
              icon: SvgPicture.asset(
                controller.showPassword.value ? Assets.iconsVisible : Assets.iconsInvisible,
                width: 22.w,
                height: 22.w,
              ),
            )
          : TextButton(
              onPressed: controller.sendCodeCountDown.value > 0
                  ? null
                  : () {
                      controller.startCountDown();
                      controller.getSMS();
                    },
              child: Text(
                controller.sendCodeCountDown.value <= 0 ? "获取验证码" : "${controller.sendCodeCountDown.value}s",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.text_dark,
                ),
              ),
            ),
    );
  }

  _buildInput(
    String title, {
    EdgeInsetsGeometry? padding,
    TextEditingController? inputController,
    String? hintText,
    Widget? suffixWidget,
    bool obscureText = false,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Color(0xFF757575),
              ),
            ),
          ),
          SizedBox(
            height: 47.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CommonInput(
                    obscureText: obscureText,
                    controller: inputController,
                    fillColor: Colors.transparent,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.text_dark,
                    ),
                    hintText: hintText,
                  ),
                ),
                suffixWidget != null ? suffixWidget : Container(),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.w,
            color: Color(0xFFF5F4F9),
          ),
        ],
      ),
    );
  }

  _buildLoginType() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                controller.isPasswordLogin.value = !controller.isPasswordLogin.value;
                controller.passwordController.clear();
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    controller.isPasswordLogin.value ? Assets.iconsSmsLogin : Assets.iconsPasswordLogin,
                    width: 16.w,
                    height: 16.w,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    controller.isPasswordLogin.value ? "短信登录" : "密码登录",
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )),
          Expanded(child: SizedBox()),
          TextButton(
            onPressed: () {
              controller.forgetPasswordClick();
            },
            child: Text(
              "忘记密码",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildPrivacyPolicy() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
      ),
      child: Row(
        children: [
          SafeTapWidget(
            onTap: () {
              controller.agreePrivacyPolicy.value = !controller.agreePrivacyPolicy.value;
              controller.checkCanLogin();
            },
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Image.asset(
                controller.agreePrivacyPolicy.value ? Assets.imagesShoppingCartGoodsSelected : Assets.imagesShoppingCartGoodsUnselected,
                width: 16.w,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: "我已阅读并同意",
              style: TextStyle(
                color: Color(0xFF696873),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: "《用户隐私政策》",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildLoginBtn() {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.w,
        bottom: 15.w,
      ),
      child: SizedBox(
        width: 335.w,
        height: 44.w,
        child: ElevatedButton(
          onPressed: controller.enableLogin.value
              ? () {
                  controller.login();
                }
              : null,
          // style: ButtonStyle(
          //   padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
          //   backgroundColor: MaterialStateProperty.all(AppColors.green),
          // ),
          style: ElevatedButton.styleFrom(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(12), // <-- Radius
            // ),
            shape: StadiumBorder(),
          ).copyWith(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            backgroundColor: MaterialStateProperty.all(
              AppColors.green.withOpacity(controller.enableLogin.value ? 1 : 0.5),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Text(
            "立即登录",
            style: TextStyle(
              color: AppColors.text_white.withOpacity(controller.enableLogin.value ? 1 : 0.5),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

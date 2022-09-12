import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/common_input.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/main.dart';
import 'package:code_zero/utils/input_format_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'auth_check_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthCheckPage extends GetView<AuthCheckController> {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        child: Text('身份核验',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.text_dark,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            Get.back(result: false);
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
                    _buildNameInput(),
                    _buildIDCodeInput(),
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

  _buildNameInput() {
    return _buildInput(
      "真实姓名",
      inputController: controller.nameController,
      hintText: "输入您的姓名",
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 50.w),
      keyboardType: TextInputType.text,
      suffixWidget: controller.showClearPhoneInput.value
          ? IconButton(
          onPressed: () {
            controller.nameController.clear();
          },
          icon: Icon(
            Icons.cancel_rounded,
            size: 14.w,
            color: Color(0xFFCFCFCF),
          ))
          : SizedBox(),
    );
  }

  _buildIDCodeInput() {
    return _buildInput('身份证号',
      inputController: controller.idCodeController,
      hintText: '输入身份证号码',
      padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 18.w),
      keyboardType: TextInputType.number,
      obscureText: false,
        suffixWidget: controller.showClearIdInput.value
            ? IconButton(
            onPressed: () {
              controller.idCodeController.clear();
            },
            icon: Icon(
              Icons.cancel_rounded,
              size: 14.w,

              color: Color(0xFFCFCFCF),
            ))
            : SizedBox()
    );
  }

  _buildInput(
      String title, {
        EdgeInsetsGeometry? padding,
        TextEditingController? inputController,
        String? hintText,
        Widget? suffixWidget,
        bool obscureText = false,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters,
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
                    inputFormatters: inputFormatters,
                    keyboardType: keyboardType,
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
          onPressed: controller.enableConfirm.value
              ? () {
            controller.check();
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
              AppColors.green
                  .withOpacity(controller.enableConfirm.value ? 1 : 0.5),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
          child: Text(
            "提交信息",
            style: TextStyle(
              color: AppColors.text_white
                  .withOpacity(controller.enableConfirm.value ? 1 : 0.5),
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}

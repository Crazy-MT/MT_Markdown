import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        titleText: '登录',
        centerTitle: true,
        fontSize: 22.sp,
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.login();
                },
                child: Text(
                  "Login Over To Home Page",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.text_dark,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

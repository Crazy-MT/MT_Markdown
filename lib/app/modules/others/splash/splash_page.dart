import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'splash_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                    width: double.infinity,
                    child: Image.asset(
                      Assets.imagesBgSplash,
                      fit: BoxFit.fill,
                    )),
                Positioned(
                  bottom: 60.w,
                  child: Obx(() => AnimatedOpacity(
                        curve: Curves.easeInToLinear,
                        opacity: controller.opacity.value,
                        duration: Duration(seconds: 1),
                        child: Container(
                          width: 375.w,
                          child: Column(
                            children: [
                              Image.asset(
                                Assets.iconsSplashLogo,
                                width: 70.w,
                                height: 70.w,
                              ),
                              Center(
                                child: Text(
                                  "传翠宝库",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

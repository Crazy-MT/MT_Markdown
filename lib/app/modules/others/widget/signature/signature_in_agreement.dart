import 'package:cached_network_image/cached_network_image.dart';
import 'package:code_zero/app/modules/others/widget/signature/signature_in_agree_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignatureInAgreement extends StatelessWidget {
  late final SignatureInArgeeController controller;
  @override
  StatelessElement createElement() {
    controller = Get.put(SignatureInArgeeController());
    return super.createElement();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: controller.signImgUrl.isEmpty
              ? SafeTapWidget(
                  onTap: () {
                    Get.toNamed(RoutesID.SIGNATURE_PAGE);
                  },
                  child: Container(
                    width: 335.w,
                    height: 178.w,
                    color: Color(0xFFF5F5F5),
                    padding: EdgeInsets.all(15.w),
                    child: Text(
                      "签名即同意此协议",
                      style: TextStyle(
                        color: Color(0xFFABAAB9),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              : CachedNetworkImage(
                  imageUrl: controller.signImgUrl.value,
                  width: 335.w,
                  height: 178.w,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 25.w,
            bottom: 25.w + MediaQuery.of(Get.context!).padding.bottom,
          ),
          child: SizedBox(
            width: 335.w,
            height: 44.w,
            child: ElevatedButton(
              onPressed: controller.signImgUrl.value.isNotEmpty
                  ? () {
                      // controller.login();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ).copyWith(
                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                backgroundColor: MaterialStateProperty.all(
                  AppColors.green.withOpacity(controller.signImgUrl.value.isNotEmpty ? 1 : 0.5),
                ),
                elevation: MaterialStateProperty.all(0),
              ),
              child: Text(
                "同意此协议",
                style: TextStyle(
                  color: AppColors.text_white.withOpacity(controller.signImgUrl.value.isNotEmpty ? 1 : 0.5),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

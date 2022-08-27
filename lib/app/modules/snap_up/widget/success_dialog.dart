import 'package:code_zero/common/colors.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _SuccessDialog extends StatelessWidget {
  final VoidCallback? onConfirm;

  const _SuccessDialog({Key? key, this.onConfirm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  Assets.imagesDialogBgBg2,
                  width: 260.w,
                  height: 260.w,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.w),
                  child: Image.asset(
                    Assets.imagesDialogBgBg1,
                    width: 191.w,
                    height: 68.w,
                  ),
                ),
                Image.asset(
                  Assets.iconsDialogSuccess,
                  width: 60.w,
                  height: 60.w,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 100.w,
                  ),
                  child: Text(
                    "抢购成功！",
                    style: TextStyle(
                      color: AppColors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      letterSpacing: 5.w,
                    ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3F9FB),
                borderRadius: BorderRadius.circular(25.w),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.w),
              child: Text(
                "您可在 “我的>我的仓库” 中查看订单",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF757575),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.w),
              width: 150.w,
              height: 36.w,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(result: "1");
                  onConfirm?.call();
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ).copyWith(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.green,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: Text(
                  "确定",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showSuccessDialog({
  VoidCallback? onConfirm,
}) {
  Get.dialog(
    _SuccessDialog(
      onConfirm: onConfirm,
    ),
  );
}

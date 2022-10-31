import 'package:code_zero/common/S.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

import 'photo_view_controller.dart' as a;
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoViewPage extends GetView<a.PhotoViewController> {
  const PhotoViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RepaintBoundary(
          key: controller.repaintWidgetKey,
          child: PhotoView(
            onTapUp: (_, __, ___) {
              Get.back();
            },
            imageProvider: NetworkImage(
              Get.arguments?['url'] ?? "",
              // maxWidth: 115,
              // maxHeight: 123,
              // fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
            bottom: 100.w,
            right: 30.w,
            child: SafeTapWidget(
              onTap: () {
                controller.savaImage();
              },
              child: Container(
                width: 80.w,
                height: 40.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(22.w),
                ),
                child: Text(
                  '保存',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}

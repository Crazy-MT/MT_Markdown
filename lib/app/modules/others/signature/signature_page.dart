import 'dart:math';

import 'package:code_zero/app/modules/others/signature/signature_widget.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'signature_controller.dart';

class SignaturePage extends GetView<SignatureController> {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          physics: NeverScrollableScrollPhysics(),
          builder: (BuildContext context) {
            return SizedBox(
              width: 375.w,
              height: 812.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: 45.w,
                    child: UnconstrainedBox(
                      child: _buildCanvas(),
                    ),
                  ),
                  Positioned(
                    right: 5.w,
                    top: 40.w,
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Padding(
                          padding: EdgeInsets.all(15.w),
                          child: Text(
                            "请签字",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF111111),
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    bottom: 39.w,
                    left: 16.w,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 40.w,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.clearPan();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                              ).copyWith(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xFFF3F9FB),
                                ),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Text(
                                "清空",
                                style: TextStyle(
                                  color: AppColors.text_dark,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 40.w,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                              ).copyWith(
                                padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xFFF3F9FB),
                                ),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Text(
                                "取消",
                                style: TextStyle(
                                  color: AppColors.text_dark,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          SizedBox(
                            width: 100.w,
                            height: 40.w,
                            child: ElevatedButton(
                              onPressed: () {
                                // controller.saveSignature();
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
                                "确认",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _buildCanvas() {
    return GestureDetector(
      onPanDown: (details) {
        var localPosition = details.localPosition;
        if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
        if (localPosition.dx > 260.w || localPosition.dy > 732.h) return;
        controller.onPanStart(details.localPosition);
      },
      onPanStart: (details) {
        var localPosition = details.localPosition;
        if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
        if (localPosition.dx > 260.w || localPosition.dy > 732.h) return;
        controller.onPanStart(details.localPosition);
      },
      onPanUpdate: (details) {
        var localPosition = details.localPosition;
        if (localPosition.dx <= 0 || localPosition.dy <= 0) return;
        if (localPosition.dx > 260.w || localPosition.dy > 732.h) return;
        controller.onPanUpdate(details.localPosition);
      },
      onPanCancel: () {},
      onPanEnd: (details) {
        controller.onPanEnd();
      },
      child: RepaintBoundary(
        key: controller.globalKey,
        child: Container(
          height: 732.h,
          width: 260.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Color(0xFFF5F5F5),
          ),
          child: SignatureWidget(),
        ),
      ),
    );
  }
}

class SignatuePainter extends CustomPainter {
  List<Offset?> points = [];
  double mStrokeWidth = 5;
  final double rate = 0.3;

  SignatuePainter(this.points, mStrokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    if (mStrokeWidth == 0) {
      mStrokeWidth = 5;
    }
    Paint paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = Colors.black
      ..isAntiAlias = true
      ..strokeWidth = mStrokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        var dx = points[i]!.dx - points[i + 1]!.dx;
        var dy = points[i]!.dy - points[i + 1]!.dy;
        var dis = sqrt(dx * dx + dy * dy);
        if (dis > 5) {
          paint.strokeWidth = max(paint.strokeWidth - rate, mStrokeWidth - 2);
        } else if (dis < 5) {
          paint.strokeWidth = min(paint.strokeWidth + rate, mStrokeWidth + 2);
        }
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignatuePainter oldDelegate) {
    return points != oldDelegate.points;
  }
}

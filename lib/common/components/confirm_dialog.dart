import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class _ConfirmDialog extends StatelessWidget {
  final String title;
  final TextAlign? titleAlign;
  final String content;
  final TextAlign? contentAlign;

  final Widget? contentWidget;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final VoidCallback? onSingle;

  final Color? confirmTextColor;

  final String cancelText;
  final String confirmText;
  final String? singleText;
  final bool? canNotDismiss;

  const _ConfirmDialog({
    Key? key,
    this.title = "",
    this.titleAlign,
    this.content = "",
    this.contentAlign,
    this.onConfirm,
    this.onCancel,
    this.contentWidget,
    this.cancelText = "取消",
    this.confirmText = "确定",
    this.confirmTextColor,
    this.singleText,
    this.onSingle,
    this.canNotDismiss
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: UnconstrainedBox(
        child: Container(
          width: 300.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.w),
          ),
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              if (title.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    textAlign: titleAlign ?? TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.text_dark,
                    ),
                  ),
                ),
              SizedBox(
                height: 20.w,
              ),
              if (contentWidget != null) contentWidget!,
              if (content.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    content,
                    textAlign: contentAlign ?? TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text_dark,
                    ),
                  ),
                ),
              SizedBox(
                height: 40.w,
              ),
              if(singleText != null && (singleText?.isNotEmpty ?? false))
                SizedBox(
                  width: 126.w,
                  height: 36.w,
                  child: ElevatedButton(
                    onPressed: () {
                      if(!(canNotDismiss ?? false)) {
                        Get.back(
                          result: true,
                        );
                      }
                      onSingle?.call();
                    },
                    child: Text(
                      singleText ?? "",
                      style: TextStyle(
                        color: confirmTextColor ?? AppColors.text_white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                    ).copyWith(
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(0)),
                      backgroundColor:
                      MaterialStateProperty.all(AppColors.green),
                      elevation: MaterialStateProperty.all(0),
                    ),
                  ),
                ),
              if (singleText == null && (singleText?.isEmpty ?? true))
                Row(
                  children: [
                    SizedBox(
                      width: 126.w,
                      height: 36.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back(
                            result: false,
                          );
                          onCancel?.call();
                        },
                        child: Text(
                          cancelText,
                          style: TextStyle(
                            color: AppColors.text_dark,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ).copyWith(
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.all(0)),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFF3F9FB)),
                          elevation: MaterialStateProperty.all(0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: 126.w,
                      height: 36.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back(
                            result: true,
                          );
                          onConfirm?.call();
                        },
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            color: confirmTextColor ?? AppColors.text_white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                        ).copyWith(
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.all(0)),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.green),
                          elevation: MaterialStateProperty.all(0),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showConfirmDialog({
  String title = "",
  TextAlign? titleAlign,
  String content = "",
  TextAlign? contentAlign,
  Widget? contentWidget,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  VoidCallback? onSingle,
  String cancelText = "取消",
  String confirmText = "确定",
  String? singleText,
  Color? confirmTextColor,
  bool barrierDismissible = true,
  bool canNotDismiss = false
}) async {
  var result = await Get.dialog(_ConfirmDialog(
      title: title,
      titleAlign: titleAlign,
      content: content,
      contentAlign: contentAlign,
      contentWidget: contentWidget,
      onConfirm: onConfirm,
      onCancel: onCancel,
      cancelText: cancelText,
      confirmText: confirmText,
      confirmTextColor: confirmTextColor,
      onSingle: onSingle,
      canNotDismiss: canNotDismiss,
      singleText: singleText), barrierDismissible: barrierDismissible);
  if (result == true) return true;
  return false;
}

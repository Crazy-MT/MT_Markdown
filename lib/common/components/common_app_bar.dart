// ignore_for_file: annotate_overrides, overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

class CommonAppBar extends AppBar {
  final String? titleText;
  final Widget? child;
  final bool centerTitle;
  final Color? iconThemeColor;
  final double? fontSize;
  final Widget? leading;
  final List<Widget>? actions;
  CommonAppBar({
    Key? key,
    this.fontSize,
    this.iconThemeColor,
    this.centerTitle = false,
    this.titleText,
    this.child,
    this.leading,
    this.actions,
  }) : super(
          key: key,
          elevation: 0.2,
          shadowColor: AppColors.gray_light,
          title: child ??
              Text(titleText ?? "",
                  style: TextStyle(
                    fontSize: fontSize ?? 18.sp,
                    color: AppColors.text_dark,
                    fontWeight: FontWeight.w500,
                  )),
          iconTheme:
              IconThemeData(color: iconThemeColor ?? AppColors.text_dark),
          actionsIconTheme: const IconThemeData(color: AppColors.text_dark),
          leading: leading,
          backgroundColor: Colors.white,
          centerTitle: centerTitle,
          actions: actions,
        );
}

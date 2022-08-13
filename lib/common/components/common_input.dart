import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../colors.dart';

enum InputTheme {
  cerulean,
  orange,
}

class CommonInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? errorText;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextStyle? style;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final OutlineInputBorder? enabledBorder,
      errorBorder,
      focusedBorder,
      focusedErrorBorder;
  final InputTheme theme;

  const CommonInput({
    Key? key,
    this.controller,
    this.hintText,
    this.errorText,
    this.labelText,
    this.onChanged,
    this.suffixIcon,
    this.style,
    this.fillColor,
    this.obscureText = false,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.inputFormatters,
    this.keyboardType,
    this.theme = InputTheme.orange,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      style: style ??
          TextStyle(
            color: const Color(0xFF0E0D1F),
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      cursorColor: getColors()[0],
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: fillColor ?? const Color(0xFFF0F0F0),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: EdgeInsets.only(left: 15.w),
        errorText: errorText,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide:
                  BorderSide(width: 1.w, color: const Color(0xFFF0F0F0)),
              borderRadius: BorderRadius.circular(6.w),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: Colors.red),
              borderRadius: BorderRadius.circular(6.w),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: getColors()[1]),
              borderRadius: BorderRadius.circular(6.w),
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(width: 2.w, color: getColors()[1]),
              borderRadius: BorderRadius.circular(6.w),
            ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  List<Color> getColors() {
    switch (theme) {
      case InputTheme.cerulean:
        return [AppColors.cerulean, AppColors.cerulean_light];
      case InputTheme.orange:
        return [AppColors.orange, AppColors.orange_light];
    }
  }
}

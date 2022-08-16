import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final TextStyle? hintStyle;
  final Color? fillColor;
  final Color? cursorColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool enable;
  final TextAlign textAlign;

  const CommonInput({
    Key? key,
    this.controller,
    this.hintText,
    this.errorText,
    this.labelText,
    this.onChanged,
    this.suffixIcon,
    this.style,
    this.hintStyle,
    this.fillColor,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.cursorColor,
    this.enable = true,
    this.textAlign = TextAlign.start,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enable,
      obscureText: obscureText,
      onChanged: onChanged,
      textAlign: textAlign,
      style: style ??
          TextStyle(
            color: const Color(0xFF0E0D1F),
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      cursorColor: cursorColor ?? AppColors.green,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ??
            TextStyle(
              color: Color(0xFFD9D9D9),
              fontSize: 20.w,
              fontWeight: FontWeight.w600,
            ),
        fillColor: fillColor ?? Colors.white, //背景颜色，必须结合filled: true,才有效
        filled: true, //重点，必须设置为true，fillColor才有效
        isCollapsed: true, //重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
        contentPadding:
            EdgeInsets.symmetric(horizontal: 5, vertical: 7), //内容内边距，影响高度
        border: _outlineInputBorder, //边框，一般下面的几个边框一起设置
        focusedBorder: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        disabledBorder: _outlineInputBorder,
        focusedErrorBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder,
      ),
    );
  }
}

//无边框样式
OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  gapPadding: 0,
  borderSide: BorderSide.none,
);

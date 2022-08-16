import 'package:code_zero/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnapUpTitle extends StatelessWidget {
  final String name;

  const SnapUpTitle({Key? key, required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.w,
      width: 22.w * name.length,
      child: Stack(
        children: _getChild(),
      ),
    );
  }

  List<Widget> _getChild() {
    List<String> names = name.split('');
    List<Widget> children = [];
    for (var i = 0; i < names.length; i++) {
      children.add(
        Positioned(
          child: Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(24.w),
              border: Border.all(
                width: 1.w,
                color: AppColors.gold_d0a06d,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              names[i],
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xFFFFECD3),
              ),
            ),
          ),
          left: i * 21.w,
        ),
      );
    }
    return children;
  }
}

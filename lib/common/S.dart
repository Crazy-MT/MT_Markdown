import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class S {
  static final colors = _Colors();
  static final textStyles = _TextStyles();
  static final shadows = _Shadows();
}

class _Colors {
  final transparent = Colors.transparent;
  final black = Colors.black;
  final black87 = Colors.black87;
  final white = Colors.white;
  final customColor = const Color(0xff000000);
  final black11 = const Color(0xff111111);

  final red = Colors.redAccent;

  final text_dark = Color(0xff757575);
}

class _TextStyles {
  final f10Regular = TextStyle(
    fontSize: 10,
    color: S.colors.black,
  );

  final black = TextStyle(
    color: S.colors.black,
  );

  final red = TextStyle(
    color: S.colors.red,
  );

  final grey = TextStyle(color: Color(0xff757575), fontSize: 12.sp);

  final green = TextStyle(
    fontSize: 14.sp,
    color: AppColors.green,
  );

  final timer = TextStyle(color: Colors.white, fontSize: 14.sp);
}

class _Shadows {
  final softShadow = [
    const BoxShadow(
      blurRadius: 20,
      offset: Offset(0, 2),
    )
  ];

  final hardShadow = [
    const BoxShadow(
      blurRadius: 20,
      offset: Offset(0, 2),
    )
  ];
}

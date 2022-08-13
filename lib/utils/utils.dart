import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../common/colors.dart';

class Utils {
  static showToastMsg(String msg) {
    showToastWidget(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.text_dark,
        ),
        margin: const EdgeInsets.only(left: 53, right: 53),
        padding: const EdgeInsets.all(15),
        child: Text(
          msg,
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
            leading: 0.4,
          ),
        ),
      ),
      position:
          const ToastPosition(align: Alignment.bottomCenter, offset: -120),
      dismissOtherToast: true,
      duration: const Duration(seconds: 2),
    );
  }
}

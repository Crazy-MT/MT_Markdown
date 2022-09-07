import 'package:code_zero/utils/log_utils.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
import 'package:package_info/package_info.dart';
import 'package:sp_util/sp_util.dart';

import '../utils/device_util.dart';
import 'colors.dart';
import 'user_helper.dart';
// AppID：wxe02b86dc09511f64
// AppSecret: 4dae550e17cbf41d654052f9866cee5d

class _Common {
  _Common();
  PackageInfo? packageInfo;

  Future initCommon() async {
    packageInfo = await PackageInfo.fromPlatform();
    _initEasyLoading();
    await SpUtil.getInstance();
    userHelper.initToken();
    await deviceUtil.init();
    registerWxApi(appId: "wxe02b86dc09511f64", universalLink: "https://test.chuancuibaoku.com").then((value) {
      lLog("registerWxApi result is: $value");
    });
  }

  _initEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.cerulean
      ..backgroundColor = Colors.white.withOpacity(0.9)
      ..indicatorColor = AppColors.cerulean
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}

final common = _Common();
final EventBus eventBus = EventBus();

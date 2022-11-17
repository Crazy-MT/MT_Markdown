import 'dart:io';

import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform_device_id/platform_device_id.dart';

class DeviceUtil {
  DeviceUtil._();

  PackageInfo? packageInfo;
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;
  String? _deviceId = "";

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo? _iosDeviceInfo;
  AndroidDeviceInfo? _androidDeviceInfo;

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo?.appName;
    packageName = packageInfo?.packageName;
    version = packageInfo?.version;
    buildNumber = packageInfo?.buildNumber;

    if (PlatformUtils.isAndroid) {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
    } else if (PlatformUtils.isIOS) {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
    }

    if (PlatformUtils.isWeb) {
      try {
        _deviceId = await PlatformDeviceId.getDeviceId;
      } on PlatformException {
        _deviceId = 'Failed to get deviceId.';
      }
    }
  }

  bool isMobileWeb() {
    if (!PlatformUtils.isWeb) {
      return false;
    }
    String deviceId = _deviceId!;
    if (deviceId.contains('iPhone') ||
        deviceId.contains('Android') ||
        deviceId.contains('android')) {
      return true;
    } else {
      return false;
    }
  }

  bool isPCWeb() {
    if (!PlatformUtils.isWeb) {
      return false;
    }
    String deviceId = _deviceId!;
    if (deviceId.contains('iPhone') ||
        deviceId.contains('Android') ||
        deviceId.contains('android')) {
      return false;
    } else {
      return true;
    }
  }

  String getUniqueID() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo?.androidId ?? "-1";
    } else if (Platform.isIOS) {
      return _iosDeviceInfo?.identifierForVendor ?? "-1";
    }
    return "-1";
  }

  String getVersionCode() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo?.version.codename ?? "-1";
    } else if (Platform.isIOS) {
      return _iosDeviceInfo?.systemVersion ?? "-1";
    }
    return "-1";
  }
}

DeviceUtil deviceUtil = DeviceUtil._();

import 'dart:io';

import 'package:device_info/device_info.dart';

class DeviceUtil {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo? _iosDeviceInfo;
  AndroidDeviceInfo? _androidDeviceInfo;
  DeviceUtil._();

  init() async {
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
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

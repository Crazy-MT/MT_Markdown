import 'dart:io';

import 'package:code_zero/utils/log_utils.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtil {
  DeviceUtil._();
  PackageInfo? packageInfo;
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo?.appName;
    packageName = packageInfo?.packageName;
    version = packageInfo?.version;
    buildNumber = packageInfo?.buildNumber;
  }

/*  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  IosDeviceInfo? _iosDeviceInfo;
  AndroidDeviceInfo? _androidDeviceInfo;



  DeviceUtil._();

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo?.appName;
    packageName = packageInfo?.packageName;
    version = packageInfo?.version;
    buildNumber = packageInfo?.buildNumber;
    if (Platform.isAndroid) {
      _androidDeviceInfo = await _deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      _iosDeviceInfo = await _deviceInfo.iosInfo;
    }

    /*List<int> curV = (deviceUtil.version ?? "1.0.0").split(".").map((e) {
      lLog('MTMTMT HomeController.onInit ${e} ');
      return int.parse(e);
    }).toList();
    lLog('MTMTMT HomeController.onInit ${curV[1]} ');*/
  }

  String getUniqueID() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo?.androidId ?? "-1";
    } else if (Platform.isIOS) {
      return _iosDeviceInfo?.identifierForVendor ?? "-1";
    }
    return "-1";
  }*/

/*  String getVersionCode() {
    if (Platform.isAndroid) {
      return _androidDeviceInfo?.version.codename ?? "-1";
    } else if (Platform.isIOS) {
      return _iosDeviceInfo?.systemVersion ?? "-1";
    }
    return "-1";
  }*/
}

DeviceUtil deviceUtil = DeviceUtil._();

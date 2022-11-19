// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class Apis {
  static const String PREFIX = "/user";

  // static const String GET_INFO = NetConstant.HOST + PREFIX + "/get_info";
  static const String LOGIN = NetConstant.HOST + PREFIX + "/login";
  static const String BIND = NetConstant.HOST + PREFIX + "/bind-from-user";
  static const String PHONE_LOGIN = NetConstant.HOST + PREFIX + "/phone-login";
  static const String SMS = NetConstant.HOST + "/sms" + "/send-user-login-code";
  static const String IDENTITIY_CHECK =
      NetConstant.HOST + "/open-api/identity-check";
  static const String LOG_OUT = NetConstant.HOST + "/user/logout";

  static const String UPLOAD = NetConstant.HOST + "/file/uploads";
  static const String UPDATE_INFO = NetConstant.HOST + PREFIX + "/update-info";

  static const String UPDATE_PASSWORD =
      NetConstant.HOST + PREFIX + "/update-password";

  static const String UPDATE_SIGNATURE =
      NetConstant.HOST + PREFIX + "/update-signature";

  static const String SYSTEM_SETTING = NetConstant.HOST + "/system-setting/get";

  static const String APP_VERSION = NetConstant.HOST + "/app-version/get-latest-version";
  static const String RED_ENVELOPE = NetConstant.HOST + "/red-envelope/info";

}

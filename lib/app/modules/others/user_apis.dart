// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class UserApis {
  static const String PREFIX = "/user";

  static const String GET_INFO = NetConstant.HOST + PREFIX + "/get_info";
  static const String LOGIN = NetConstant.HOST + PREFIX + "/login";
  static const String GUEST_LOGIN = NetConstant.HOST + PREFIX + "/guest_login";
  static const String REGISTER = NetConstant.HOST + PREFIX + "/register";
}
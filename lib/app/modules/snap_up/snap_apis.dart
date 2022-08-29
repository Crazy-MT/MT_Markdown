// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class SnapApis {
  static const String PREFIX = "/session";

  static const String LIST = NetConstant.HOST + PREFIX + "/list";

  static const String COMMODITY = NetConstant.HOST + "/commodity/list-buying-commodity";

  static const String SNAP_CREATE = NetConstant.HOST + "/buying-transaction/create";
}

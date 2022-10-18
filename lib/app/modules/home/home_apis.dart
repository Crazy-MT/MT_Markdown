// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class HomeApis {
  static const String COMMODITY = NetConstant.HOST + '/commodity/list-self-commodity';
  static const String GOOD_DETAIL = NetConstant.HOST + '/commodity/get-detail';
  static const String ORDER_DETAIL = NetConstant.HOST + '/buying-transaction/get-detail';
}

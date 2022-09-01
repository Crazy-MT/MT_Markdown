import 'package:code_zero/network/net_constant.dart';

class IncomeApis {
  static const String PREFIX = "/income";

  static const String STATISTICS= NetConstant.HOST + PREFIX + "/user-statistics";

  static const String INCOME_LIST= NetConstant.HOST + PREFIX + "/list";
}

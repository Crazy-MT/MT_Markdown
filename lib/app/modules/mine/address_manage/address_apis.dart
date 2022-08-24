import 'package:code_zero/network/net_constant.dart';

class AddressApis {
  static const String PREFIX = "/address";

  static const String CREATE = NetConstant.HOST + PREFIX + "/create";
  static const String DELETE = NetConstant.HOST + PREFIX + "/delete";
  static const String GET_ADDRESS_LIST = NetConstant.HOST + PREFIX + "/list";
}

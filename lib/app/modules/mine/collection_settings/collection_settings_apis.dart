import 'package:code_zero/network/net_constant.dart';

class CollectionSettingsApis {
  static const String PREFIX = "/payment-method";

  // 用户银行卡
  static const String USERBANK = NetConstant.HOST + PREFIX + "/get-user-bank";

  // 用户微信
  static const String USERWECHAT = NetConstant.HOST + PREFIX + "/get-user-wechat";

  // 用户添加银行卡
  static const String USEADDBANK = NetConstant.HOST + PREFIX + "/create-bank";

  // 用户添加微信
  static const String USEADDWECHAT = NetConstant.HOST + PREFIX + "/create-wechat";

  // 用户编辑
  static const String USEPAYMENTUPDATE = NetConstant.HOST + PREFIX + "/update";
}

import 'package:code_zero/network/net_constant.dart';

class CollectionApis {
  static const String PREFIX = "/payment-method";

  // 用户银行卡
  static const String USERBANK = NetConstant.HOST + PREFIX + "/get-user-bank";

  // 系统银行卡
  static const String SYSTEM_BANK = NetConstant.HOST + "/system-setting/get-bank-info";

  // 用户微信
  static const String USERWECHAT = NetConstant.HOST + PREFIX + "/get-user-wechat";

  // 用户支付宝
  static const String USER_ALIPAY = NetConstant.HOST + PREFIX + "/get-user-alipay";
}

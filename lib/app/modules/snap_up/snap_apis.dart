// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class SnapApis {
  static const String PREFIX = "/session";

  static const String LIST = NetConstant.HOST + PREFIX + "/list";

  static const String COMMODITY = NetConstant.HOST + "/commodity/list-buying-commodity";

  static const String SNAP_CREATE = NetConstant.HOST + "/buying-transaction/create";
  static const String CREATE = NetConstant.HOST + "/pay-transaction/create-self-commodity";
  static const String ORDER_LIST = NetConstant.HOST + "/buying-transaction/list";
  static const String SELF_ORDER_LIST = NetConstant.HOST + "/pay-transaction/list";
  static const String CLOSE_ORDER_LIST = NetConstant.HOST + "/pay-transaction/close";
  static const String SHOUHUO = NetConstant.HOST + "/pay-transaction/receipt";
  static const String CANCEL_ORDER = NetConstant.HOST + "/buying-transaction/cancel";
  static const String CONFIRM_ORDER = NetConstant.HOST + "/buying-transaction/confirm-payment";
  static const String CONFIRM_RECEIPT_ORDER = NetConstant.HOST + "/buying-transaction/confirm-receipt";
  static const String UPDATE_TRADE_URL_ORDER = NetConstant.HOST + "/buying-transaction/update-trade-url";

  static const String PICK_UP_COMMODITY = NetConstant.HOST + "/buying-transaction/pick-up-commodity";
  static const String GET_SHELF_COMMODITY_INFO = NetConstant.HOST + "/buying-transaction/get-shelf-commodity-info";
  static const String CREATE_CHARGE = NetConstant.HOST + "/pay-transaction/create-charge";
  static const String PAY = NetConstant.HOST + "/wechat/trade-notify-mock";
  static const String PAY_STATUS = NetConstant.HOST + "/pay-transaction/get";
  static const String SET_PAY_STATUS = NetConstant.HOST + "/pay-transaction/update-trade-state";

  static const String CREATE_APPEAL = NetConstant.HOST + "/appeal/create";

}

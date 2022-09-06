// ignore_for_file: constant_identifier_names

import 'package:code_zero/network/net_constant.dart';

class ShoppingCartApis {
  static const String PREFIX = "/shopping-cart";

  static const String GET_SHOPPING_CART_LIST = NetConstant.HOST + PREFIX + "/get-user-shopping-cart";
  static const String ADD_TO_SHOPPING_CART = NetConstant.HOST + PREFIX + "/add-to-shopping-cart";
  static const String UPDATE_SHOPPING_CART_NUM = NetConstant.HOST + PREFIX + "/update-commodity-count";
  static const String DELETE_COMMODITY = NetConstant.HOST + PREFIX + "/delete-commodity";
}

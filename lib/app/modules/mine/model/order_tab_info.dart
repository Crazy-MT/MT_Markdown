import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'order_list_model.dart';

class OrderTabInfo {
  final Tab tab;
  final int tradeState;
  final RefreshController refreshController;
  int currentPage;
  RxList<OrderItem> orderList;

  OrderTabInfo(
    this.tab,
    this.tradeState,
    this.refreshController,
    this.currentPage,
    this.orderList,
  );
}

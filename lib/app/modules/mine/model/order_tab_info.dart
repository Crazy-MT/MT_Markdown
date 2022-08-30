import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'order_list_model.dart';

class OrderTabInfo {
  final Tab tab;
  //交易状态，0->待付款、
  // 1->待收款、
  // 2->已付款、
  // 3->待上架、
  // 4->已上架、
  // 5->待发货、
  // 6->待收货、
  // 7->已收货、
  // 8->已取消、
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

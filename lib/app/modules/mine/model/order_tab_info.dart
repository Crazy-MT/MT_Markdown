import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'order_list_model.dart';

class OrderTabInfo {
  final Tab tab;
  //交易状态，0->待付款、1->已付款、2->待上架、3->已上架、4->待收款、5->待确认、6->已完成、
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

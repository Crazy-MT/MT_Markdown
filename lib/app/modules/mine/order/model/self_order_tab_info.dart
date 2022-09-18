import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SelfOrderTabInfo {
  final Tab tab;
  final int tradeState;
  final RefreshController refreshController;
  int currentPage;
  RxList<SelfOrderItems> orderList;

  SelfOrderTabInfo(
    this.tab,
    this.tradeState,
    this.refreshController,
    this.currentPage,
    this.orderList,
  );
}

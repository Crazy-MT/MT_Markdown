import 'order_send_sell_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSendSellPage extends GetView<OrderSendSellController> {
  const OrderSendSellPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OrderSendSell'),
        centerTitle: true,
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Center(
              child: Text("This page is :${controller.pageName}"),
            );
          },
        ),
      ),
    );
  }
}

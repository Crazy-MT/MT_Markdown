import 'shopping_cart_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShoppingCart'),
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

import 'package:get/get.dart';

import 'balance_rule_controller.dart';

class BalanceRuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BalanceRuleController>(
      () => BalanceRuleController(),
    );
  }
}

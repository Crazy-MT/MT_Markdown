import 'package:get/get.dart';

import 'red_envelope_withdrawal_controller.dart';

class RedEnvelopeWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedEnvelopeWithdrawalController>(
      () => RedEnvelopeWithdrawalController(),
    );
  }
}

import 'package:get/get.dart';

import 'red_envelope_reward_controller.dart';

class RedEnvelopeRewardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RedEnvelopeRewardController>(
      () => RedEnvelopeRewardController(),
    );
  }
}

import 'package:get/get.dart';

import 'complaint_feedback_controller.dart';

class ComplaintFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintFeedbackController>(
      () => ComplaintFeedbackController(),
    );
  }
}

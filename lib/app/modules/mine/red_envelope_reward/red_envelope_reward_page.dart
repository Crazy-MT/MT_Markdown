import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';

import 'red_envelope_reward_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RedEnvelopeRewardPage extends GetView<RedEnvelopeRewardController> {
  const RedEnvelopeRewardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_gray,
      appBar: CommonAppBar(
        titleText: "红包奖励",
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

import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'balance_rule_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BalanceRulePage extends GetView<BalanceRuleController> {
  const BalanceRulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: CommonAppBar(
          titleText: '提现说明',
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF14181F),
            onPressed: () {
              Get.back();
            },
          )),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return Obx(() => CustomScrollView(
              slivers: [
                _buildContent(),
              ],
            ));
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.w),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (content, index) {
            return Text('${index+1}、${controller.ruleModel.value?.roles?[index]}', style: TextStyle(color: Color(0xff434446), fontSize:15.sp
            ),);
          },
          childCount: controller.ruleModel.value?.roles?.length ?? 0,
        ),
      ),
    );
  }

}

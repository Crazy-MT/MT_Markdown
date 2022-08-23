import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'local_html_controller.dart';

class LocalHtmlPage extends GetView<LocalHtmlController> {
  const LocalHtmlPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        child: Obx(
          () => Text(
            controller.pageTitle.value,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.text_dark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF14181F),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
        () => FTStatusPage(
          type: controller.pageStatus.value,
          errorMsg: controller.errorMsg.value,
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                if (controller.topWidget != null)
                  SliverToBoxAdapter(
                    child: controller.topWidget!,
                  ),
                _buildHtmlContent(),
                if (controller.bottomWidget != null)
                  SliverToBoxAdapter(
                    child: controller.bottomWidget!,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  _buildHtmlContent() {
    return SliverToBoxAdapter(
      child: Obx(
        () => Html(data: controller.htmlContent.value),
      ),
    );
  }
}

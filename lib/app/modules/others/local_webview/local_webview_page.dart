import 'dart:io';

import 'package:code_zero/app/modules/others/local_html/local_html_controller.dart';
import 'package:code_zero/app/modules/others/local_webview/local_webview_controller.dart';
import 'package:code_zero/app/modules/others/local_webview/web_view.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';


class LocalWebViewPage extends GetView<LocalWebViewController> {
  const LocalWebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WebViewExample(str: controller.htmlContent.value,);
    });
  }

}

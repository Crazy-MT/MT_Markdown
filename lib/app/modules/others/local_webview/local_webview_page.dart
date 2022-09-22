import 'dart:io';

import 'package:code_zero/app/modules/others/local_html/flutter_html_table.dart';
import 'package:code_zero/app/modules/others/local_html/web_view.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/common_app_bar.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
            () =>
                Visibility(
                  visible: controller.htmlContent.isNotEmpty,
                  child: WebView(
                    initialUrl: 'https://flutter.cn',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      controller.webController.complete(webViewController);
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('https://www.youtube.com/')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.prevent;
                      }
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                    },
                    gestureNavigationEnabled: true,
                    backgroundColor: const Color(0x00000000),
                  ),
                ),
      ),
    );
  }


}

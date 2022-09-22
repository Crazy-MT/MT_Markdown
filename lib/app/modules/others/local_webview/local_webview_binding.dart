import 'package:code_zero/app/modules/others/local_webview/local_webview_controller.dart';
import 'package:get/get.dart';


class LocalWebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalWebViewController>(
      () => LocalWebViewController(),
    );
  }
}

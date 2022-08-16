import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class MessageController extends GetxController {
  final pageName = 'Message'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  List<String> messageList = ['平台消息', '专属私信'].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    initMessageList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  initMessageList() {}

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

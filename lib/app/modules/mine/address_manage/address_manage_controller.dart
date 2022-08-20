import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class AddressManageController extends GetxController {
  final pageName = 'AddressManage'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<String> addressList = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    addressList = ['默认', ''].obs;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

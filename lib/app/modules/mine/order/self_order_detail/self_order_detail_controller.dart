import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class SelfOrderDetailController extends GetxController {
  final pageName = 'SelfOrderDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<SelfOrderItems?> item = Rx<SelfOrderItems?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    item.value = Get.arguments?['item'];
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

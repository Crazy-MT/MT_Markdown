import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class OrderDetailController extends GetxController {
  final pageName = 'OrderDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<OrderItem?> item = Rx<OrderItem?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    item.value = Get.arguments?['item'];

    getOrderDetail();
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> getOrderDetail() async {
    await LRequest.instance.request<
        OrderItem>(
        url: HomeApis.ORDER_DETAIL,
        t: OrderItem(),
        queryParameters: {
          'id': item.value?.id
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取订单详情失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取订单详情失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        isShowLoading: true,
        onSuccess: (result) {
          var model = result.value;
          if(model == null) {
            return;
          }
          item.value = result.value!;
        });
  }
}

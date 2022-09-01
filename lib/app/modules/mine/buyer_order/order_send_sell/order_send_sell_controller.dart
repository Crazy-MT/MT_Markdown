import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/shelf_commodity_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class OrderSendSellController extends GetxController {
  final pageName = 'OrderSendSell'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  getShelfCommodityInfo(id) async {
    ResultData<ShelfCommodityModel>? _result = await LRequest.instance.request<
            ShelfCommodityModel>(
        url: SnapApis.GET_SHELF_COMMODITY_INFO,
        data: {
          "id": id,
        },
        t: ShelfCommodityModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取寄卖信息失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取寄卖信息失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          Utils.showToastMsg("获取寄卖信息成功");
        });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

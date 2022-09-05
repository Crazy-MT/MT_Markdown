import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/mine_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:get/get.dart';

import '../../../../common/user_helper.dart';
import '../../../../network/base_model.dart';
import '../../../../network/l_request.dart';
import '../../../../utils/log_utils.dart';
import '../../../../utils/utils.dart';
import '../../mine/address_manage/address_apis.dart';
import '../../mine/address_manage/model/address_list_model.dart';
import '../../snap_up/model/session_model.dart';
import '../../snap_up/snap_apis.dart';
import '../../snap_up/snap_detail/model/commodity.dart';
import '../../snap_up/widget/success_dialog.dart';

class SubmitOrderController extends GetxController {
  final pageName = 'SubmitOrder'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  CommodityItem goods = CommodityItem();
  RxList<AddressItem> addressList = RxList<AddressItem>();

  @override
  void onInit() {
    super.onInit();
    goods = Get.arguments?["goods"] ?? CommodityItem();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getAddressList();
  }

  getAddressList() async {
    ResultData<AddressListModel>? _result = await LRequest.instance.request<AddressListModel>(
      url: AddressApis.GET_ADDRESS_LIST,
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      t: AddressListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("地址信息获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      addressList.value = _result.value!.items?.where((element) => element.isDefault == 1).toList() ?? [];

      return;
    }
  }

  doSnapUpCreate() async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.SNAP_CREATE,
        t: DataModel(),
        data: {
          "addressId": addressList.first.id,
          "commodityId": goods.id,
          "userId": userHelper.userInfo.value?.id,
        },
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("创建抢购订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("创建抢购订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          showSuccessDialog(onConfirm: () {
            Get.find<MineController>().showBadge(true);
            Get.offAllNamed(RoutesID.MAIN_TAB_PAGE, arguments: {'tabIndex': 3});
          });
          var model = result.value;
          if (model == null) {
            return;
          }
        });
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

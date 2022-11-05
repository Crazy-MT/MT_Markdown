import 'package:code_zero/app/modules/mine/address_manage/model/address_list_model.dart';
import 'package:code_zero/app/modules/mine/address_manage/model/edit_address_model.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';

import 'address_apis.dart';

class AddressManageController extends GetxController {
  final pageName = 'AddressManage'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<AddressItem> addressList = RxList<AddressItem>();

  @override
  void onInit() {
    super.onInit();
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
      addressList.value = _result.value!.items ?? [];

      if(addressList.length == 1 && addressList.first.isDefault == 0) {
        saveEdit(addressList.first);
      }
      return;
    }
  }

  /// 当只有一条地址，并且非默认地址的时候，将该地址修改成默认地址
  saveEdit(AddressItem addressItem) async {
    ResultData<EditAddressModel>? _result = await LRequest.instance.request<EditAddressModel>(
      url: AddressApis.UPDATE,
      t: EditAddressModel(),
      data: {
        "consignee": addressItem.consignee,
        "phone": addressItem.phone,
        "region": addressItem.region,
        "address": addressItem.address,
        "isDefault": 1,
        "id": addressItem.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("更新失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("更新失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
      onSuccess: (_) {
        getAddressList();
      }
    );
    /*if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      Get.back(result: true);
      return;
    }*/
  }


  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

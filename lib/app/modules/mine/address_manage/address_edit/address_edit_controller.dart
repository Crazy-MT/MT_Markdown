import 'package:code_zero/app/modules/mine/address_manage/address_apis.dart';
import 'package:code_zero/app/modules/mine/address_manage/model/address_list_model.dart';
import 'package:code_zero/app/modules/mine/address_manage/model/create_address_model.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/convert_interface.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/edit_address_model.dart';

enum AddressType {
  add,
  edit,
}

class AddressEditController extends GetxController {
  final pageName = 'AddressEdit'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  final isDefault = false.obs;

  TextEditingController _consignee = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _address = TextEditingController();

  AddressItem? addressItem;

  AddressType type = AddressType.add;
  RxList<_MenuItem> menuList = RxList<_MenuItem>();
  bool noAddress = false;

  @override
  void onInit() {
    super.onInit();
    initData();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    type = (Get.arguments['type'] as int) == 0 ? AddressType.add : AddressType.edit;
    noAddress = Get.arguments?['noAddress'] ?? false;
    isDefault.value = noAddress;
    if (Get.arguments['item'] is AddressItem) {
      addressItem = Get.arguments['item'];
      _consignee.text = addressItem?.consignee ?? "";
      _phone.text = addressItem?.phone ?? "";
      _region.text = addressItem?.region ?? "";
      _address.text = addressItem?.address ?? "";
      isDefault.value = addressItem?.isDefault == 1;
    }
  }

  initMenuList() {
    menuList.add(_MenuItem(
      title: "收货人",
      hintTitle: "请填写收货人姓名",
      editingController: _consignee,
    ));
    menuList.add(_MenuItem(
      title: "联系电话",
      hintTitle: "收件人号码",
      editingController: _phone,
    ));
    menuList.add(_MenuItem(
      title: "所在地区",
      hintTitle: "点击选择地区快速填写地址",
      showLocation: true,
      editingController: _region,
    ));
    menuList.add(_MenuItem(
      title: "详细地址",
      hintTitle: "请输入地址",
      editingController: _address,
    ));
  }

  createAddress() async {
    ResultData<CreateAddressModel>? _result = await LRequest.instance.request<CreateAddressModel>(
      url: AddressApis.CREATE,
      t: CreateAddressModel(),
      data: {
        "consignee": _consignee.text,
        "phone": _phone.text,
        "region": _region.text,
        "address": _address.text,
        "isDefault": noAddress ? 1 : (isDefault.value ? 1 : 0),
        "userId": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("创建失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("创建失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      userHelper.userInfo.value?.hasAddress = 1;
      userHelper.updateSp(userHelper.userInfo.value);
      if(Get.arguments?["from"] == RoutesID.LOGIN_PAGE) {
        Get.offAllNamed(RoutesID.MAIN_TAB_PAGE, arguments: {'tabIndex': 3});
      } if(Get.arguments?["from"] == RoutesID.HOME_PAGE) {
        Get.offAllNamed(RoutesID.MAIN_TAB_PAGE, arguments: {'tabIndex': 0});
      } else {
        Get.back(result: true);
      }

      return;
    }
  }

  deleteAddress() {
    if(Get.arguments?['size'] == 1) {
       Utils.showToastMsg('用户您好，您目前只有一个收货地址，不能删除！');
       return;
    }
    showConfirmDialog(
      onConfirm: () async {
        ResultData<ConvertInterface>? _result = await LRequest.instance.request<CreateAddressModel>(
          url: AddressApis.DELETE,
          queryParameters: {
            "id": addressItem?.id,
          },
          requestType: RequestType.GET,
          errorBack: (errorCode, errorMsg, expMsg) {
            Utils.showToastMsg("删除失败：${errorCode == -1 ? expMsg : errorMsg}");
            errorLog("删除失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          },
        );
        Get.back(result: true);
      },
      content: "确认删除该地址吗",
    );
  }

  saveEdit() async {
    ResultData<EditAddressModel>? _result = await LRequest.instance.request<EditAddressModel>(
      url: AddressApis.UPDATE,
      t: EditAddressModel(),
      data: {
        "consignee": _consignee.text,
        "phone": _phone.text,
        "region": _region.text,
        "address": _address.text,
        "isDefault": isDefault.value ? 1 : 0,
        "id": addressItem?.id,
      },
      requestType: RequestType.POST,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("更新失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("更新失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      Get.back(result: true);
      return;
    }
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _MenuItem {
  final String title;
  final String hintTitle;
  final bool showLocation;
  final TextEditingController editingController;

  _MenuItem({
    required this.title,
    required this.hintTitle,
    required this.editingController,
    this.showLocation = false,
  });
}

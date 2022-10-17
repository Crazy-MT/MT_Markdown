import 'dart:async';

import 'package:code_zero/app/modules/mine/collection/collection_apis.dart';
import 'package:code_zero/app/modules/mine/collection/model/user_bank_card_model.dart';
import 'package:code_zero/app/modules/mine/collection/model/user_wechat_model.dart';
import 'package:code_zero/app/modules/others/user_apis.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/model/user_model.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CollectionController extends GetxController with GetSingleTickerProviderStateMixin {
  final pageName = 'CollectionSettings'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  List<String> tabList = ['银行卡', '微信'];
  TabController? tabController;

  // 银行卡数据
  Rx<UserBankCardModel?> bankcardInfo = Rx<UserBankCardModel?>(null);
  // 银行卡姓名
  TextEditingController bankNameController = new TextEditingController();
  // 银行卡手机号
  TextEditingController bankPhoneController = new TextEditingController();
  // 银行卡卡号
  TextEditingController bankCardNumController = new TextEditingController();
  // 银行卡所属银行
  TextEditingController bankBelongController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  // 微信数据
  Rx<UserWechatModel?> wechatInfo = Rx<UserWechatModel?>(null);
  // 微信账号
  TextEditingController wechatAccountController = new TextEditingController();
  // 微信收款姓名
  TextEditingController wechatNameController = new TextEditingController();
  // 微信收款二维码
  RxString wechatQrImg = "".obs;

  var hasNoBankCard = true;
  var hasNoWeiXin = true;

  final sendBankCodeCountDown = 0.obs;
  final sendWechatCodeCountDown = 0.obs;

  Timer? bankTimer;
  Timer? wechatTimer;

  @override
  void onInit() {
    super.onInit();
    initData();
    fetchBankCardData();

    /// 收款方不是管理员，才请求微信收款数据
    if(Get.arguments["fromUserIsAdmin"] != 1) {
      fetchWeChatData();
    }
    priceController.text = "￥" + Get.arguments['price'];
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // lLog("点击了下标为${tabController?.index}的tab");
      }
    });
  }

  void goBack() {
    Get.back();
  }

  // 获取用户银行卡
  Future<void> fetchBankCardData() async {
    ResultData<UserBankCardModel>? _result = await LRequest.instance.request<UserBankCardModel>(
      // 订单卖方是管理员，就显示系统设置的银行收款信息 https://chuancui.yuque.com/staff-tcr7lf/yra0pk/in371v
      // 订单卖方是会员，就显示会员设置的收款信息
      url: Get.arguments["fromUserIsAdmin"] == 1 ? CollectionApis.SYSTEM_BANK : CollectionApis.USERBANK,
      t: UserBankCardModel(),
      queryParameters: {
        "user-id": Get.arguments["fromUserId"],
        // "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取用户银行卡失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    bankcardInfo.value = _result?.value;
    bankNameController.text = bankcardInfo.value?.name ?? "";
    bankPhoneController.text = bankcardInfo.value?.phone??"";
    bankCardNumController.text = bankcardInfo.value?.bankCardNum??"";
    bankBelongController.text = bankcardInfo.value?.bank??"";
    hasNoBankCard = false;
  }

  // 获取用户微信
  Future<void> fetchWeChatData() async {
    ResultData<UserWechatModel>? _result = await LRequest.instance.request<UserWechatModel>(
      url: CollectionApis.USERWECHAT,
      t: UserWechatModel(),
      queryParameters: {
        "user-id": Get.arguments["fromUserId"],
        // "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取用户微信方式失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
    );
    if (_result?.value == null) {
      return;
    }
    wechatInfo.value = _result?.value;
    wechatAccountController.text = wechatInfo.value?.wechatAccount??"";
    wechatNameController.text = wechatInfo.value?.name??"";

    hasNoWeiXin = false;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

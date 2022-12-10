import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/collection/collection_apis.dart';
import 'package:code_zero/app/modules/mine/collection_settings/collection_settings_apis.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_bank_card_model.dart';
import 'package:code_zero/app/modules/mine/collection_settings/model/user_wechat_model.dart';
import 'package:code_zero/app/modules/mine/wallet/drawing/drawing_apis.dart';
import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/app/modules/mine/wallet/wallet_apis.dart';
import 'package:code_zero/app/modules/mine/wallet/wallet_controller.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class DrawingController extends GetxController with GetSingleTickerProviderStateMixin{
  final pageName = 'Drawing'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  // final method = "".obs;
  // int chooseMethod = 0;
  TextEditingController balanceController = new TextEditingController();
  TextEditingController balanceRedController = new TextEditingController();
  TabController? tabController;
  List<String> tabList = ['提取余额', '提取红包奖励'];
  RxInt currentIndex = 0.obs;
  Rx<WalletModel?> model = Rx<WalletModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    getStatistics();
    pageStatus.value = FTStatusPageType.success;
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        currentIndex.value = tabController?.index ?? 0;
      }
    });
    // fetchBankCardData();
  }

/*
  Future<void> fetchBankCardData() async {
    ResultData<UserBankCardModel>? _result =
    await LRequest.instance.request<UserBankCardModel>(
      url: CollectionSettingsApis.USERBANK,
      t: UserBankCardModel(),
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        lLog(errorMsg);
        fetchWeChatData();
      },
      onSuccess: (rst) {
        if(rst.value != null && rst.value?.id != null) {
          method.value = "银行卡";
          chooseMethod = 0;
        } else {
          fetchWeChatData();
        }
      }
    );
    if (_result?.value == null) {
      return;
    }
  }
*/

/*
  Future<void> fetchWeChatData() async {
    ResultData<UserWechatModel>? _result = await LRequest.instance.request<UserWechatModel>(
      url: CollectionApis.USERWECHAT,
      t: UserWechatModel(),
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
        // "user-id": userHelper.userInfo.value?.id,
      },
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取用户微信方式失败：${errorCode == -1 ? expMsg : errorMsg}");
        lLog(errorMsg);
      },
      onSuccess: (rest) {
        if(rest.value != null && rest.value?.id != null) {
          method.value = "微信";
          chooseMethod = 1;
        }
      }
    );
    if (_result?.value == null) {
      return;
    }
  }
*/



  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

/*
  Future<void> choose() async {
    chooseMethod = await Get.toNamed(RoutesID.COLLECTION_SETTINGS_PAGE, arguments: {'title': '选择收款方式'});
    if(chooseMethod == 0) {
      method.value = "银行卡";
    }

    if(chooseMethod == 1) {
      method.value = "微信";
    }

    if(chooseMethod == 2) {
      method.value = "支付宝";
    }
  }
*/

  Future<void> getStatistics() async {
    ResultData<WalletModel>? _result = await LRequest.instance.request<WalletModel>(
        url: WalletApis.ASSETS,
        queryParameters: {
          "user-id": userHelper.userInfo.value?.id
        },
        t: WalletModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取资产统计失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取资产统计失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          model.value = rest.value;
        }
    );
  }


  Future<void> createBalance() async {
    // if(method.value.isEmpty) {
    //   Utils.showToastMsg('请选择提现方式');
    //   return;
    // }
    if(model.value?.balance == 0) {
      Utils.showToastMsg('可提现金额为 0');
      return;
    }
    if(balanceController.text.isEmpty) {
      Utils.showToastMsg('请输入提现金额');
      return;
    }
    ResultData<DataModel>? _result = await LRequest.instance.request<
        DataModel>(
        url: DrawingApis.CREATE,
        data: {
          'balance' : balanceController.text,
          // 'method' : chooseMethod,
          'userId' : userHelper.userInfo.value?.id,
          'balanceFrom':0
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("提现失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("提现失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          Utils.showToastMsg("提现成功");
          Get.find<WalletController>().getStatistics();
          Get.back();
        }
    );
  }

  Future<void> createRedBalance() async {

    if(model.value?.completedRedEnvelopeAmount == 0) {
      Utils.showToastMsg('可提现金额为 0');
      return;
    }
    if(balanceRedController.text.isEmpty) {
      Utils.showToastMsg('请输入提现金额');
      return;
    }
    ResultData<DataModel>? _result = await LRequest.instance.request<
        DataModel>(
        url: DrawingApis.CREATE,
        data: {
          'balance' : balanceRedController.text,
          'userId' : userHelper.userInfo.value?.id,
          'balanceFrom':1
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("提现失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("提现失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          Utils.showToastMsg("提现成功");
          Get.find<WalletController>().getStatistics();
          Get.back();
        }
    );
  }

}

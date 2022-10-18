import 'dart:async';
import 'dart:math';

import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/charge_model.dart';
import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/shelf_commodity_model.dart';
import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/network/upload_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class OrderSendSellController extends GetxController {
  final pageName = 'OrderSendSell'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<ShelfCommodityModel?> model = Rx<ShelfCommodityModel?>(null);
  Rx<OrderItem?> item = Rx<OrderItem?>(null);
  Rx<ChargeModel?> chargeModel = Rx<ChargeModel?>(null);
  final TextEditingController editingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initData();

  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    item.value = Get.arguments['item'];
    getShelfCommodityInfo(item.value?.id);
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
          Utils.showToastMsg("获取寄卖信息失败：${errorCode == -1 ? "" : errorMsg}");
          errorLog("获取寄卖信息失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          model.value = rest.value;
        });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<bool> createCharge() async {
    if(editingController.text.isEmpty) {
      editingController.text = model.value?.recommendPrice ?? "";
    }

    try {
      if(num.parse(editingController.text) > num.parse(model.value?.maxPrice ?? "0")) {
        Utils.showToastMsg('上架金额不得超过最高上浮价格');
        return Future.value(false);
      }
    } catch(e) {}

    bool isSuccess = false;
    ResultData<ChargeModel>? _result = await LRequest.instance.request<
        ChargeModel>(
        url: SnapApis.CREATE_CHARGE,
        data: {
          "buyingTransactionId": item.value?.id,
          "commodityId": model.value?.commodityId,
          "userId": userHelper.userInfo.value?.id,
          "newPrice": editingController.text,
        },
        t: ChargeModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("提交订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("提交订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          isSuccess =  false;
        },
        onSuccess: (rest) {
          lLog('MTMTMT OrderSendSellController.createChargecreateSuccess');
          chargeModel.value = rest.value;
          isSuccess = true;
          // Utils.showToastMsg("获取订单成功");
        });
    return isSuccess;
  }

  /// 废弃方法
  Future<bool> pay(isPaySuccess) async {
    bool isSuccess = false;
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.PAY,
        data: {
          "outTradeNo": chargeModel.value?.outTradeNo,
          "tradeState": isPaySuccess ? "SUCCESS" : "PAYERROR",
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("支付失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("支付失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          isSuccess = false;
        },
        onStringSuccess: (rest) {
          lLog('MTMTMT OrderSendSellController.pay ${rest}');
          Utils.showToastMsg(isPaySuccess ? "支付成功" : "支付失败");
          isSuccess = true;

          Navigator.pop(Get.context!);
          Get.offNamedUntil(RoutesID.SELLER_ORDER_PAGE, (route) => route.settings.name == RoutesID.MAIN_TAB_PAGE, arguments: {"index": 0});

        });
    return isSuccess;
  }

  void toWxPay() async {
    var isInstalled = await isWeChatInstalled;

    if (!isInstalled) {
      Utils.showToastMsg("请先安装微信");
    }
    payWithWeChat(
      appId: 'wxe02b86dc09511f64',
      partnerId: chargeModel.value?.partnerId ?? "",
      prepayId: chargeModel.value?.prepayId ?? "",
      packageValue: chargeModel.value?.package ?? "",
      nonceStr: chargeModel.value?.nonceStr ?? "",
      timeStamp: int.parse(chargeModel.value?.timeStamp ?? "0"),
      sign: chargeModel.value?.sign ?? "",
    );
    // 支付回调
    // 一般情况下打开微信支付闪退，errCode为 -1 ，多半是包名、签名和在微信开放平台创建时的配置不一致。
    // weChatResponseEventHandler 存在多次 listen 且无法关闭的情况。 解决办法，可以是放在单独的对象里，另一个办法就是只取第一个
    weChatResponseEventHandler.first.asStream().listen((data) {
      if(Get.currentRoute != RoutesID.ORDER_SEND_SELL_PAGE) {
        return ;
      }

      if (data.errCode == -2) {
        Utils.showToastMsg('支付失败，请重试');
      } else {
        checkPayResult(chargeModel.value?.id, () {
          Get.offNamedUntil(RoutesID.SELLER_ORDER_PAGE, (route) => route.settings.name == RoutesID.MAIN_TAB_PAGE, arguments: {"index": 0});
        }, () {
          Get.back();
        }, () {
          Get.back();
        });
      }
    }, );
  }
}

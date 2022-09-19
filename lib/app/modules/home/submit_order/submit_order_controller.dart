import 'dart:async';

import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/charge_model.dart';
import 'package:code_zero/app/modules/mine/mine_controller.dart';
import 'package:code_zero/app/modules/shopping_cart/model/shopping_cart_list_model.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluwx/fluwx.dart';
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
  RxList<AddressItem> addressList = RxList<AddressItem>();
  Rx<ChargeModel?> chargeModel = Rx<ChargeModel?>(null);
  RxList<ShoppingCartItem> goodsList = RxList<ShoppingCartItem>();
  var isFromSnap;

  @override
  void onInit() {
    super.onInit();
    goodsList = Get.arguments?["goods"] ?? [];
    isFromSnap = Get.arguments['isFromSnap'];
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getAddressList();
  }

  getAddressList() async {
    ResultData<AddressListModel>? _result =
        await LRequest.instance.request<AddressListModel>(
      url: AddressApis.GET_ADDRESS_LIST,
      queryParameters: {
        "user-id": userHelper.userInfo.value?.id,
      },
      t: AddressListModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? "" : errorMsg}");
        errorLog("地址信息获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      addressList.value = _result.value!.items
              ?.where((element) => element.isDefault == 1)
              .toList() ??
          [];

      return;
    }
  }

  doCreateOrder() {
    if (isFromSnap) {
      doSnapUpCreate();
    } else {
      doCreate();
    }
  }

  // 自营商品
  doCreate() async {
    /// "commodityList": [
    //     {
    //       "commodityId": 1,
    //       "commodityCount": 2
    //     }
    //   ],
    var commodityList = [];
    for (ShoppingCartItem item in goodsList) {
      commodityList.add({
        "commodityId": item.commodityId,
        "commodityCount": item.commodityCount
      });
    }
    ResultData<ChargeModel>? _result = await LRequest.instance.request<
            ChargeModel>(
        url: SnapApis.CREATE,
        t: ChargeModel(),
        data: {
          "addressId": addressList.first.id,
          "commodityList": commodityList,
          "userId": userHelper.userInfo.value?.id,
        },
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("创建抢购订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("创建抢购订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          chargeModel.value = result.value;
          toWxPay();
        });
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
    weChatResponseEventHandler.first.asStream().listen(
      (data) {
        if (Get.currentRoute != RoutesID.SUBMIT_ORDER_PAGE) {
          return;
        }
        lLog('MTMTMT SubmitOrderController.toWxPay ${data.errCode}');
        if (data.errCode == -2) {
          Utils.showToastMsg('支付失败，请重试');
        } else {
          checkPayResult();
        }
      },
    );
  }

  Future<void> checkPayResult() async {
    EasyLoading.show();

    int count = 0;
    Timer.periodic(Duration(seconds: 5), (timer) async {
      count += 1;
      int status = await checkPayStatus();
      lLog('MTMTMT SubmitOrderController.checkPayResult ${status}');

      if(count >= 15) {
        timer.cancel();
        showConfirmDialog(
          singleText: '确定',
          onSingle: () async {
            Get.back();
          },
          content: '查询支付结果超时，请稍后查询或联系工作人员',
        );
        return;
      }

      // 3 6 需要再查，1 成功，其它失败
      if(status == 3 || status == 6) {

      } else {
        timer.cancel();
        EasyLoading.dismiss();
        if(status == 1) {
          /// 支付成功
          Utils.showToastMsg('支付成功');
          Get.offNamedUntil(RoutesID.SELLER_ORDER_PAGE, (route) => route.settings.name == RoutesID.MAIN_TAB_PAGE, arguments: {"index": 0});
        } else {
          showConfirmDialog(
            singleText: '确定',
            onSingle: () async {
              Get.back();
            },
            content: '支付异常，请联系工作人员',
          );
        }
      }
    });
  }

  doSnapUpCreate() async {
    ResultData<DataModel>? _result = await LRequest.instance.request<DataModel>(
        url: SnapApis.SNAP_CREATE,
        t: DataModel(),
        data: {
          "addressId": addressList.first.id,
          "commodityId": goodsList[0].commodityId,
          "userId": userHelper.userInfo.value?.id,
        },
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("创建抢购订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("创建抢购订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          showSuccessDialog(onConfirm: () {
            userHelper.isShowBadge.value = true;
            Get.offAllNamed(RoutesID.MAIN_TAB_PAGE,
                arguments: {'tabIndex': 3, 'showBadge': true});
          });
          var model = result.value;
          if (model == null) {
            return;
          }
        });
  }

  Future<int> checkPayStatus() async {
    int status = -1;
    ResultData<ChargeModel>? _result = await LRequest.instance.request<
        ChargeModel>(
        url: SnapApis.PAY_STATUS,
        t: ChargeModel(),
        queryParameters: {
          "id": chargeModel.value?.id
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          status = -1;
        },
        onSuccess: (result) {
          status = result.value?.tradeState ?? 0;
        });
    return status;
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

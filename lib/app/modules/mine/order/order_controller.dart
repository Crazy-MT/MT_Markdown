import 'dart:async';

import 'package:code_zero/app/modules/mine/buyer_order/order_send_sell/model/charge_model.dart';
import 'package:code_zero/app/modules/mine/order/model/self_order_list_model.dart';
import 'package:code_zero/app/modules/mine/order/model/self_order_tab_info.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/colors.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/components/safe_tap_widget.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluwx/fluwx.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final pageName = 'Order'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final editStatus = 0.obs;

  final List<SelfOrderTabInfo> myTabs = <SelfOrderTabInfo>[
    SelfOrderTabInfo(
        Tab(text: '全部'), 0, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待付款'), 1, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待发货'), 2, RefreshController(), 1, RxList<SelfOrderItems>()),
    SelfOrderTabInfo(
        Tab(text: '待收货'), 3, RefreshController(), 1, RxList<SelfOrderItems>()),
  ];

  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: myTabs.length);
    tabController?.index = Get.arguments['index'] as int;
    _settingEditStatus();
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        // print("点击了下标为${tabController?.index}的tab");
        _settingEditStatus();
        getOrder(true, myTabs[tabController?.index ?? 0]);
      }
    });
    initAllData();
  }

  _settingEditStatus() {
    if (tabController?.index == 1) {
      /// todo 暂时不做合单支付
      // this.editStatus.value = 1;
    } else {
      this.editStatus.value = 0;
    }
  }

  initAllData() async {
    pageStatus.value = FTStatusPageType.loading;
    await Future.forEach<SelfOrderTabInfo>(myTabs, (element) async {
      await getOrder(true, element);
    }).catchError((e) {
      errorLog(e.toString());
      pageStatus.value = FTStatusPageType.success;
    });
    pageStatus.value = FTStatusPageType.success;
  }

  getOrder(bool isRefresh, SelfOrderTabInfo tabInfo) async {
    int prePageIndex = tabInfo.currentPage;
    if (isRefresh) {
      tabInfo.currentPage = 1;
    } else {
      tabInfo.currentPage++;
    }

    Map<String, dynamic>? queryParameters = {
      "userId": userHelper.userInfo.value?.id,
      "page": tabInfo.currentPage,
      "size": 10,
    };
    if (tabInfo.tradeState == 0) {
      queryParameters["tradeStateList"] = '1,2,3,4,5,6,7,8,9';
    }
    if (tabInfo.tradeState == 1) {
      queryParameters["tradeStateList"] = '3,6';
    }
    if (tabInfo.tradeState == 2) {
      queryParameters["tradeStateList"] = '1';
    }

    if (tabInfo.tradeState == 3) {
      queryParameters["tradeStateList"] = '9';
    }

    ResultData<SelfOrderListModel>? _result =
        await LRequest.instance.request<SelfOrderListModel>(
      url: SnapApis.SELF_ORDER_LIST,
      queryParameters: queryParameters,
      t: SelfOrderListModel(),
          isShowLoading: false,
          requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? tabInfo.currentPage = prePageIndex : tabInfo.currentPage--;
      },
    );
    if (_result?.value != null) {
      lLog(
          'MTMTMT BuyerOrderController.getOrder ${tabInfo.orderList.value.length} ');
      if (isRefresh) {
        tabInfo.orderList.clear();
      }
      isRefresh
          ? tabInfo.orderList.value = _result?.value?.items ?? []
          : tabInfo.orderList.addAll(_result?.value?.items ?? []);
      lLog(
          'MTMTMT BuyerOrderController.getOrder ${tabInfo.orderList.value.length} ');
      tabInfo.orderList.refresh();
    }

    if (isRefresh) {
      tabInfo.refreshController.refreshCompleted();
      tabInfo.refreshController.loadComplete();
    } else {
      if ((_result?.value?.items ?? []).isEmpty) {
        tabInfo.refreshController.loadNoData();
      } else {
        tabInfo.refreshController.loadComplete();
      }
    }
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  String getTradeState(tradeState) {
    if (tabController?.index == 3) {
      return "待收货";
    }
    if (tabController?.index == 2) {
      return "待发货";
    }
    if (tabController?.index == 1) {
      return "待付款";
    }

    switch (tradeState) {
      case 0:
        return "未支付";
      case 1:
        return "支付成功";
      case 2:
        return "转入退款";
      case 3:
        return "未支付";
      case 4:
        return "已关闭";
      case 5:
        return "已撤销";
      case 6:
        return "用户支付中";
      case 7:
        return "支付失败";
      case 8:
        return "代发货";
      case 9:
        return "已发货";
    }
    return "其它方式";
  }

  Future<void> cancelOrder(int? id) async {
    ResultData<SelfOrderListModel>? _result = await LRequest.instance.request<
            SelfOrderListModel>(
        url: SnapApis.CLOSE_ORDER_LIST,
        queryParameters: {"id": id},
        t: SelfOrderListModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("取消订单失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("取消订单失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (_) {
          Utils.showToastMsg("取消订单成功");
          initAllData();
        });
  }

  Future<void> shouhuo(int? id) async {
    ResultData<SelfOrderListModel>? _result = await LRequest.instance.request<
            SelfOrderListModel>(
        url: SnapApis.SHOUHUO,
        data: {"id": id},
        t: SelfOrderListModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("确认收货失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("确认收货失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (_) {
          Utils.showToastMsg("确认收货成功");
          initAllData();
        });
  }

  void pay(SelfOrderItems item) {
    toWxPay(item);
  }

  void toWxPay(SelfOrderItems item) async {
    var isInstalled = await isWeChatInstalled;

    if (!isInstalled) {
      Utils.showToastMsg("请先安装微信");
    }
    payWithWeChat(
      appId: 'wxe02b86dc09511f64',
      partnerId: item.partnerId ?? "",
      prepayId: item.prepayId ?? "",
      packageValue: item.package ?? "",
      nonceStr: item.nonceStr ?? "",
      timeStamp: int.parse(item.timeStamp ?? "0"),
      sign: item.sign ?? "",
    );
    // 支付回调
    // 一般情况下打开微信支付闪退，errCode为 -1 ，多半是包名、签名和在微信开放平台创建时的配置不一致。
    // weChatResponseEventHandler 存在多次 listen 且无法关闭的情况。 解决办法，可以是放在单独的对象里，另一个办法就是只取第一个
    weChatResponseEventHandler.first.asStream().listen(
      (data) {
        if (Get.currentRoute != RoutesID.ORDER_SEND_SELL_PAGE) {
          return;
        }

        if (data.errCode == -2) {
          Utils.showToastMsg('支付失败，请重试');
        } else {
          checkPayResult(item.id);
        }
      },
    );
  }

  void checkPayResult(int? id) {
    EasyLoading.show();

    int count = 0;
    Timer.periodic(Duration(seconds: 2), (timer) async {
      count += 1;
      int status = await checkPayStatus(id);
      lLog('MTMTMT checkPayResult ${status}');

      if (count >= 15) {
        timer.cancel();
        EasyLoading.dismiss();
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
      if (status == 3 || status == 6) {
      } else {
        timer.cancel();
        EasyLoading.dismiss();
        if (status == 1) {
          /// 支付成功
          Utils.showToastMsg('支付成功');
          initAllData();
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

  Future<int> checkPayStatus(int? id) async {
    int status = -1;
    ResultData<ChargeModel>? _result =
        await LRequest.instance.request<ChargeModel>(
            url: SnapApis.PAY_STATUS,
            t: ChargeModel(),
            queryParameters: {"id": id},
            requestType: RequestType.GET,
            errorBack: (errorCode, errorMsg, expMsg) {
              status = -1;
            },
            isShowLoading: false,
            onSuccess: (result) {
              status = result.value?.tradeState ?? 0;
            });
    return status;
  }

  void checkWuliu(SelfOrderItems item) {
    if (item.courierCompany == null ||
        item.trackingNumber == null ||
        item.trackingNumber!.isEmpty ||
        item.trackingNumber!.isEmpty) {
      Utils.showToastMsg('暂无快递信息');
      return;
    }
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.w),
                topLeft: Radius.circular(10.w))),
        context: Get.context!,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            height: 171.w,
            child: Stack(
              children: [
                Positioned(
                    top: 25.w,
                    right: 20.w,
                    child: SafeTapWidget(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        'assets/images/close.png',
                        width: 20.w,
                      ),
                    )),
                Container(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.w,
                      ),
                      Text(
                        "查看物流",
                        style: TextStyle(
                            fontSize: 20.sp, color: Color(0xFF000000)),
                      ),
                      SizedBox(
                        height: 30.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (item.courierCompany ?? "暂无物流信息").isEmpty
                                        ? "暂无物流信息"
                                        : item.courierCompany!,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  Text(
                                    (item.trackingNumber ?? "暂无物流信息").isEmpty
                                        ? "暂无物流信息"
                                        : item.trackingNumber!,
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                            SafeTapWidget(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: item.trackingNumber));
                                Utils.showToastMsg('复制成功');
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.w),
                                    color: Color(0xff1BDB8A),
                                  ),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "复制",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                    ],
                  ),
                  width: double.infinity,
                )
              ],
            ),
          );
        });
  }
}

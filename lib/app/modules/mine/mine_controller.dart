import 'dart:async';

import 'package:code_zero/app/modules/mine/model/order_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class MineController extends GetxController {
  final pageName = 'Mine'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();
  var daifukuanCount = 0.obs;
  var daishangjiaCount = 0.obs;
  var yifukuanCount = 0.obs;

  var daishoukuanCount = 0.obs;
  var daiquerenCount = 0.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    timer?.cancel();
    daifukuanCount.value = 0;
    daishangjiaCount.value = 0;
    yifukuanCount.value = 0;
    daishoukuanCount.value = 0;
    daiquerenCount.value = 0;
    if(userHelper.userInfo.value?.token?.isNotEmpty ?? false) {
      getBuyerOrder();
      getSellerOrder();
      timer = Timer.periodic(Duration(seconds: 10), (timer) {
        getBuyerOrder();
        getSellerOrder();
      });
    }
  }

  getBuyerOrder() async {
    Map<String, dynamic>? queryParameters = {};

    // 待付款 0; 待上架 3; 已付款 1,2
    queryParameters = {
      "to-user-id": userHelper.userInfo.value?.id,
      "page": 1,
      "size": 200,
      "trade-state-list": "0,1,2,3",
    };

    ResultData<OrderListModel>? _result =
        await LRequest.instance.request<OrderListModel>(
            url: SnapApis.ORDER_LIST,
            queryParameters: queryParameters,
            isShowLoading: false,
            t: OrderListModel(),
            requestType: RequestType.GET,
            errorBack: (errorCode, errorMsg, expMsg) {},
            onSuccess: (rest) {
              daifukuanCount.value = 0;
              daishangjiaCount.value = 0;
              yifukuanCount.value = 0;
              rest.value?.items?.forEach((element) {
                if (element.tradeState == 0) {
                  daifukuanCount.value++;
                }
                if (element.tradeState == 3) {
                  daishangjiaCount.value++;
                }
                if (element.tradeState == 1 || element.tradeState == 2) {
                  yifukuanCount.value++;
                }
              });
            });
  }

  getSellerOrder() async {
    Map<String, dynamic>? queryParameters = {};
    queryParameters = {
      "from-user-id": userHelper.userInfo.value?.id,
      "page": 1,
      "size": 200,
      "trade-state-list": '0,1',
    };

    ResultData<OrderListModel>? _result =
        await LRequest.instance.request<OrderListModel>(
            url: SnapApis.ORDER_LIST,
            queryParameters: queryParameters,
            t: OrderListModel(),
            requestType: RequestType.GET,
            isShowLoading: false,
            errorBack: (errorCode, errorMsg, expMsg) {},
            onSuccess: (rest) {
              daishoukuanCount.value = 0;
              daiquerenCount.value = 0;
              rest.value?.items?.forEach((element) {
                if (element.tradeState == 0) {
                  daishoukuanCount.value++;
                }
                if (element.tradeState == 1) {
                  daiquerenCount.value++;
                }
              });
            });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

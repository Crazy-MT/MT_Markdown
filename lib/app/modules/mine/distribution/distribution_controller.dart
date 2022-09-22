import 'dart:ui';

import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/app/modules/mine/wallet/wallet_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../../common/colors.dart';
import '../../../routes/app_routes.dart';

class DistributionController extends GetxController {
  final pageName = 'Distribution'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<_MenuItem> menuList = RxList<_MenuItem>();
  Rx<WalletModel?> model = Rx<WalletModel?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initMenuList();
    getStatistics();
  }

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

  initMenuList() {
    menuList.add(_MenuItem(
        title: "我的佣金",
        onClick: () {
          Get.toNamed(RoutesID.MY_COMMISSION_PAGE, arguments: {
            'model' : model.value
          });
        }));
    menuList.add(_MenuItem(
        title: "提现记录",
        showDivider: false,
        onClick: () {
          Get.toNamed(RoutesID.TRANSACTIONS_PAGE);
        }));
    menuList.add(_MenuItem(
      title: "我的粉丝",
      showTopDivider: true,
      onClick: () {
        Get.toNamed(RoutesID.MY_FANS_PAGE);
      },
    ));
    menuList.add(_MenuItem(
        title: "粉丝订单",
        showDivider: false,
        onClick: () {
          Get.toNamed(RoutesID.FANS_ORDER_PAGE, arguments: {"wallet": model.value});
        }));
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _MenuItem {
  final String title;
  final bool showArrow;
  final bool showDivider;
  final bool showTopDivider;
  final bool isCenter;
  final VoidCallback? onClick;
  final Color titleColor;

  _MenuItem({
    required this.title,
    this.showArrow = true,
    this.showDivider = true,
    this.showTopDivider = false,
    this.isCenter = false,
    this.onClick,
    this.titleColor = AppColors.text_dark,
  });
}

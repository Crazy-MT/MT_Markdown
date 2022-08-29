import 'package:code_zero/app/modules/home/goods_detail/widget/buy_dialog.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../network/base_model.dart';
import '../../../../network/l_request.dart';
import '../../../../utils/log_utils.dart';
import '../../../../utils/utils.dart';
import '../../snap_up/model/session_model.dart';
import '../../snap_up/snap_apis.dart';

class GoodsDetailController extends GetxController {
  final pageName = 'GoodsDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  PageController pageController = PageController();
  RxList<String> thumbnailsList = RxList<String>();
  RxList<String> paramsPicList = RxList<String>();
  RxList<String> introPicList = RxList<String>();
  RxList<String> detailPicList = RxList<String>();
  CommodityItem goods = CommodityItem();
  var timerRefresh = false.obs;

  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    goods = Get.arguments?["good"] ?? CommodityItem();
    initData();
    pageController.addListener(() {
      currentIndex.value = pageController.page?.toInt() ?? 1;
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initIntroPicList();
    initDetailPicList();
  }

  initIntroPicList() {
    thumbnailsList.addAll(goods.thumbnails ?? []);
    paramsPicList.addAll(goods.parameterImages ?? []);
    introPicList.addAll(goods.images ?? []);
  }

  initDetailPicList() {
    detailPicList.addAll(goods.images ?? []);
  }

  doBuy() async {
    String result = await showByDialog(isAddToCat: false);
    if (result.isEmpty) return;
    Get.toNamed(RoutesID.SUBMIT_ORDER_PAGE);
  }

  doAddToCart() async {
    var result = await showByDialog(isAddToCat: true);
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  isCountDown() {
    Map map = {};
    map['text'] = "立即抢购";
    String now = formatDate(DateTime.now(), [HH, ':', nn, ':', ss]);
    var nowArr = now.split(":");
    var startTime = Get.arguments['startTime'];
    var endTime = Get.arguments['endTime'];

    var startArr = startTime?.split(":");
    var endArr = endTime?.split(":");
    int nowHour = (int.parse(nowArr[0]));
    int nowMinute = int.parse(nowArr[1]);
    int nowSecond = int.parse(nowArr[2]);
    int nowTime = nowHour * 60 * 60 + nowMinute * 60 + nowSecond; // 当前天分钟数
    int startHour = int.parse(startArr?[0] ?? "0");
    int startMinute = int.parse(startArr?[1] ?? "0");
    int start = startHour * 60 * 60 + startMinute * 60;

    int endHour = int.parse(endArr?[0] ?? "0");
    int endMinute = int.parse(endArr?[1] ?? "0");
    int end = endHour * 60 * 60 + endMinute * 60;

    /// 超时
    if (nowTime > end) {
      map['isOpen'] = false;
      map['text'] = "已结束";
    } else {
      map['isOpen'] = true;
    }
    map['seconds'] = (start - nowTime);
    return map;
  }
}

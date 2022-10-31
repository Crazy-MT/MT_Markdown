import 'package:code_zero/app/modules/home/goods_detail/widget/buy_dialog.dart';
import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/shopping_cart/model/shopping_cart_list_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoodsDetailController extends GetxController {
  final pageName = 'GoodsDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  PageController pageController = PageController();
  RxList<String> thumbnailsList = RxList<String>();
  RxList<String> paramsPicList = RxList<String>();
  RxList<String> introPicList = RxList<String>();
  RxList<String> detailPicList = RxList<String>();
  Rx<CommodityItem?> goods = Rx<CommodityItem?>(null);
  var timerRefresh = false.obs;

  final currentIndex = 0.obs;
  var isFromSnap;

  @override
  void onInit() {
    super.onInit();
    isFromSnap = Get.arguments?["from"] == RoutesID.SNAP_DETAIL_PAGE;
    goods.value = Get.arguments?["good"] ?? CommodityItem();
    initData();
    pageController.addListener(() {
      currentIndex.value = pageController.page?.toInt() ?? 1;
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initGoodDetail();
  }

  initGoodDetail() async {
    await LRequest.instance.request<CommodityItem>(
        url: HomeApis.GOOD_DETAIL,
        t: CommodityItem(),
        queryParameters: {'id': goods.value?.id},
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取商品详情失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取商品详情失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        isShowLoading: true,
        onSuccess: (result) {
          var model = result.value;
          if (model == null) {
            return;
          }
          goods.value = result.value!;

          initIntroPicList();
          initDetailPicList();
        });
  }

  initIntroPicList() {
    thumbnailsList.addAll(goods.value?.thumbnails ?? []);
    paramsPicList.addAll(goods.value?.parameterImages ?? []);
    introPicList.addAll(goods.value?.images ?? []);
  }

  initDetailPicList() {
    detailPicList.addAll(goods.value?.images ?? []);
  }

  doBuy() async {
    String result = await showByDialog(
        isAddToCart: false, goods: goods.value!, isFromSnap: isFromSnap);
  }

  void goToSubmitOrderPage() {
    Get.toNamed(RoutesID.SUBMIT_ORDER_PAGE, arguments: {
      "goods": [
        ShoppingCartItem(
            commodityId: goods.value?.id,
            commodityName: goods.value?.name,
            commodityCount: 1,
            commodityPrice: double.tryParse(goods.value?.currentPrice ?? "0"),
            commodityThumbnail: goods.value?.thumbnails
                ?.firstWhere((element) => element.isNotEmpty, orElse: () => ""))
      ].obs,
      "isFromSnap": isFromSnap,
      "totalPrice": goods.value?.currentPrice
    });
  }

  doAddToCart() async {
    var result = await showByDialog(
        isAddToCart: true, goods: goods.value!, isFromSnap: isFromSnap);
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
    map['start'] = start;
    return map;
  }
}

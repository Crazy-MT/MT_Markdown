import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final pageName = 'Home'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<_FenquItem> fenquList = RxList<_FenquItem>();
  RxList<CommodityItem> commodityList = RxList<CommodityItem>();
  ScrollController scrollController = ScrollController();
  final showScrollToTop = false.obs;

  int currentPage = 0;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initFenquList();
    getRecommendList();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 200 && !showScrollToTop.value) {
        showScrollToTop.value = true;
      } else if (scrollController.position.pixels < 200 &&
          showScrollToTop.value) {
        showScrollToTop.value = false;
      }
    });
  }

  getRecommendList({bool isRefresh = true}) async {
    if(isRefresh) {
      currentPage = 1;
    }
    await LRequest.instance.request<
        CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": currentPage,
          "size": pageSize,
          "status" : 1
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          refreshController.refreshFailed();
          Utils.showToastMsg("获取列表失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }
          if(isRefresh) {
            commodityList.clear();
          } else {
            currentPage++;
          }
          commodityList.addAll(model.items!);
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if(model.totalCount <= commodityList.length) {
            refreshController.loadNoData();
          }
        });
  }

  initFenquList() {
    fenquList.clear();
    fenquList.add(_FenquItem("吊坠", Assets.imagesDiaozhui, 1));
    fenquList.add(_FenquItem("把件", Assets.imagesBajian, 2));
    fenquList.add(_FenquItem("项链", Assets.imagesXianglian, 3));
    fenquList.add(_FenquItem("耳坠", Assets.imagesErzhui, 4));
    fenquList.add(_FenquItem("戒指", Assets.imagesJiezhi, 5));
    fenquList.add(_FenquItem("手镯", Assets.imagesShouzhuo, 6));
  }

  scrollerToTop() {
    scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _FenquItem {
  final String name;
  final String image;
  final int categoryId;

  _FenquItem(this.name, this.image, this.categoryId);
}

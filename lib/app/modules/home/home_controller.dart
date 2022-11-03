import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:r_upgrade/r_upgrade.dart';

class HomeController extends GetxController {
  final pageName = 'Home'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<_FenquItem> fenquList = RxList<_FenquItem>();
  /// 总商品
  RxList<CommodityItem> commodityList = RxList<CommodityItem>();
  // 下面商品列表
  RxList<CommodityItem> homeList = RxList<CommodityItem>();
  // 顶部 banner
  RxList<CommodityItem> bannerList = RxList<CommodityItem>();
  // 广告
  RxList<CommodityItem> advList = RxList<CommodityItem>();
  ScrollController scrollController = ScrollController();
  final showScrollToTop = false.obs;

  int currentPage = 0;
  int pageSize = 20;
  final RefreshController refreshController = new RefreshController();

  var images = [Assets.imagesHomeBanner, Assets.imagesHomeBanner1, Assets.imagesHomeBanner2, Assets.imagesHomeBanner3];

  @override
  void onInit() {
    super.onInit();
    initData();
    upgrade("https://cos.pgyer.com/f6a1b7dc0c3952616a160feab1d64872.apk?sign=b275047c68cae0c90bbadf1521185111&t=1667469520&response-content-disposition=attachment%3Bfilename%3D%E4%BA%BF%E7%BF%A0%E7%8F%A0%E5%AE%9D%E5%95%86%E5%9F%8E_1.0.5.apk");
    // upgradeFromAppStore();
  }

  initData() async {
    pageStatus.value = FTStatusPageType.success;
    initFenquList();
    getRecommendList();
    getBannerList();
    getAdvList();
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
    systemSetting.initSystemSetting();
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
          "status" : 1,
          "isDelete": 0,
          "order": "asc",
          "orderBy":"order_no"
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          refreshController.refreshFailed();
          Utils.showToastMsg("获取列表失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        isShowLoading: false,
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }
          if(isRefresh) {
            commodityList.clear();
            currentPage++;
          } else {
            currentPage++;
          }
          commodityList.addAll(model.items!);
          homeList.value = commodityList.where((p0) => (p0.isNew == 0 && p0.isHot == 0)).toList();
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if(model.totalCount <= commodityList.length) {
            refreshController.loadNoData();
          }
        });
  }

  getBannerList() async {
    await LRequest.instance.request<
        CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": 1,
          "size": pageSize,
          "status" : 1,
          "isDelete": 0,
          "filter": 2,
          "order": "asc",
          "orderBy":"c.order_no"
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
        },
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            return;
          }
          bannerList.clear();
          bannerList.addAll(model.items!);
          lLog('MTMTMT HomeController.getBannerList ${bannerList.length} ');
        });
  }

  getAdvList() async {
    await LRequest.instance.request<
        CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": 1,
          "size": pageSize,
          "status" : 1,
          "isDelete": 0,
          "filter": 3,
          "order": "asc",
          "orderBy":"c.order_no"
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
        },
        onSuccess: (result) {
          var model = result.value;
          if(model == null || model.items == null) {
            return;
          }
          advList.clear();
          advList.addAll(model.items!);
          lLog('MTMTMT HomeController.getAdvList ${advList.length} ');
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

  upgrade(String apkUrl) async{
    int? id = await RUpgrade.upgrade(apkUrl, isAutoRequestInstall: true, );
    showToast("id MTMTMT");
  }

  void upgradeFromAppStore() async {
    bool? isSuccess = await RUpgrade.upgradeFromAppStore(
      '1644461159',
    );
    print(isSuccess);
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

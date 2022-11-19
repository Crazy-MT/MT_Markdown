import 'dart:io';

import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/home/model/app_versions.dart';
import 'package:code_zero/app/modules/home/model/red_envelope.dart';
import 'package:code_zero/app/modules/home/red_bag_dialog.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/confirm_dialog.dart';
import 'package:code_zero/common/user_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/device_util.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:r_upgrade/r_upgrade.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
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
  int? id;
  int currentPage = 0;
  int pageSize = 20;
  final RefreshController refreshController = new RefreshController();

  AnimationController? scaleAnimationController;
  AnimationController? slideAnimationController;
  Animation<double>? scaleAnimation;
  Animation<double>? slideAnimation;

  var images = [
    Assets.imagesHomeBanner,
    Assets.imagesHomeBanner1,
    Assets.imagesHomeBanner2,
    Assets.imagesHomeBanner3
  ];

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    super.onInit();
    scaleAnimationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              scaleAnimationController?.reverse();
            } else if (status == AnimationStatus.dismissed) {
              scaleAnimationController?.forward();
            }
          });
    scaleAnimation =
        Tween(begin: .9, end: 1.0).animate(scaleAnimationController!);
    scaleAnimationController?.forward();

    slideAnimationController = AnimationController(
        duration: Duration(milliseconds: 500),
        reverseDuration: Duration(milliseconds: 250),
        vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 400), () {
            slideAnimationController?.reverse();
          });
        } else if (status == AnimationStatus.dismissed) {
          slideAnimationController?.forward();
        }
      });
    slideAnimation =
        Tween(begin: 0.0, end: 1.0).animate(slideAnimationController!);
    slideAnimationController?.forward();

    initData();
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

    Future.delayed(Duration(seconds: 1)).then((value) async {
      if (!PlatformUtils.isWeb) {
        // 检查升级
        await checkVersion();
      }
      // 信息不足去引导
      await Utils().checkUserInfo(RoutesID.HOME_PAGE);
      await checkRedEnvelope();
    });
  }

  Future<void> checkRedEnvelope() async {
    ResultData<RedEnvelope>? _result =
        await LRequest.instance.request<RedEnvelope>(
            url: Apis.RED_ENVELOPE,
            t: RedEnvelope(),
            requestType: RequestType.GET,
            queryParameters: {
              'userId': userHelper.userInfo.value?.id
            },
            isShowLoading: true,
            errorBack: (errorCode, errorMsg, expMsg) {
              lLog('MTMTMT HomeController.checkRedEnvelope ${errorMsg} ');
            },
            onSuccess: (rest) async {
              lLog('MTMTMT HomeController.checkRedEnvelope ${rest} ');
              RedEnvelope envelope = rest.value as RedEnvelope;
              if (envelope.hasNewRedEnvelope == 1) {
                showRedBagDialog(
                    newRedEnvelopeAmount: envelope.newRedEnvelopeAmount,
                    onConfirm: () {});
              }
            });
  }

  Future<void> checkVersion() async {
    ResultData<AppVersions>? _result =
        await LRequest.instance.request<AppVersions>(
            url: Apis.APP_VERSION,
            t: AppVersions(),
            requestType: RequestType.GET,
            isShowLoading: false,
            errorBack: (errorCode, errorMsg, expMsg) {},
            onSuccess: (rest) async {
              try {
                AppVersions model = rest.value as AppVersions;
                List<int> curV = (deviceUtil.version ?? "1.0.0")
                    .split(".")
                    .map((e) => int.parse(e))
                    .toList();
                List<int> v = (model.versionNum ?? "1.0.0")
                    .split(".")
                    .map((e) => int.parse(e))
                    .toList();
                bool isUpdate = false;
                for (int i = 0; i < curV.length; i++) {
                  if (v[i] > curV[i]) {
                    isUpdate = true;
                    break;
                  }
                }
                if (isUpdate) {
                  await showConfirmDialog(
                      canNotDismiss: true,
                      barrierDismissible: false,
                      title: "版本更新",
                      content: model.updateDesc ?? "",
                      singleText: "确定",
                      onSingle: () async {
                        if (Platform.isAndroid) {
                          if (id == null) {
                            id = await RUpgrade.upgrade(
                                model.androidDownloadUrl ?? "",
                                useDownloadManager: false);
                            showToast("更新包正在下载，可以在通知栏查看");
                          } else {
                            DownloadStatus? status =
                                await RUpgrade.getDownloadStatus(id ?? 0);
                            if (status == DownloadStatus.STATUS_CANCEL ||
                                status == DownloadStatus.STATUS_FAILED ||
                                status == DownloadStatus.STATUS_SUCCESSFUL) {
                              id = await RUpgrade.upgrade(
                                  model.androidDownloadUrl ?? "",
                                  useDownloadManager: false);
                              showToast("更新包正在下载，可以在通知栏查看");
                            } else {
                              showToast("更新包正在下载，可以在通知栏查看");
                            }
                          }
                        }
                        if (Platform.isIOS) {
                          upgradeFromAppStore();
                        }
                      });
                }
              } catch (e) {
                lLog('MTMTMT HomeController.checkVersion ${e} ');
              }
            });
  }

  getRecommendList({bool isRefresh = true}) async {
    systemSetting.initSystemSetting();
    if (isRefresh) {
      currentPage = 1;
    }
    await LRequest.instance.request<CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": currentPage,
          "size": pageSize,
          "status": 1,
          "isDelete": 0,
          "order": "asc",
          "orderBy": "order_no"
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
          if (model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }
          if (isRefresh) {
            commodityList.clear();
            currentPage++;
          } else {
            currentPage++;
          }
          commodityList.addAll(model.items!);
          homeList.value = commodityList
              .where((p0) => (p0.isNew == 0 && p0.isHot == 0))
              .toList();
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if (model.totalCount <= commodityList.length) {
            refreshController.loadNoData();
          }
        });
  }

  getBannerList() async {
    await LRequest.instance.request<CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": 1,
          "size": pageSize,
          "status": 1,
          "isDelete": 0,
          "filter": 2,
          "order": "asc",
          "orderBy": "c.order_no"
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {},
        onSuccess: (result) {
          var model = result.value;
          if (model == null || model.items == null) {
            return;
          }
          bannerList.clear();
          bannerList.addAll(model.items!);
          lLog('MTMTMT HomeController.getBannerList ${bannerList.length} ');
        });
  }

  getAdvList() async {
    await LRequest.instance.request<CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          // "session-id": Get.arguments["id"],
          "page": 1,
          "size": pageSize,
          "status": 1,
          "isDelete": 0,
          "filter": 3,
          "order": "asc",
          "orderBy": "c.order_no"
          // "owner-is-admin": 0
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {},
        onSuccess: (result) {
          var model = result.value;
          if (model == null || model.items == null) {
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

  void upgradeFromAppStore() async {
    bool? isSuccess = await RUpgrade.upgradeFromAppStore(
      '1644461159',
    );
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

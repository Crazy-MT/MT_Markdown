import 'package:code_zero/app/modules/home/activity/model/activity_list_model.dart';
import 'package:code_zero/app/modules/home/activity/model/activity_tab_info.dart';
import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivityController extends GetxController
    with GetTickerProviderStateMixin {
  final pageName = 'Activity'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final editStatus = 0.obs;

  final RxList<ActivityTabInfo> myTabs = RxList();
  Rx<TabController?> tabController = Rx<TabController?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
    tabController.value = TabController(vsync: this, length: myTabs.length);

    initAllData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  initAllData() async {
    await LRequest.instance.request<ActivityListModel>(
      url: Apis.COMMODITY_CATEGORY,
      queryParameters: {"page": 1, "size": 10, "kindId": 2},
      t: ActivityListModel(),
      isShowLoading: false,
      requestType: RequestType.GET,
      onSuccess: (rest) async {
        lLog('MTMTMT ActivityController.getCategory ${rest} ');
        ActivityListModel activityListModel = rest.value as ActivityListModel;
        for (ActivityItems items in activityListModel.items!) {
          myTabs.add(ActivityTabInfo(items.name!, items.id!,
              RefreshController(), 1, RxList<CommodityItem>(), true.obs));
          // myTabs.add(ActivityTabInfo(items.name!, items.id!,
          //     RefreshController(), 1, RxList<CommodityItem>(), false.obs));
        }
        tabController.value = TabController(vsync: this, length: myTabs.length);
        tabController.value?.addListener(() {
          if (tabController.value?.index ==
              tabController.value?.animation?.value) {
            myTabs.forEach((element) {
              element.isChoose.value = false;
            });
            myTabs[tabController.value?.index ?? 0].isChoose.value = true;
          }
        });

        await Future.forEach<ActivityTabInfo>(myTabs, (element) async {
          await getRecommendList(isRefresh: true, tabInfo: element);
        }).catchError((e) {
          errorLog(e.toString());
          pageStatus.value = FTStatusPageType.error;
        });
      },
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        // isRefresh ? tabInfo.currentPage = prePageIndex : tabInfo.currentPage--;
      },
    );
  }

  getRecommendList({bool isRefresh = true, ActivityTabInfo? tabInfo}) async {
    if (isRefresh) {
      tabInfo?.currentPage = 1;
    }
    await LRequest.instance.request<CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          "page": tabInfo?.currentPage,
          "size": 20,
          "status": 1,
          "isDelete": 0,
          "order": "asc",
          "orderBy": "order_no",
          "kindId": 2,
          // "categoryId": tabInfo?.id
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          tabInfo?.refreshController.refreshFailed();
          Utils.showToastMsg("获取列表失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        isShowLoading: false,
        onSuccess: (result) {
          var model = result.value;
          if (model == null || model.items == null) {
            tabInfo?.refreshController.refreshCompleted();
            tabInfo?.refreshController.loadComplete();
            return;
          }
          if (isRefresh) {
            // commodityList.clear();
            tabInfo?.currentPage++;
          } else {
            tabInfo?.currentPage++;
          }
          // commodityList.addAll(model.items!);
          tabInfo?.commodityList.value = model.items!;
          // .where((p0) => (p0.isNew == 0 && p0.isHot == 0))
          // .toList();
          tabInfo?.refreshController.refreshCompleted();
          tabInfo?.refreshController.loadComplete();

          tabInfo?.commodityList.refresh();
          if (model.totalCount <= model.items!.length) {
            tabInfo?.refreshController.loadNoData();
          }
        });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

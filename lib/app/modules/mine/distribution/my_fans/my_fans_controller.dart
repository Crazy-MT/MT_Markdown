import 'package:code_zero/app/modules/mine/distribution/distribution_apis.dart';
import 'package:code_zero/app/modules/mine/distribution/model/fans_list_model.dart';
import 'package:code_zero/app/modules/mine/distribution/model/fans_statistics_model.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyFansController extends GetxController with GetTickerProviderStateMixin {
  final pageName = 'MyFans'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  Rx<FansStatisticsModel?> fansStatistics = Rx<FansStatisticsModel?>(null);

  RxList<FansListModel?> fansDataList = RxList<FansListModel?>();

  RxList<String> tabList = RxList<String>();
  TabController? tabController;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initTab();
    initData();
  }

  initData() async {
    pageStatus.value = FTStatusPageType.loading;
    initCommissionList();

    await initFansStatistics();
    initTabData();
    await getFansDataList();
    pageStatus.value = FTStatusPageType.success;
  }

  initFansStatistics() async {
    ResultData<FansStatisticsModel>? _result = await LRequest.instance.request<FansStatisticsModel>(
      url: DistributionApis.FANS_STATISTICS,
      queryParameters: {
        "userId": userHelper.userInfo.value?.id,
      },
      t: FansStatisticsModel(),
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("粉丝数据获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
      },
    );
    if (_result?.value != null) {
      lLog(_result!.value!.toJson().toString());
      fansStatistics.value = _result.value;
      // fansStatistics.value?.historyCount = 281;
      return;
    }
  }

  initCommissionList() {
    // fansDataList
  }

  initTab() {
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: 0,
    );
    // tabController?.index = Get.arguments['index'] as int;
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        currentIndex = tabController?.index == 0 ? 0.obs : 1.obs;
      }
    });
  }

  initTabData() {
    bool needAddOne = ((fansStatistics.value?.historyCount ?? 0) % 28) > 0;
    int tabCount = (fansStatistics.value?.historyCount ?? 0) ~/ 28;
    if (needAddOne) tabCount++;
    for (var i = 0; i < tabCount; i++) {
      importExtension;
      tabList.add("${i.toChinese()}组");
      fansDataList.add(null);
    }

    tabController = TabController(
      length: tabCount,
      vsync: this,
      initialIndex: 0,
    );
    lLog("tabCount:$tabCount");
  }

  getFansDataList() async {
    Future.forEach<String>(tabList, (element) async {
      int index = tabList.indexOf(element);

      ResultData<FansListModel>? _result = await LRequest.instance.request<FansListModel>(
        url: DistributionApis.LIST,
        queryParameters: {
          "from-user-id": userHelper.userInfo.value?.id,
          "order-by": "created_at",
          "page": index + 1,
          "size": 28,
        },
        t: FansListModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("粉丝列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
      );
      if (_result?.value != null) {
        lLog(_result!.value!.toJson().toString());
        fansDataList[index] = _result.value;
        return;
      }
    });
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

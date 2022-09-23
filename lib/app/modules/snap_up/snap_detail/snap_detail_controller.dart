import 'package:code_zero/common/extend.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../network/base_model.dart';
import '../../../../network/l_request.dart';
import '../../../../utils/log_utils.dart';
import '../../../../utils/utils.dart';
import '../model/session_model.dart';
import '../snap_apis.dart';
import 'model/commodity.dart' as c;

class SnapDetailController extends GetxController {
  final pageName = 'SnapDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<c.CommodityItem> commodityList = RxList<c.CommodityItem>();

  int currentPage = 1;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    getRecommendList();
  }

  getRecommendList({bool isRefresh = true}) async {
    lLog('MTMTMT SnapDetailController.getRecommendList 1: ${currentPage} ');
    if(isRefresh) {
      currentPage = 1;
    }
    await LRequest.instance.request<
        c.CommodityModel>(
        url: SnapApis.COMMODITY,
        isShowLoading: false,
        t: c.CommodityModel(),
        queryParameters: {
          "session-id": Get.arguments["id"],
          "page": currentPage,
          "size": pageSize,
          // "status" : 1,
          "status-list" : "1",
          "is-delete" : 0,
          "exclude-owner-id" : userHelper.userInfo.value?.id,
          "start-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']),
          "end-time": formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
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
            currentPage++;
          } else {
            currentPage++;
          }

          lLog('MTMTMT SnapDetailController.getRecommendList ${currentPage} ');
          commodityList.addAll(model.items!);
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if(model.totalCount <= commodityList.length) {
            refreshController.loadNoData();
          }
        });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}
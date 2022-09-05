import 'package:code_zero/app/modules/home/home_apis.dart';
import 'package:code_zero/app/modules/snap_up/snap_detail/model/commodity.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryController extends GetxController {
  final pageName = 'Category'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController newPasswordController = new TextEditingController();
  RxList<CommodityItem> commodityList = RxList<CommodityItem>();
  int categoryId = 1;
  int currentPage = 0;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
    if (Get.arguments['from'] == 'search') {
      // goodsList.clear();
    } else {
      categoryId = Get.arguments['categoryId'];
      getRecommendList();
    }
  }

  getRecommendList({bool isRefresh = true, String? orderBy}) async {
    if (isRefresh) {
      currentPage = 1;
    }
    await LRequest.instance.request<CommodityModel>(
        url: HomeApis.COMMODITY,
        t: CommodityModel(),
        queryParameters: {
          "categoryId": categoryId,
          "page": currentPage,
          "size": pageSize,
          "status": 1,
          "orderBy": orderBy,
          'order': 'asc'
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
          if (model == null || model.items == null) {
            refreshController.refreshCompleted();
            refreshController.loadComplete();
            return;
          }
          if (isRefresh) {
            commodityList.clear();
          } else {
            currentPage++;
          }
          commodityList.addAll(model.items!);
          refreshController.refreshCompleted();
          refreshController.loadComplete();

          if (model.totalCount <= commodityList.length) {
            refreshController.loadNoData();
          }
        });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  void sortBySales() {
    getRecommendList(isRefresh: true, orderBy: "trans_count");
  }

  void sortByPrice() {
    getRecommendList(isRefresh: true, orderBy: "current_price");
  }
}

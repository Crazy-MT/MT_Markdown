import 'package:code_zero/app/modules/home/model/red_envelope_reward.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RedEnvelopeRewardController extends GetxController {
  final pageName = 'RedEnvelopeReward'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<Items?> rewardList = RxList<Items?>();
  int currentPage = 1;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
    getRewards(true);
  }

  getRewards(bool isRefresh) async {
    int prePageIndex = currentPage;
    if (isRefresh) {
      currentPage = 1;
    } else {
      currentPage++;
    }

    Map<String, dynamic>? queryParameters = {
      "page": currentPage,
      "size": 10,
      "userId": userHelper.userInfo.value?.id
    };

    ResultData<RedEnvelopeReward>? _result = await LRequest.instance.request<
        RedEnvelopeReward>(
      url: Apis.RED_ENVELOPE_REWARD,
      queryParameters: queryParameters,
      t: RedEnvelopeReward(),
      isShowLoading: false,
      requestType: RequestType.GET,
      errorBack: (errorCode, errorMsg, expMsg) {
        Utils.showToastMsg("获取失败：${errorCode == -1 ? expMsg : errorMsg}");
        errorLog("订单列表获取失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        isRefresh ? currentPage = prePageIndex : currentPage--;
      },
    );
    if (_result?.value != null) {
      if(isRefresh) {
        rewardList.clear();
      }
      isRefresh
          ? rewardList.value = _result?.value?.items ?? []
          : rewardList.addAll(_result?.value?.items ?? []);
      rewardList.refresh();
    }

    if (isRefresh) {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    } else {
      if ((_result?.value?.items ?? []).isEmpty) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    }
  }


  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

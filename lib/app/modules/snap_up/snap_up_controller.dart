import 'package:code_zero/app/modules/snap_up/model/session_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../network/base_model.dart';
import '../../../network/l_request.dart';
import '../../../utils/log_utils.dart';
import '../../../utils/utils.dart';

class SnapUpController extends GetxController {
  final pageName = 'SnapUp'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<Item> snapUpList = RxList<Item>();

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
    getSnapUpList();
  }

  getSnapUpList({bool isRefresh = true}) async {
    bool requestSuccess = true;
    if (isRefresh) {
      currentPage = 1;
      ResultData<SessionModel>? _result = await LRequest.instance.request<
              SessionModel>(
          url: SnapApis.LIST,
          t: SessionModel(),
          queryParameters: {
            "page": currentPage,
            "size": pageSize,
          },
          requestType: RequestType.GET,
          errorBack: (errorCode, errorMsg, expMsg) {
            Utils.showToastMsg("获取列表失败：${errorCode == -1 ? expMsg : errorMsg}");
            errorLog("获取列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          },
          onSuccess: (_) {
            requestSuccess = true;
          });

      if (requestSuccess) {
        snapUpList.value = [];
        snapUpList.addAll(_result!.value!.items!.toList());
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    } else {
      currentPage++;
      ResultData<SessionModel>? _result = await LRequest.instance.request<
              SessionModel>(
          url: SnapApis.LIST,
          t: SessionModel(),
          queryParameters: {
            "page": currentPage,
            "size": pageSize,
          },
          requestType: RequestType.GET,
          errorBack: (errorCode, errorMsg, expMsg) {
            Utils.showToastMsg("获取列表失败：${errorCode == -1 ? expMsg : errorMsg}");
            errorLog("获取列表失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
          },
          onSuccess: (_) {
            requestSuccess = true;
          });
      if (requestSuccess) {
        snapUpList.addAll(_result!.value!.items!.toList());
        refreshController.loadComplete();

        if (_result.value!.totalCount == 0) {
          refreshController.loadNoData();
        }
      } else {
        refreshController.loadFailed();
        refreshController.loadComplete();
      }
    }
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

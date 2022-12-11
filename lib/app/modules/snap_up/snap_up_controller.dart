import 'package:code_zero/app/modules/snap_up/model/session_model.dart';
import 'package:code_zero/app/modules/snap_up/snap_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/system_setting.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/utils/platform_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../network/base_model.dart';
import '../../../network/l_request.dart';
import '../../../utils/log_utils.dart';
import '../../../utils/utils.dart';
import '../others/widget/signature/signature_in_agreement.dart';

class SnapUpController extends GetxController {
  final pageName = 'SnapUp'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<Item> snapUpList = RxList<Item>();

  int currentPage = 1;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  var images = [
    'assets/images/snup_banner_4.png',
    // Assets.imagesSnupBanner,
    // Assets.imagesSnupBanner1,
    // Assets.imagesSnupBanner2,
    // Assets.imagesSnupBanner3
  ];
  final currentTimeFromNet = DateTime.now().millisecondsSinceEpoch.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    systemSetting.initSystemSetting();
    getSnapUpList();
  }

  getSnapUpList({bool isRefresh = true}) async {
    await getNetTime();
    if (isRefresh) {
      currentPage = 1;
    }
    ResultData<SessionModel>? _result = await LRequest.instance.request<
            SessionModel>(
        url: SnapApis.LIST,
        t: SessionModel(),
        isShowLoading: false,
        queryParameters: {
          "page": currentPage,
          "size": pageSize,
          "userId": userHelper.userInfo.value?.id
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
            snapUpList.value = [];
          }
          currentPage++;

          snapUpList.addAll(model.items!);

          refreshController.refreshCompleted();
          refreshController.loadComplete();
          if (model.totalCount <= snapUpList.length) {
            refreshController.loadNoData();
          }
        });
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> snapClick(index) async {
    if ((userHelper.userInfo.value?.token ?? "").isEmpty) {
      Utils.showToastMsg('请先登录');
      return;
    }
    await getNetTime();

    String toastText =
        snapUpList[index].statusText(currentTimeFromNet.value)["toast_text"] ??
            "";
    if (toastText.isEmpty) {
      // snapUpList[index].startTime = "15:19";
      // snapUpList[index].endTime = "15:45";

      if ((userHelper.userInfo.value?.hasSignature ?? 0) == 0) {
        Get.toNamed(
          RoutesID.LOCAL_HTML_PAGE,
          arguments: {
            "page_title": "用户注册协议",
            "html_file": PlatformUtils.isWeb
                ? "assets/html/user_registration_protocol_web.html"
                : "assets/html/user_registration_protocol.html",
            "bottom_widget": SignatureInAgreement(),
          },
        );
        return;
      }

      Get.toNamed(RoutesID.SNAP_DETAIL_PAGE, arguments: {
        "title": snapUpList[index].name,
        "id": snapUpList[index].id,
        "startTime": snapUpList[index].startTime,
        "endTime": snapUpList[index].endTime,
      });
    } else {
      Utils.showToastMsg(toastText);
    }
  }

  Future<void> getNetTime() async {
    /// http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp
    EasyLoading.show();
    try {
      Map? _result = await LRequest.instance.requestGet(
        url:
            'http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp',
      );
      currentTimeFromNet.value = int.parse(_result['data']['t']);
    } catch (e) {
      currentTimeFromNet.value = DateTime.now().millisecondsSinceEpoch;
    }
    EasyLoading.dismiss();
  }
}

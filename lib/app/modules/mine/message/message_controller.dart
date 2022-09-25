import 'package:code_zero/app/modules/mine/message/message_apis.dart';
import 'package:code_zero/app/modules/mine/message/message_model.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageController extends GetxController {
  final pageName = 'Message'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<MessageItems> messageList = RxList<MessageItems>();

  final RefreshController refreshController = new RefreshController();
  int currentPage = 1;
  int pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    initData();
    getMessageList();

    // messageList.add(MessageItems(msgTitle: "sans-serif", msgContent: "sss", createdAt: "ccc"));
    // messageList.add(MessageItems(msgTitle: "sans-serif", msgContent: "sss", createdAt: "ccc"));

  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  getMessageList({bool isRefresh = true}) async {
    if(isRefresh) {
      currentPage = 1;
    }
    ResultData<MessageModel>? _result = await LRequest.instance.request<MessageModel>(
        url: MessageApis.LIST,
        t: MessageModel(),
        queryParameters: {
          // "userId": userHelper.userInfo.value?.id,
          "msgType": 0,
          "status":1,
          "page": currentPage,
          "size": pageSize,
        },
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          refreshController.refreshFailed();
          Utils.showToastMsg("获取消息失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取消息失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
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
            messageList.value = [];
          } else {
          }
          currentPage++;

          messageList.addAll(model.items!);

          refreshController.refreshCompleted();
          refreshController.loadComplete();
          if(model.totalCount! <= messageList.length) {
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

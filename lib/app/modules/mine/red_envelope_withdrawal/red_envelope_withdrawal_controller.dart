import 'dart:math';

import 'package:code_zero/app/modules/home/model/red_envelope.dart';
import 'package:code_zero/app/modules/home/model/red_envelope_task.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:oktoast/oktoast.dart';

class RedEnvelopeWithdrawalController extends GetxController {
  final pageName = 'RedEnvelopeWithdrawal'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  Rx<RedEnvelopeTask?> task = Rx<RedEnvelopeTask?>(null);

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> redEnvelopeTask() async {
    ResultData<RedEnvelopeTask>? _result =
        await LRequest.instance.request<RedEnvelopeTask>(
            url: Apis.RED_ENVELOPE_TASK,
            t: RedEnvelopeTask(),
            requestType: RequestType.GET,
            queryParameters: {'userId': userHelper.userInfo.value?.id},
            isShowLoading: true,
            errorBack: (errorCode, errorMsg, expMsg) {
              lLog(
                  'MTMTMT RedEnvelopeWithdrawalController.checkRedEnvelope ${errorCode} ');
              showToast('获取失败: $errorMsg');
            },
            onSuccess: (rest) async {
              lLog(
                  'MTMTMT RedEnvelopeWithdrawalController.checkRedEnvelope ${rest} ');
              task.value = rest.value as RedEnvelopeTask;
            });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    redEnvelopeTask();
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

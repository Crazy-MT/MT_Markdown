import 'package:code_zero/app/modules/home/submit_order/model/data_model.dart';
import 'package:code_zero/app/modules/mine/wallet/drawing/drawing_apis.dart';
import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class DrawingController extends GetxController {
  final pageName = 'Drawing'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  final method = "".obs;
  int chooseMethod = 0;
  TextEditingController balanceController = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> choose() async {
    chooseMethod = await Get.toNamed(RoutesID.COLLECTION_SETTINGS_PAGE, arguments: {'title': '选择收款方式'});
    method.value = chooseMethod == 1 ? "微信" : "银行卡";
  }

  Future<void> createBalance() async {
    if(method.value.isEmpty) {
      Utils.showToastMsg('请选择提现方式');
      return;
    }
    if(Get.arguments["balance"] == 0) {
      Utils.showToastMsg('可提现金额为 0');
      return;
    }
    if(balanceController.text.isEmpty) {
      Utils.showToastMsg('请输入提现金额');
      return;
    }
    ResultData<DataModel>? _result = await LRequest.instance.request<
        DataModel>(
        url: DrawingApis.CREATE,
        data: {
          'balance' : balanceController.text,
          'method' : chooseMethod,
          'userId' : userHelper.userInfo.value?.id
        },
        t: DataModel(),
        requestType: RequestType.POST,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("提现失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("提现失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          Utils.showToastMsg("提现成功");
        }
    );
  }
}

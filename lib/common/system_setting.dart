import 'dart:convert';

import 'package:code_zero/common/user_apis.dart';
import 'package:code_zero/common/model/system_model.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:get/state_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../utils/log_utils.dart';
import 'model/user_model.dart';
import 'sp_const.dart';

class _SystemSetting {
  _SystemSetting();
  Rx<SystemSettingModel?> model = Rx<SystemSettingModel?>(null);

  Future<void> initSystemSetting() async {
    ResultData<SystemSettingModel>? _result = await LRequest.instance.request<SystemSettingModel>(
        url: Apis.SYSTEM_SETTING,
        t: SystemSettingModel(),
        requestType: RequestType.GET,
        isShowLoading: false,
        errorBack: (errorCode, errorMsg, expMsg) {
        },
        onSuccess: (rest) {
          model.value = rest.value as SystemSettingModel;
          // systemSetting.model.value?.auditSwitch = 1;
        });
  }
}

_SystemSetting systemSetting = _SystemSetting();

import 'dart:convert';

import 'package:code_zero/common/model/system_model.dart';
import 'package:get/state_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../utils/log_utils.dart';
import 'model/user_model.dart';
import 'sp_const.dart';

class _SystemSetting {
  _SystemSetting();
  Rx<SystemSettingModel?> model = Rx<SystemSettingModel?>(null);

}

_SystemSetting systemSetting = _SystemSetting();

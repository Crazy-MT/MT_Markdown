import 'dart:convert';

import 'package:code_zero/app/modules/mine/mine_controller.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sp_util/sp_util.dart';

import '../utils/log_utils.dart';
import 'model/user_model.dart';
import 'sp_const.dart';

class _UserHelper {
  _UserHelper();
  RxBool isLogin = false.obs;
  // RxBool guestLogin = false.obs;
  String userToken = "";
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);
  var isShowBadge = false.obs;

  void initToken() {
    userToken = SpUtil.getString(SpConst.USER_TOKEN) ?? "";
    if(userToken.isNotEmpty) {
      isLogin.value = true;
      String user = SpUtil.getString(SpConst.USER_INFO) ?? "{}";
      userInfo.value = UserModel.fromJson(json.decode(user.isEmpty ? "{}" : user));
    }
  }

  Future<void> whenLogin(UserModel userInfo) async {
    this.userInfo.value = userInfo;
    isLogin.value = true;
    // guestLogin.value = userInfo.isGuest ?? true;
    userToken = userInfo.token ?? "";
    await SpUtil.putString(SpConst.USER_TOKEN, userToken);
    await SpUtil.putString(SpConst.USER_INFO, json.encode(userInfo.toJson()));
    Get.find<MineController>().initData();
  }

  void updateSp(UserModel? userInfo) {
    SpUtil.putString(SpConst.USER_TOKEN, userToken);
    SpUtil.putString(SpConst.USER_INFO, json.encode(userInfo?.toJson()));
  }

  void whenLogout() {
    isLogin.value = false;
    isShowBadge.value = false;
    // guestLogin.value = false;
    userInfo.value = null;
    userToken = "";
    SpUtil.putString(SpConst.USER_TOKEN, "");
    SpUtil.putString(SpConst.USER_INFO, "");
    Get.find<MineController>().initData();

  }
}

_UserHelper userHelper = _UserHelper();

import 'package:get/state_manager.dart';
import 'package:sp_util/sp_util.dart';

import 'model/user_model.dart';
import 'sp_const.dart';

class _UserHelper {
  _UserHelper();
  RxBool isLogin = false.obs;
  RxBool guestLogin = false.obs;
  String userToken = "";
  Rx<UserModel?> userInfo = Rx<UserModel?>(null);

  void initToken() {
    userToken = SpUtil.getString(SpConst.USER_TOKEN) ?? "";
  }

  void whenLogin(UserModel userInfo) {
    this.userInfo.value = userInfo;
    isLogin.value = true;
    guestLogin.value = userInfo.isGuest ?? true;
    userToken = userInfo.token ?? "";
    SpUtil.putString(SpConst.USER_TOKEN, userToken);
  }

  void whenLogout() {
    isLogin.value = false;
    guestLogin.value = false;
    userInfo.value = null;
    userToken = "";
    SpUtil.putString(SpConst.USER_TOKEN, "");
  }
}

_UserHelper userHelper = _UserHelper();

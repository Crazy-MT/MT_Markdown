import 'package:code_zero/app/modules/mine/wallet/model/walle_model.dart';
import 'package:code_zero/app/modules/mine/wallet/wallet_apis.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:code_zero/generated/assets/assets.dart';
import 'package:code_zero/network/base_model.dart';
import 'package:code_zero/network/l_request.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/utils.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class WalletController extends GetxController {
  final pageName = 'Wallet'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  Rx<WalletModel?> model = Rx<WalletModel?>(null);

  RxList<_WalletItem> menuList = RxList<_WalletItem>();

  @override
  void onInit() {
    super.onInit();
    initData();
    getStatistics();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
  }

  Future<void> getStatistics() async {
    ResultData<WalletModel>? _result = await LRequest.instance.request<WalletModel>(
        url: WalletApis.ASSETS,
        queryParameters: {
          "user-id": userHelper.userInfo.value?.id
        },
        t: WalletModel(),
        requestType: RequestType.GET,
        errorBack: (errorCode, errorMsg, expMsg) {
          Utils.showToastMsg("获取资产统计失败：${errorCode == -1 ? expMsg : errorMsg}");
          errorLog("获取资产统计失败：$errorMsg,${errorCode == -1 ? expMsg : errorMsg}");
        },
        onSuccess: (rest) {
          model.value = rest.value;
        }
    );
  }


  initMenuList() {
    menuList.add(_WalletItem(image: Assets.imagesWalletBalance, title: '余额提现'));
    menuList.add(_WalletItem(image: Assets.imagesWalletRecord, title: '提现记录'));
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _WalletItem {
  final String image;
  final String title;

  _WalletItem({
    required this.image,
    required this.title,
  });
}

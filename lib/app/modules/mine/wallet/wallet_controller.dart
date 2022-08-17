import 'package:code_zero/generated/assets/assets.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

class WalletController extends GetxController {
  final pageName = 'Wallet'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  RxList<_WalletItem> menuList = RxList<_WalletItem>();

  @override
  void onInit() {
    super.onInit();
    initData();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
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

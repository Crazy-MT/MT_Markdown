import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';

enum AddressType {
  add,
  edit,
}

class AddressEditController extends GetxController {
  final pageName = 'AddressEdit'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  AddressType type = AddressType.add;
  RxList<_MenuItem> menuList = RxList<_MenuItem>();

  @override
  void onInit() {
    super.onInit();
    initData();
    initMenuList();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    type = (Get.arguments['type'] as int) == 0
        ? AddressType.add
        : AddressType.edit;
  }

  initMenuList() {
    menuList.add(_MenuItem(
      title: "收货人",
      hintTitle: "请填写收货人姓名",
    ));
    menuList.add(_MenuItem(
      title: "联系电话",
      hintTitle: "收件人号码",
    ));
    menuList.add(_MenuItem(
      title: "所在地区",
      hintTitle: "点击定位快速填写地址",
      showLocation: true,
    ));
    menuList.add(_MenuItem(
      title: "详细地址",
      hintTitle: "请输入地址",
    ));
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _MenuItem {
  final String title;
  final String hintTitle;
  final bool showLocation;

  _MenuItem({
    required this.title,
    required this.hintTitle,
    this.showLocation = false,
  });
}

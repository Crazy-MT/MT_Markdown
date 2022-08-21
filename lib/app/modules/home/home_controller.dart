import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:code_zero/common/extend.dart';
import 'package:code_zero/generated/assets/flutter_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  final pageName = 'Home'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  RxList<_FenquItem> fenquList = RxList<_FenquItem>();
  RxList<String> recommendList = RxList<String>();
  ScrollController scrollController = ScrollController();
  final showScrollToTop = false.obs;

  int currentPage = 0;
  int pageSize = 10;
  final RefreshController refreshController = new RefreshController();

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initFenquList();
    getRecommendList();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= 200 && !showScrollToTop.value) {
        showScrollToTop.value = true;
      } else if (scrollController.position.pixels < 200 &&
          showScrollToTop.value) {
        showScrollToTop.value = false;
      }
    });
  }

  getRecommendList({bool isRefresh = true}) async {
    if (isRefresh) {
      await Future.delayed(Duration(seconds: 3));

      bool requestSuccess = true;
      if (requestSuccess) {
        currentPage == 0;
        recommendList.value = [];
        for (var i = 0; i < 10; i++) {
          recommendList.add(
              DateTime.now().millisecondsSinceEpoch.formatTime("HH:mm:ss - ") +
                  "1019翡翠玻璃种镶玫瑰金叶子吊坠");
        }
        refreshController.refreshCompleted();
      } else {
        refreshController.refreshFailed();
      }
    } else {
      await Future.delayed(Duration(seconds: 3));
      currentPage++;
      bool requestSuccess = true;
      if (requestSuccess) {
        for (var i = 0; i < 10; i++) {
          recommendList.add(
              DateTime.now().millisecondsSinceEpoch.formatTime("HH:mm:ss - ") +
                  "1019翡翠玻璃种镶玫瑰金叶子吊坠");
        }
        refreshController.loadComplete();
      } else {
        refreshController.loadFailed();
        refreshController.loadComplete();
      }
    }
  }

  initFenquList() {
    fenquList.add(_FenquItem("吊坠", Assets.imagesDiaozhui));
    fenquList.add(_FenquItem("把件", Assets.imagesBajian));
    fenquList.add(_FenquItem("项链", Assets.imagesXianglian));
    fenquList.add(_FenquItem("耳坠", Assets.imagesErzhui));
    fenquList.add(_FenquItem("戒指", Assets.imagesJiezhi));
    fenquList.add(_FenquItem("手镯", Assets.imagesShouzhuo));
  }

  scrollerToTop() {
    scrollController.animateTo(0,
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

class _FenquItem {
  final String name;
  final String image;

  _FenquItem(this.name, this.image);
}

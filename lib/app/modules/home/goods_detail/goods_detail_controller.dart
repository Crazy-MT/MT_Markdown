import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoodsDetailController extends GetxController {
  final pageName = 'GoodsDetail'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;
  PageController pageController = PageController();
  RxList<String> goodsParams = RxList<String>();
  RxList<String> introPicList = RxList<String>();
  RxList<String> detailPicList = RxList<String>();

  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    pageController.addListener(() {
      currentIndex.value = pageController.page?.toInt() ?? 1;
    });
  }

  initData() {
    pageStatus.value = FTStatusPageType.success;
    initGoodsParams();
    initIntroPicList();
    initDetailPicList();
  }

  initGoodsParams() {
    goodsParams.add("item");
    goodsParams.add("item");
  }

  initIntroPicList() {
    introPicList.add(
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg1.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp247525088.jpg&refer=http%3A%2F%2Fimg1.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663143715&t=c2839982dc8a03d3a6a4987582de9342");
    introPicList.add(
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg1.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp247525088.jpg&refer=http%3A%2F%2Fimg1.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663143715&t=c2839982dc8a03d3a6a4987582de9342");
    introPicList.add(
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg1.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp247525088.jpg&refer=http%3A%2F%2Fimg1.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663143715&t=c2839982dc8a03d3a6a4987582de9342");
  }

  initDetailPicList() {
    String pic =
        "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg1.doubanio.com%2Fview%2Fgroup_topic%2Fl%2Fpublic%2Fp247525088.jpg&refer=http%3A%2F%2Fimg1.doubanio.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663143715&t=c2839982dc8a03d3a6a4987582de9342";
    for (var i = 0; i < 9; i++) {
      detailPicList.add(pic);
    }
  }

  @override
  void onClose() {}
  void setPageName(String newName) {
    pageName.value = newName;
  }
}

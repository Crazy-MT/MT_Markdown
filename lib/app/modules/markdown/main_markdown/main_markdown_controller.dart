import 'dart:convert';
import 'dart:io';

import 'package:code_zero/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:code_zero/app/modules/markdown/menu/menu.dart';
import 'package:code_zero/app/modules/markdown/router.dart';
import 'package:code_zero/common/sp_const.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_detector/platform_detector.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

class MainMarkdownController extends GetxController {
  final pageName = 'MainMarkdown'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  bool get isMobile => PlatformDetector.isAllMobile;

  int selectIndex = 0;
  final leftLayoutWidth = 220.0.obs;
  final isCollapsed = false.obs;
  RxList<MenuInfo> menuInfos =
      RxList<MenuInfo>(); // MenuInfo('1.md', '/Users/mt/Desktop/1.md')
  Rx<MenuInfo?> selectInfo = Rx<MenuInfo?>(null);
  final mdData = ''.obs;

  final RxList list = [].obs;
  Offset? offset;
  bool dragging = false;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    // menuInfos.add(MenuInfo("name", "assets/demo_zh.md"));
    List<String>? selectInfoSp = (await SharedPreferences.getInstance()).getStringList(SpConst.SELECT_INFO);
    if ((selectInfoSp?.isNotEmpty ?? false) && (selectInfoSp?.length ?? 0) > 0) {
      selectInfoSp?.forEach((element) {
        menuInfos.add(MenuInfo.fromJson(json.decode(element)));
      });
    }
    if (menuInfos.isNotEmpty) {
      selectInfo.value = menuInfos.first;
      mdData.value = await File(selectInfo.value!.path!).readAsString();
    }
    pageStatus.value = FTStatusPageType.success;
    /*File(selectInfo.value!.path).readAsString().then((data) {
      mdData.value = data;
      lLog('MTMTMT MainMarkdownController.initData ${data} ');
    });*/
    /*rootBundle.loadString("assets/demo_zh.md").then((data) {
      lLog('MTMTMT MainMarkdownController.initData ${data} ');
      mdData.value = data;
    });*/
    /*try {
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      lLog('MTMTMT MainMarkdownController.initData ${appDocumentsDirectory.path} ');
      String filePath = "${appDocumentsDirectory.path}/2.md";
      File file = File(filePath);

      if (file.existsSync()) {
        String content = await file.readAsString();
        print(content);
        lLog('MTMTMT MainMarkdownController.initData ${content} ');
      } else {
        print("File not found: $filePath");
      }
    } catch (e) {
      print("Error reading file: $e");
    }*/
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }
}

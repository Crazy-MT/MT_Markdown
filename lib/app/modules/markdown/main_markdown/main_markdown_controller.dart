import 'dart:convert';
import 'dart:io';

import 'package:mt_markdown/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:mt_markdown/app/modules/markdown/menu/menu.dart';
import 'package:mt_markdown/app/modules/markdown/router.dart';
import 'package:mt_markdown/common/sp_const.dart';
import 'package:mt_markdown/utils/log_utils.dart';
import 'package:mt_markdown/utils/platform_detector/platform_detector.dart';
import 'package:cross_file/cross_file.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mt_markdown/common/components/status_page/status_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:re_editor/re_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

class MainMarkdownController extends GetxController {
  final pageName = 'MainMarkdown'.obs;
  final errorMsg = "".obs;
  final pageStatus = FTStatusPageType.loading.obs;

  bool get isMobile => PlatformDetector.isAllMobile;

  int selectIndex = 0;
  final leftLayoutWidth = 280.0.obs;
  final isCollapsed = false.obs;
  RxList<MenuInfo> menuInfos = RxList<MenuInfo>();
  Rx<MenuInfo?> selectInfo = Rx<MenuInfo?>(null);
  final mdData = ''.obs;
  CodeLineEditingController codeLineEditingController = CodeLineEditingController();

  // final RxList list = [].obs;
  Offset? offset;
  bool dragging = false;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // sp.remove(SpConst.SELECT_INFO);
    List<String>? selectInfoSp = sp.getStringList(SpConst.SELECT_INFO);
    if ((selectInfoSp?.isNotEmpty ?? false) &&
        (selectInfoSp?.length ?? 0) > 0) {
      selectInfoSp?.forEach((element) {
        menuInfos.add(MenuInfo.fromJson(json.decode(element)));
      });
      menuInfos.value = Set<MenuInfo>.from(menuInfos).toList();
    } else {
      newPage();
    }
    if (menuInfos.isNotEmpty) {
      selectInfo.value = menuInfos.first;
      try{
        mdData.value = await File(selectInfo.value!.path!).readAsString();
      } catch(e) {

      }
    }
    pageStatus.value = FTStatusPageType.success;
  }

  @override
  void onClose() {}

  void setPageName(String newName) {
    pageName.value = newName;
  }

  Future<void> addFile(XFile file) async {
    // 去掉 /Users/ 前面的 /Volumes/Macintosh HD
    String target = '/Users/'; // The target substring to find
    String filePath = file.path;
    int startIndex = file.path.indexOf(target);
    if (startIndex != -1) {
      filePath = file.path.substring(startIndex);
      print(filePath); // Output: /Users/mt/Desktop/2.md
    } else {
      print("Substring not found");
    }

    MenuInfo info = MenuInfo(file.name, filePath, formatDate((await file.lastModified()), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]));
    menuInfos.add(info);
    menuInfos.value = Set<MenuInfo>.from(menuInfos).toList();

    await chooseInfo(info);
    debugPrint('MTMTMT  ${file.path} ${file.name}'
        '  ${await file.lastModified()}'
        '  ${await file.length()}'
        '  ${file.mimeType}');
  }

  Future<void> chooseInfo(MenuInfo info, {isModify = false}) async {
    selectInfo.value = info;
    if (!isModify) {
      if (selectInfo.value!.path!.isNotEmpty) {
        mdData.value = await File(selectInfo.value!.path!).readAsString();
      } else {
        mdData.value = '';
      }
    }

    List<String> infos = [];
    menuInfos.forEach((element) {
      infos.add(json.encode(element.toJson()));
    });

    (await SharedPreferences.getInstance())
        .setStringList(SpConst.SELECT_INFO, infos);
  }

  void newPage() {
    selectInfo.value = MenuInfo('未命名', '', '');
    mdData.value = '';
    menuInfos.add(selectInfo.value!);
  }

  void modifyLast({String? name, String? path, String? lastModified}) {
    menuInfos.removeLast();
    var info = MenuInfo(
        name ?? selectInfo.value?.name, path ?? selectInfo.value?.path ?? "", lastModified);
    menuInfos.add(info);
    chooseInfo(info, isModify: true);
  }

  void removeThis(MenuInfo menuInfo) {
    menuInfos.remove(menuInfo);
    chooseInfo(menuInfos.first);
  }
}

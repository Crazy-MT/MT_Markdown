import 'dart:convert';
import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:mt_markdown/app/modules/markdown/edit_markdown_page.dart';
import 'package:mt_markdown/app/modules/markdown/markdown_page.dart';
import 'package:mt_markdown/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:mt_markdown/app/modules/markdown/menu/menu.dart';
import 'package:mt_markdown/app/modules/markdown/router.dart';
import 'package:mt_markdown/common/sp_const.dart';
import 'package:mt_markdown/utils/log_utils.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:re_editor/re_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

import 'main_markdown_controller.dart';
import 'package:mt_markdown/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMarkdownPage extends GetView<MainMarkdownController> {
  const MainMarkdownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MoveWindow(
        child: Obx(
          () => FTStatusPage(
            type: controller.pageStatus.value,
            errorMsg: controller.errorMsg.value,
            builder: (BuildContext context) {
              return Scaffold(
                appBar: controller.isMobile
                    ? AppBar(
                        title: Obx(() {
                          return Text(
                            controller.selectInfo.value?.name ?? "",
                          );
                        }),
                        backgroundColor: Colors.black,
                        actions: [
                          /*IconButton(
                          onPressed: () => rootStore.dispatch(new ChangeLanguage()),
                          icon: Text(rootStore.state.language == 'en' ? '中' : 'En')),
                      IconButton(
                          onPressed: () => rootStore.dispatch(new ChangeThemeEvent()),
                          icon: Icon(
                            isDark
                                ? Icons.brightness_5_outlined
                                : Icons.brightness_2_outlined,
                            size: 15,
                          )),*/
                        ],
                      )
                    : null,
                body: Row(
                  children: [
                    if (!controller.isMobile) leftLayout(),
                    buildDragLine(),
                    Expanded(child: rightLayout()),
                  ],
                ),
                drawer: controller.isMobile
                    ? Drawer(
                        child: leftLayout(),
                      )
                    : null,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget leftLayout() {
    return DropTarget(
      onDragDone: (detail) async {
        for (final file in detail.files) {
          controller.addFile(file);
        }
      },
      onDragUpdated: (details) {
        controller.offset = details.localPosition;
      },
      onDragEntered: (detail) {
        controller.dragging = true;
        controller.offset = detail.localPosition;
      },
      onDragExited: (detail) {
        controller.dragging = false;
        controller.offset = null;
      },
      child: Obx(() {
        return SizedBox(
          width: controller.isCollapsed.value
              ? 45
              : controller.leftLayoutWidth.value,
          child: Obx(() {
            return Menu(
              router: RouterEnum.readme.path,
              isCollapsed: controller.isCollapsed.value && !controller.isMobile,
              onUnCollapsed: () {
                controller.isCollapsed.value = false;
              },
              onCollapsed: () {
                if (controller.isMobile) {
                  // Navigator.of(context).pop();
                  return;
                }
                controller.isCollapsed.value = true;
              },
              menuInfos: controller.menuInfos.cast<MenuInfo>().toList(),
              selectName: controller.selectInfo.value?.name,
              onSelect: (MenuInfo info) async {
                controller.chooseInfo(info);
              },
            );
          }),
        );
      }),
    );
  }

  Widget buildDragLine() {
    Widget line = VerticalDivider(width: 4);
    if (controller.isCollapsed.value) return line;
    return GestureDetector(
      onHorizontalDragStart: (e) {},
      onHorizontalDragEnd: (e) {},
      onHorizontalDragUpdate: (e) {
        final delta = e.delta;
        final width = delta.dx + controller.leftLayoutWidth.value;
        if (width >= 220 && width <= 400) {
          controller.leftLayoutWidth.value = width;
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.move,
        child: line,
      ),
    );
  }

  Widget rightLayout() => Obx(() {
        controller.codeLineEditingController.text = controller.mdData.value;
        return EditMarkdownPage(
          codeLineEditingController: controller.codeLineEditingController,
          title: controller.selectInfo.value?.name ?? "",
          filePath: controller.selectInfo.value?.path ?? "",
          controller: TextEditingController(text: controller.mdData.value),
        );
        /*return MarkdownPage(
            assetsPath: controller.selectInfo.value?.path,
            markdownData: controller.mdData.value,
            key: Key('assets/demo_zh.md'));*/
      });
}

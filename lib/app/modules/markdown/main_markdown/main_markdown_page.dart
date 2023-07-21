import 'package:code_zero/app/modules/markdown/markdown_page.dart';
import 'package:code_zero/app/modules/markdown/menu/menu.dart';
import 'package:code_zero/app/modules/markdown/router.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';

import 'main_markdown_controller.dart';
import 'package:code_zero/common/components/status_page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMarkdownPage extends GetView<MainMarkdownController> {
  const MainMarkdownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () =>
            FTStatusPage(
              type: controller.pageStatus.value,
              errorMsg: controller.errorMsg.value,
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: controller.isMobile
                      ? AppBar(
                    title: Text(
                      '"Text"',
                    ),
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
    );
  }

  Widget leftLayout() {
    return DropTarget(
      onDragDone: (detail) async {
        controller.list.add(detail.files);

        debugPrint('onDragDone:');
        for (final file in detail.files) {
          debugPrint('  ${file.path} ${file.name}'
              '  ${await file.lastModified()}'
              '  ${await file.length()}'
              '  ${file.mimeType}');
        }
      },
      onDragUpdated: (details) {
        controller.offset = details.localPosition;
        /*setState(() {
          offset = details.localPosition;
        });*/
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
          width: controller.isCollapsed.value ? 45 : controller.leftLayoutWidth
              .value,
          child: Obx(() {
            return Menu(
              router: RouterEnum.readme.path,
              isCollapsed: controller.isCollapsed.value && !controller.isMobile,
              onUnCollapsed: () {
                print("MTMTMT ${controller.isCollapsed.value}");
                controller.isCollapsed.value = false;
              },
              onCollapsed: () {
                if (controller.isMobile) {
                  // Navigator.of(context).pop();
                  return;
                }
                controller.isCollapsed.value = true;
              },
            );
          }),
        );
      }),
    );
  }

  Widget buildDragLine() {
    lLog('MTMTMT MainMarkdownPage.buildDragLine ${controller.isCollapsed} ');
    Widget line = VerticalDivider(width: 4);
    if (controller.isCollapsed.value) return line;
    return GestureDetector(
      onHorizontalDragStart: (e) {},
      onHorizontalDragEnd: (e) {},
      onHorizontalDragUpdate: (e) {
        final delta = e.delta;
        final width = delta.dx + controller.leftLayoutWidth
            .value;
        if (width >= 220 && width <= 400) {
          controller.leftLayoutWidth
              .value = width;
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.move,
        child: line,
      ),
    );
  }

  Widget rightLayout() =>
      MarkdownPage(
          assetsPath: 'assets/demo_zh.md', key: Key('assets/demo_zh.md'));
}

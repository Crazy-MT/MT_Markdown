import 'dart:ffi';
import 'dart:io';

import 'package:code_zero/app/modules/markdown/main_markdown/main_markdown_controller.dart';
import 'package:code_zero/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:code_zero/app/modules/markdown/menu/navigation_item.dart';
import 'package:code_zero/app/modules/markdown/router.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_detector/platform_detector.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu extends StatelessWidget {
  final bool isCollapsed;
  final VoidCallback? onCollapsed;
  final VoidCallback? onUnCollapsed;
  final Function(MenuInfo info)? onSelect;
  final String router;
  final List<MenuInfo>? menuInfos;
  final String? selectName;

  const Menu({
    Key? key,
    this.isCollapsed = false,
    this.onCollapsed,
    this.onUnCollapsed,
    this.onSelect,
    this.router = '',
    this.menuInfos,
    this.selectName = '',
  }) : super(key: key);

  bool get isMobile => PlatformDetector.isAllMobile;

  @override
  Widget build(BuildContext context) {
    lLog('MTMTMT Menu.build ${menuInfos?.length} ${selectName}');
    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: Column(
        children: [
          buildMenuButton(),
          Expanded(
            child: ListView(
              children: menuInfos!.map((e) => buildMenu(e.name, e.path, onSelect)).toList()/*[

                *//*NavItem(
                  title: 'README.md',
                  trailing: '📚',
                  isCollapsed: isCollapsed,
                  isSelected: isSelected(RouterEnum.readme),
                  onTap: () {
                    // GoRouter.of(context).go(RouterEnum.readme.path);
                    if (isMobile) Navigator.of(context).pop();
                  },
                ),
                NavItem(
                  title: 'Markdown Editor',
                  trailing: '📝',
                  isCollapsed: isCollapsed,
                  isSelected: isSelected(RouterEnum.editor),
                  onTap: () {
                    print(RouterEnum.editor.path);
                    // GoRouter.of(context).go(RouterEnum.editor.path);
                    if (isMobile) Navigator.of(context).pop();
                  },
                ),
                NavItem(
                  title: 'Sample: Latex',
                  trailing: '🧮',
                  isSelected: isSelected(RouterEnum.sample_latex),
                  isCollapsed: isCollapsed,
                  onTap: () {
                    // GoRouter.of(context).go(RouterEnum.sample_latex.path);
                    if (isMobile) Navigator.of(context).pop();
                  },
                ),
                NavItem(
                  title: 'Sample: Html',
                  trailing: '🌐',
                  isSelected: isSelected(RouterEnum.sample_html),
                  isCollapsed: isCollapsed,
                  onTap: () {
                    // GoRouter.of(context).go(RouterEnum.sample_html.path);
                    if (isMobile) Navigator.of(context).pop();
                  },
                ),*//*
              ]*/,
            ),
          ),
          if (!isMobile)
            Column(
              children: [
                // buildThemeButton(context),
                // buildLanguageButton(),
              ],
            )
        ],
      ),
    );
  }

  Widget buildMenu(title, path, Function(MenuInfo info)? select) {
    return NavItem(
      title: title,
      isSelected: isSelected(title),
      isCollapsed: isCollapsed,
      onTap: () {
        select?.call(MenuInfo(title, path));
      },
    );
  }

  Widget buildMenuButton() {
    if (isCollapsed) {
      return SizedBox(
        height: 48,
        child: InkWell(
            onTap: onUnCollapsed,
            child: Icon(Icons.keyboard_double_arrow_right)),
      );
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        children: [
          FlutterLogo(),
          Expanded(child: Center(child: InkWell(
              onTap: () {
                openFilePicker();
              },
              child: Text('Markdown', style: TextStyle(fontWeight: FontWeight.bold))))),
          InkWell(
            child: Icon(Icons.keyboard_double_arrow_left),
            onTap: onCollapsed,
          )
        ],
      ),
    );
  }

  void openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['md'],
      );
      if (result != null) {
        var filePath = result.files.single.path ?? "";
        var fileName = filePath.substring(
            filePath.lastIndexOf("/") + 1, filePath.lastIndexOf("."));
        File file = File(filePath);
        print('MTMTMT  ${fileName} ');
        var inputText = await file.readAsString();
      }
    } catch (e) {
    }
  }


/*
  Widget buildThemeButton(BuildContext context) {
    if (!isCollapsed) {
      return TextButton.icon(
          onPressed: () => rootStore.dispatch(new ChangeThemeEvent()),
          icon: Icon(
            isDark ? Icons.brightness_5_outlined : Icons.brightness_2_outlined,
            size: 14,
          ),
          label: Text(isDark ? 'Light' : 'Dark'));
    }
    return TextButton(
        onPressed: () => rootStore.dispatch(new ChangeThemeEvent()),
        child: Icon(
          isDark ? Icons.brightness_5_outlined : Icons.brightness_2_outlined,
          size: 14,
        ));
  }
*/

/*
  Widget buildLanguageButton() {
    return StoreConnector<RootState, String>(
        converter: ChangeRouter.storeConverter,
        builder: (context, state) {
          if (state == RouterEnum.editor.path) return Container();
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: TextButton(
              onPressed: () {
                rootStore.dispatch(new ChangeLanguage());
              },
              child: isCollapsed
                  ? Text(rootStore.state.language == 'en' ? '中' : 'En')
                  : Text(rootStore.state.language == 'en' ? '简中' : 'English'),
            ),
          );
        });
  }
*/

  bool isSelected(String routerEnum) => selectName == routerEnum;
}

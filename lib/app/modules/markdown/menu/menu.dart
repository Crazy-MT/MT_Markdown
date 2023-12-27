import 'package:code_zero/app/modules/markdown/main_markdown/main_markdown_controller.dart';
import 'package:code_zero/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:code_zero/app/modules/markdown/menu/navigation_item.dart';
import 'package:code_zero/utils/log_utils.dart';
import 'package:code_zero/utils/platform_detector/platform_detector.dart';
import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: Column(
        children: [
          // buildMenuButton(),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                // menuInfos!.map((e) => buildMenu(e.name, e.path, onSelect)).toList()
                return buildMenu(
                    menuInfos?[index].name, menuInfos?[index].path, menuInfos?[index].lastModified, onSelect);
              },
              separatorBuilder: (_, __) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Divider(
                    height: 2,
                    thickness: 0.6,
                  ),
                );
              },
              itemCount: menuInfos?.length ?? 0
              /*[

                */ /*NavItem(
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
                ),*/ /*
              ]*/
              ,
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

  Widget buildMenu(title, path, lastModified, Function(MenuInfo info)? select) {
    return ContextMenuArea(
      builder: (context) => [
        ListTile(
          title: Text('删除'),
          onTap: () {
            lLog('MTMTMT Menu.buildMenu ${title} ');
            Get.find<MainMarkdownController>().removeThis(MenuInfo(title, path, lastModified));
          },
        )
      ],
      child: NavItem(
        title: title,
        isSelected: isSelected(title),
        isCollapsed: isCollapsed,
        lastModified: lastModified,
        onTap: () {
          select?.call(MenuInfo(title, path, lastModified));
        },
      ),
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
          Expanded(
              child: Center(
                  child: Text('Markdown',
                      style: TextStyle(fontWeight: FontWeight.bold)))),
          Visibility(
            visible: false,
            child: InkWell(
              child: Icon(Icons.keyboard_double_arrow_left),
              onTap: onCollapsed,
            ),
          )
        ],
      ),
    );
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

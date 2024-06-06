import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:mt_markdown/app/modules/markdown/main_markdown/main_markdown_controller.dart';
import 'package:mt_markdown/app/modules/markdown/menu/bean/MenuInfo.dart';
import 'package:mt_markdown/common/common.dart';
import 'package:mt_markdown/common/sp_const.dart';
import 'package:mt_markdown/utils/platform_utils.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'utils/log_utils.dart';

void main() {
  // runZonedGuarded(() {
  if (PlatformUtils.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,

        ///这是设置状态栏的图标和字体的颜色
        ///Brightness.light  一般都是显示为白色
        ///Brightness.dark 一般都是显示为黑色
        statusBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  runApp(App());

  doWhenWindowReady(() {
    const initialSize = Size(1280, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
  // }, (error, stackTrace) {
  //   errorLog(error.toString());
  // });
}
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  List<String>? selectInfo;

  @override
  void initState() {
    super.initState();
    _getMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformMenuBar(
      menus: <PlatformMenuItem>[
        PlatformMenu(
          label: 'Markdown',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: '关于',
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.about);
                  },
                ),
              ],
            ),
            if (PlatformProvidedMenuItem.hasMenu(
                PlatformProvidedMenuItemType.quit))
              const PlatformProvidedMenuItem(
                  type: PlatformProvidedMenuItemType.quit),
          ],
        ),
        PlatformMenu(
          label: '文件',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: '新建',
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.about);
                    Get.find<MainMarkdownController>().newPage();
                  },
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyN, meta: true),
                ),
                PlatformMenuItem(
                  onSelected: () {
                    openFilePicker();
                  },
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyO, meta: true),
                  label: '打开',
                ),
                PlatformMenuItem(
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.showMessage);
                    eventBus.fire("save");
                  },
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyS, meta: true),
                  // shortcut: const CharacterActivator('s'),
                  label: '保存',
                ),
/*
                PlatformMenuItem(
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.showMessage);
                    eventBus.fire("search");
                  },
                  shortcut: const SingleActivator(LogicalKeyboardKey.keyF, meta: true),
                  // shortcut: const CharacterActivator('s'),
                  label: '查找',
                )
*/
              ],
            ),
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenu(
                  label: '最近',
                  menus: selectInfo?.map((element) {
                    return PlatformMenuItem(
                      label: MenuInfo.fromJson(json.decode(element)).name ?? "",
                      // shortcut: const SingleActivator(LogicalKeyboardKey.digit1, meta: true),
                      onSelected: () {
                        // Handle the item selection here
                      },
                    );
                  }).toList() ?? [] /*<PlatformMenuItem>[
                    PlatformMenuItem(
                      label: 'I am not throwing away my shot.',
                      shortcut: const SingleActivator(LogicalKeyboardKey.digit1,
                          meta: true),
                      onSelected: () {
                        // setState(() {
                        //   _message = 'I am not throwing away my shot.';
                        // });
                      },
                    ),
                    PlatformMenuItem(
                      label:
                      "There's a million things I haven't done, but just you wait.",
                      shortcut: const SingleActivator(LogicalKeyboardKey.digit2,
                          meta: true),
                      onSelected: () {
                        // setState(() {
                        //   _message =
                        //   "There's a million things I haven't done, but just you wait.";
                        // });
                      },
                    ),
                  ],*/
                ),
              ],
            ),
          ],
        ),
/*        PlatformMenu(
          label: '视图',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: '编辑',
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.about);
                  },
                ),
                PlatformMenuItem(
                  label: '预览',
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.about);
                  },
                )
              ],
            ),
          ],
        ),*/
        PlatformMenu(
          label: '帮助',
          menus: <PlatformMenuItem>[
            PlatformMenuItemGroup(
              members: <PlatformMenuItem>[
                PlatformMenuItem(
                  label: 'Github',
                  onSelected: () {
                    // _handleMenuSelection(MenuSelection.about);
                  },
                ),
              ],
            ),
          ],
        )
      ],
      child: ScreenUtilInit(
        scaleByHeight: PlatformUtils.isWeb,
        designSize: const Size(720, 1080),
        builder: (context, widget) {
          return OKToast(
            dismissOtherOnShow: true,
            child: GetMaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                RefreshLocalizations.delegate
              ],
              supportedLocales: [
                Locale('zh', ''),
                Locale('en', ''),
              ],
              theme: ThemeData(
                splashColor: Colors.transparent, // 点击时的高亮效果设置为透明
                highlightColor: Colors.transparent, // 长按时的扩散效果设置为透明
                scaffoldBackgroundColor: Colors.white,
              ),
              debugShowCheckedModeBanner: false,
              builder: EasyLoading.init(
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    child: GestureDetector(
                      onTap: () {
                        hideKeyboard(context);
                      },
                      child: child,
                    ),
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  );
                },
              ),
              defaultTransition: Transition.rightToLeft,
              title: "MT-Markdown",
              initialRoute: RoutesID.MAIN_MARKDOWN_PAGE,
              getPages: AppPages.routes,
            ),
          );
        },
      ),
    );
  }

  void _getMenuItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    selectInfo = prefs.getStringList(SpConst.SELECT_INFO);
    setState(() {

    });
    /*if (selectInfo != null) {
      return selectInfo!.map((element) {
        return PlatformMenuItem(
          label: element,
          shortcut: const SingleActivator(LogicalKeyboardKey.digit1, meta: true),
          onSelected: () {
            // Handle the item selection here
          },
        );
      }).toList();
    } else {
      return [];
    }*/
  }
}

void openFilePicker() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['md'],
    );
    if (result != null) {
      var filePath = result.files.single.path ?? "";
      XFile file = XFile(filePath);
      lLog('MTMTMT openFilePicker ${filePath} ${result}');

      Get.find<MainMarkdownController>().addFile(file);
    }
  } catch (e) {}
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

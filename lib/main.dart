import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'dart:math';

import 'package:code_zero/utils/platform_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'network/l_request.dart';
import 'utils/log_utils.dart';
import 'package:flutter_ume/flutter_ume.dart'; // UME 框架
import 'package:flutter_ume_kit_ui/flutter_ume_kit_ui.dart'; // UI 插件包
import 'package:flutter_ume_kit_perf/flutter_ume_kit_perf.dart'; // 性能插件包
import 'package:flutter_ume_kit_show_code/flutter_ume_kit_show_code.dart'; // 代码查看插件包
import 'package:flutter_ume_kit_device/flutter_ume_kit_device.dart'; // 设备信息插件包
import 'package:flutter_ume_kit_console/flutter_ume_kit_console.dart'; // debugPrint 插件包
import 'package:flutter_ume_kit_dio/flutter_ume_kit_dio.dart'; // Dio 网络请求调试工具

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
    if (kDebugMode) {
      PluginManager.instance
        ..register(DioInspector(dio: LRequest.dio))
        ..register(WidgetInfoInspector())
        ..register(WidgetDetailInspector())
        ..register(ColorSucker())
        ..register(AlignRuler())
        ..register(ColorPicker())
        ..register(TouchIndicator())
        ..register(Performance())
        ..register(ShowCode())
        ..register(MemoryInfoPage())
        ..register(CpuInfoPage())
        ..register(DeviceInfoPanel())
        ..register(Console());
      // flutter_ume 0.3.0 版本之后
      runApp(UMEWidget(child: AppContent(App()), enable: true));
    } else {
      runApp(AppContent(App()));
    }
  // }, (error, stackTrace) {
  //   errorLog(error.toString());
  // });
}

class AppContent extends StatefulWidget{
  Widget content;
  AppContent(this.content);
  @override
  State<StatefulWidget> createState() {
    return _AppContent();
  }
}

class _AppContent extends State<AppContent>{

  @override
  Widget build(BuildContext context) {
    lLog('MTMTMT _AppContent.build ${window.innerHeight?.toDouble()} ${(window.innerHeight?.toDouble() ?? 0) * 375 / (812)} ');
    return FittedBox(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      child: Container(
        // width: max(window.innerWidth?.toDouble() ?? 0, 1280),
        // height: max(window.innerHeight?.toDouble() ?? 0, 720),
        width: (window.innerHeight?.toDouble() ?? 0) * 375 / (812),
        height: window.innerHeight?.toDouble() ?? 0,
        child: widget.content,
      ),
    );
  }

  @override
  void initState() {
    window.onResize.listen((event) {
      setState(() {
        lLog('MTMTMT _AppContent.initState ${window.innerWidth} ${window.innerHeight}');
      });
    });
  }
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      widthFactor: 1,
      heightFactor: 1,
      child: ScreenUtilInit(
        scaleWithWidth: false,
        designSize: const Size(375, 812),
        // useInheritedMediaQuery: true,
        rebuildFactor: (old, newData) {
          lLog('MTMTMT App.build old ${old.size.width} ${old.size.height}');
          lLog('MTMTMT App.build newData ${newData.size.width} ${newData.size.height}');
          return true;
        },
        builder: (context, widget) {
          return OKToast(
            dismissOtherOnShow: true,
            child: Center(
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
                title: "亿翠珠宝商城",
                initialRoute: RoutesID.SPLASH_PAGE,
                getPages: AppPages.routes,
              ),
            ),
          );
        },
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

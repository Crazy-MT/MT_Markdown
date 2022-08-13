import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'utils/log_utils.dart';

void main() {
  runZonedGuarded(() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style = const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,

          ///这是设置状态栏的图标和字体的颜色
          ///Brightness.light  一般都是显示为白色
          ///Brightness.dark 一般都是显示为黑色
          statusBarIconBrightness: Brightness.light);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
    runApp(const App());
  }, (error, stackTrace) {
    errorLog(error.toString());
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, widget) {
        return OKToast(
          dismissOtherOnShow: true,
          child: GetMaterialApp(
            theme: ThemeData(
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
            title: "CodeZero",
            initialRoute: RoutesID.SPLASH_PAGE,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

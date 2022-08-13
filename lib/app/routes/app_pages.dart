import 'package:get/get.dart';

import '../modules/others/splash/splash_binding.dart';
import '../modules/others/splash/splash_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = _routes;

  static final List<GetPage> _routes = [
    // splash
    GetPage(
      name: RoutesID.SPLASH_PAGE,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}

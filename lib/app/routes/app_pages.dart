import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/others/login/login_binding.dart';
import '../modules/others/login/login_page.dart';
import '../modules/others/splash/splash_binding.dart';
import '../modules/others/splash/splash_page.dart';
import 'app_routes.dart';
import '../modules/main_tab/main_tab_binding.dart';
import '../modules/main_tab/main_tab_page.dart';
import '../modules/mine/mine_binding.dart';
import '../modules/mine/mine_page.dart';
import '../modules/shopping_cart/shopping_cart_binding.dart';
import '../modules/shopping_cart/shopping_cart_page.dart';
import '../modules/snap_up/snap_up_binding.dart';
import '../modules/snap_up/snap_up_page.dart';

class AppPages {
  AppPages._();

  static final routes = _routes;

  static final List<GetPage> _routes = [
    // snap_up
    GetPage(
      name: RoutesID.SNAP_UP_PAGE,
      page: () => const SnapUpPage(),
      binding: SnapUpBinding(),
    ),

    // shopping_cart
    GetPage(
      name: RoutesID.SHOPPING_CART_PAGE,
      page: () => const ShoppingCartPage(),
      binding: ShoppingCartBinding(),
    ),

    // mine
    GetPage(
      name: RoutesID.MINE_PAGE,
      page: () => const MinePage(),
      binding: MineBinding(),
    ),

    // main_tab
    GetPage(
      name: RoutesID.MAIN_TAB_PAGE,
      page: () => const MainTabPage(),
      binding: MainTabBinding(),
    ),

    // login
    GetPage(
      name: RoutesID.LOGIN_PAGE,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
      fullscreenDialog: true,
    ),

    // home
    GetPage(
      name: RoutesID.HOME_PAGE,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // splash
    GetPage(
      name: RoutesID.SPLASH_PAGE,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}

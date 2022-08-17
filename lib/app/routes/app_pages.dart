import 'package:get/get.dart';

import '../modules/home/category/category_binding.dart';
import '../modules/home/category/category_page.dart';
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
import '../modules/home/goods_detail/goods_detail_binding.dart';
import '../modules/home/goods_detail/goods_detail_page.dart';
import '../modules/mine/setting/setting_binding.dart';
import '../modules/mine/setting/setting_page.dart';
import '../modules/mine/setting/c2c_risk/c2c_risk_binding.dart';
import '../modules/mine/setting/c2c_risk/c2c_risk_page.dart';
import '../modules/mine/setting/user_information/user_information_binding.dart';
import '../modules/mine/setting/user_information/user_information_page.dart';
import '../modules/mine/message/message_binding.dart';
import '../modules/mine/message/message_page.dart';
import '../modules/mine/wallet/wallet_binding.dart';
import '../modules/mine/wallet/wallet_page.dart';

class AppPages {
  AppPages._();

  static final routes = _routes;

  static final List<GetPage> _routes = [
    // wallet
    GetPage(
      name: RoutesID.WALLET_PAGE,
      page: () => const WalletPage(),
      binding: WalletBinding(),
    ),

    // message
    GetPage(
      name: RoutesID.MESSAGE_PAGE,
      page: () => const MessagePage(),
      binding: MessageBinding(),
    ),

    // user_information
    GetPage(
      name: RoutesID.USER_INFORMATION_PAGE,
      page: () => const UserInformationPage(),
      binding: UserInformationBinding(),
    ),

    // c2c_risk
    GetPage(
      name: RoutesID.C2C_RISK_PAGE,
      page: () => const C2cRiskPage(),
      binding: C2cRiskBinding(),
    ),

    // setting
    GetPage(
      name: RoutesID.SETTING_PAGE,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    // category
    GetPage(
      name: RoutesID.CATEGORY_PAGE,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
    ),

    // goods_detail
    GetPage(
      name: RoutesID.GOODS_DETAIL_PAGE,
      page: () => const GoodsDetailPage(),
      binding: GoodsDetailBinding(),
    ),

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

import 'package:code_zero/app/middleware/auth_middleware.dart';
import 'package:code_zero/app/modules/mine/buyer_order/buyer_order_binding.dart';
import 'package:code_zero/app/modules/mine/buyer_order/buyer_order_page.dart';
import 'package:code_zero/app/modules/mine/seller_order/seller_order_page.dart';
import 'package:code_zero/app/modules/others/local_webview/local_webview_binding.dart';
import 'package:code_zero/app/modules/others/local_webview/local_webview_page.dart';
import 'package:get/get.dart';

import '../modules/home/category/category_binding.dart';
import '../modules/home/category/category_page.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_page.dart';
import '../modules/mine/collection/collection_binding.dart';
import '../modules/mine/collection/collection_page.dart';
import '../modules/mine/seller_order/seller_order_binding.dart';
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
import '../modules/mine/income_list/income_list_binding.dart';
import '../modules/mine/income_list/income_list_page.dart';
import '../modules/mine/wallet/transactions/transactions_binding.dart';
import '../modules/mine/wallet/transactions/transactions_page.dart';
import '../modules/mine/order/order_binding.dart';
import '../modules/mine/order/order_page.dart';
import '../modules/others/login/reset_password/reset_password_binding.dart';
import '../modules/others/login/reset_password/reset_password_page.dart';
import '../modules/mine/wallet/drawing/drawing_binding.dart';
import '../modules/mine/wallet/drawing/drawing_page.dart';
import '../modules/mine/collection_settings/collection_settings_binding.dart';
import '../modules/mine/collection_settings/collection_settings_page.dart';
import '../modules/mine/distribution/distribution_binding.dart';
import '../modules/mine/distribution/distribution_page.dart';
import '../modules/mine/distribution/my_commission/my_commission_binding.dart';
import '../modules/mine/distribution/my_commission/my_commission_page.dart';
import '../modules/mine/bind_recommend/bind_recommend_binding.dart';
import '../modules/mine/bind_recommend/bind_recommend_page.dart';
import '../modules/mine/distribution/fans_order/fans_order_binding.dart';
import '../modules/mine/distribution/fans_order/fans_order_page.dart';
import '../modules/mine/address_manage/address_manage_binding.dart';
import '../modules/mine/address_manage/address_manage_page.dart';
import '../modules/mine/address_manage/address_edit/address_edit_binding.dart';
import '../modules/mine/address_manage/address_edit/address_edit_page.dart';
import '../modules/mine/distribution/my_fans/my_fans_binding.dart';
import '../modules/mine/distribution/my_fans/my_fans_page.dart';
import '../modules/home/submit_order/submit_order_binding.dart';
import '../modules/home/submit_order/submit_order_page.dart';
import '../modules/mine/invite/invite_binding.dart';
import '../modules/mine/invite/invite_page.dart';
import '../modules/others/local_html/local_html_binding.dart';
import '../modules/others/local_html/local_html_page.dart';
import '../modules/others/signature/signature_binding.dart';
import '../modules/others/signature/signature_page.dart';
import '../modules/snap_up/snap_detail/snap_detail_binding.dart';
import '../modules/snap_up/snap_detail/snap_detail_page.dart';
import '../modules/mine/buyer_order/order_send_sell/order_send_sell_binding.dart';
import '../modules/mine/buyer_order/order_send_sell/order_send_sell_page.dart';
import '../modules/mine/buyer_order/order_detail/order_detail_binding.dart';
import '../modules/mine/buyer_order/order_detail/order_detail_page.dart';
import '../modules/snap_up/balance_rule/balance_rule_binding.dart';
import '../modules/snap_up/balance_rule/balance_rule_page.dart';
import '../modules/mine/complaint_feedback/complaint_feedback_binding.dart';
import '../modules/mine/complaint_feedback/complaint_feedback_page.dart';
import '../modules/mine/photo_view/photo_view_binding.dart';
import '../modules/mine/photo_view/photo_view_page.dart';
import '../modules/others/login/auth_check/auth_check_binding.dart';
import '../modules/others/login/auth_check/auth_check_page.dart';
import '../modules/mine/order/self_order_detail/self_order_detail_binding.dart';
import '../modules/mine/order/self_order_detail/self_order_detail_page.dart';

class AppPages {
  AppPages._();

  static final routes = _routes;

  static final List<GetPage> _routes = [
    // self_order_detail
    GetPage(
      name: RoutesID.SELF_ORDER_DETAIL_PAGE,
      page: () => const SelfOrderDetailPage(),
      binding: SelfOrderDetailBinding(),
    ),

    // auth_check
    GetPage(
      name: RoutesID.AUTH_CHECK_PAGE,
      page: () => const AuthCheckPage(),
      binding: AuthCheckBinding(),
    ),

    // photo_view
    GetPage(
      name: RoutesID.PHOTO_VIEW_PAGE,
      page: () => const PhotoViewPage(),
      binding: PhotoViewBinding(),
    ),

    // complaint_feedback
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.COMPLAINT_FEEDBACK_PAGE,
      page: () => const ComplaintFeedbackPage(),
      binding: ComplaintFeedbackBinding(),
    ),

    // balance_rule
    GetPage(
      name: RoutesID.BALANCE_RULE_PAGE,
      page: () => const BalanceRulePage(),
      binding: BalanceRuleBinding(),
    ),

    // order_detail
    GetPage(
      name: RoutesID.ORDER_DETAIL_PAGE,
      page: () => const OrderDetailPage(),
      binding: OrderDetailBinding(),
    ),

    // order_send_sell
    GetPage(
      name: RoutesID.ORDER_SEND_SELL_PAGE,
      page: () => const OrderSendSellPage(),
      binding: OrderSendSellBinding(),
    ),

    // signature 签名页
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.SIGNATURE_PAGE,
      page: () => const SignaturePage(),
      binding: SignatureBinding(),
    ),

    // local_html
    GetPage(
      name: RoutesID.LOCAL_HTML_PAGE,
      page: () => const LocalHtmlPage(),
      binding: LocalHtmlBinding(),
    ),
    GetPage(
      name: RoutesID.LOCAL_WEBVIEW_PAGE,
      page: () => const LocalWebViewPage(),
      binding: LocalWebViewBinding(),
    ),
    // snap_detail 某抢购场次列表页
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.SNAP_DETAIL_PAGE,
      page: () => const SnapDetailPage(),
      binding: SnapDetailBinding(),
    ),

    // invite 邀请好友
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.INVITE_PAGE,
      page: () => const InvitePage(),
      binding: InviteBinding(),
    ),

    // submit_order
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.SUBMIT_ORDER_PAGE,
      page: () => const SubmitOrderPage(),
      binding: SubmitOrderBinding(),
    ),

    // address_edit
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.ADDRESS_EDIT_PAGE,
      page: () => const AddressEditPage(),
      binding: AddressEditBinding(),
    ),

    // address_manage
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.ADDRESS_MANAGE_PAGE,
      page: () => const AddressManagePage(),
      binding: AddressManageBinding(),
    ),

    // my_fans
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.MY_FANS_PAGE,
      page: () => const MyFansPage(),
      binding: MyFansBinding(),
    ),

    // fans_order
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.FANS_ORDER_PAGE,
      page: () => const FansOrderPage(),
      binding: FansOrderBinding(),
    ),

    // bind_recommend
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.BIND_RECOMMEND_PAGE,
      page: () => const BindRecommendPage(),
      binding: BindRecommendBinding(),
    ),

    // my_commission
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.MY_COMMISSION_PAGE,
      page: () => const MyCommissionPage(),
      binding: MyCommissionBinding(),
    ),

    // 查看自己、并设置自己的收款信息
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.COLLECTION_SETTINGS_PAGE,
      page: () => const CollectionSettingsPage(),
      binding: CollectionSettingsBinding(),
    ),

    // 查看他人收款信息，只有查看没有编辑功能
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.COLLECTION_PAGE,
      page: () => const CollectionPage(),
      binding: CollectionBinding(),
    ),

    // drawing 余额提现
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.DRAWING_PAGE,
      page: () => const DrawingPage(),
      binding: DrawingBinding(),
    ),
    // distribution 团队中心
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.DISTRIBUTION_PAGE,
      page: () => const DistributionPage(),
      binding: DistributionBinding(),
    ),

    // reset_password
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.RESET_PASSWORD_PAGE,
      page: () => const ResetPasswordPage(),
      binding: ResetPasswordBinding(),
    ),

    // transactions 提现记录
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.TRANSACTIONS_PAGE,
      page: () => const TransactionsPage(),
      binding: TransactionsBinding(),
    ),

    // income_list 收益明细
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.INCOME_LIST_PAGE,
      page: () => const IncomeListPage(),
      binding: IncomeListBinding(),
    ),

    // 全部订单
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.ORDER_PAGE,
      page: () => const OrderPage(),
      binding: OrderBinding(),
    ),

    // wallet
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
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
      middlewares: [EnsureAuthMiddleware()],
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

    // 买方
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.BUYER_ORDER_PAGE,
      page: () => const BuyerOrderPage(),
      binding: BuyerOrderBinding(),
    ),

    // 卖方
    GetPage(
      middlewares: [EnsureAuthMiddleware()],
      name: RoutesID.SELLER_ORDER_PAGE,
      page: () => const SellerOrderPage(),
      binding: SellerOrderBinding(),
    ),
  ];
}

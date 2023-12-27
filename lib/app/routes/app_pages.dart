import 'package:get/get.dart';
import 'app_routes.dart';
import '../modules/markdown/main_markdown/main_markdown_binding.dart';
import '../modules/markdown/main_markdown/main_markdown_page.dart';

class AppPages {
  AppPages._();

  static final routes = _routes;

  static final List<GetPage> _routes = [
    // main_markdown
    GetPage(
      name: RoutesID.MAIN_MARKDOWN_PAGE,
      page: () => const MainMarkdownPage(),
      binding: MainMarkdownBinding(),
    ),
  ];
}

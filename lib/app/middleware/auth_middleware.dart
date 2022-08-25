import 'package:code_zero/app/routes/app_routes.dart';
import 'package:code_zero/common/user_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';

import '../routes/app_pages.dart';

class EnsureAuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('MTMTMT EnsureAuthMiddleware.redirect ${route} ');
    if (userHelper.userToken.isEmpty) {
      return const RouteSettings(name: RoutesID.LOGIN_PAGE);
    } else {
      return null;
    }
  }
}

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('MTMTMT EnsureAuthMiddleware.redirect ${route} ');
    if (userHelper.userToken.isNotEmpty) {
      return const RouteSettings(name: RoutesID.LOGIN_PAGE);
    } else {
      return null;
    }
  }
}

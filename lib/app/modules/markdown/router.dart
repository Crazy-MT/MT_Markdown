import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

enum RouterEnum {
  readme,
  editor,
  sample_latex,
  sample_html,
}

extension RoutePath on RouterEnum {
  String get path => '/$name';
}

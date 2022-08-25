import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'page_empty_widget.dart';
import 'page_error_widget.dart';
import 'page_loading_widget.dart';

class FTStatusPage extends StatelessWidget {
  final FTStatusPageType type;
  final WidgetBuilder builder;
  final Function? retryMethod;
  final String? errorMsg;
  final Widget? loadingWidget, emptyWidget, errorWidget;

  ///Copy from SmartRefresher
  final Widget? header;
  final Widget? footer;
  final bool enablePullUp;
  final bool enableTwoLevel;
  final bool enablePullDown;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final OnTwoLevel? onTwoLevel;
  final RefreshController? controller;
  final Axis? scrollDirection;
  final bool? reverse;
  final ScrollController? scrollController;
  final bool? primary;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior? dragStartBehavior;

  const FTStatusPage(
      {Key? key,
      this.type = FTStatusPageType.success,
      required this.builder,
      this.loadingWidget,
      this.emptyWidget,
      this.errorWidget,
      this.retryMethod,
      this.errorMsg,

      ///Copy from SmartRefresher
      this.header,
      this.footer = const ClassicFooter(noDataText: "没有更多数据", loadingText: "加载中…", failedText: "加载失败",),
      this.enablePullDown = false,
      this.enablePullUp = false,
      this.enableTwoLevel = false,
      this.onRefresh,
      this.onLoading,
      this.onTwoLevel,
      this.dragStartBehavior,
      this.primary,
      this.cacheExtent,
      this.semanticChildCount,
      this.reverse,
      this.physics,
      this.scrollDirection,
      this.scrollController,
      this.controller})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller ?? RefreshController(),
      header: header,
      footer: footer,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      enableTwoLevel: enableTwoLevel,
      onRefresh: onRefresh,
      onLoading: onLoading,
      onTwoLevel: onTwoLevel,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      scrollController: scrollController,
      child: _getWidget(),
    );
  }

  Widget _getWidget() {
    switch (type) {
      case FTStatusPageType.loading:
        return loadingWidget ?? const PageLoadingWidget();
      case FTStatusPageType.empty:
        return emptyWidget ?? const PageEmptyWidget();
      case FTStatusPageType.error:
        return errorWidget ??
            PageErrorWidget(
              retryMethod: retryMethod,
              error: (errorMsg == null || errorMsg!.isEmpty) ? "unknown error" : errorMsg,
            );
      case FTStatusPageType.success:
        Widget _w = builder(Get.context!);
        return _w;
    }
  }
}

enum FTStatusPageType {
  loading,
  empty,
  error,
  success,
}

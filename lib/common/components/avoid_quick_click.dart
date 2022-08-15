import 'package:flutter/material.dart';

class SafeClickGesture extends StatefulWidget {
  final Widget? child;
  final Function? onTap;
  final int milliseconds;
  final String trackClickTag;

  SafeClickGesture({Key? key, this.onTap, this.milliseconds = 1000, this.child, this.trackClickTag = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SafeClickGesture();
}

class _SafeClickGesture extends State<SafeClickGesture> {
  bool _isCan = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.child,
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.onTap != null && _isCan) {
          widget.onTap!();
          _isCan = false;
          // milliseconds毫秒内 不能多次点击
          Future.delayed(Duration(milliseconds: widget.milliseconds), () {
            _isCan = true;
          });
        }
      },
    );
  }
}

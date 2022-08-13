import 'package:flutter/material.dart';

///用来防止多次触发点击事件的Widget
class SafeTapWidget extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final int milliseconds;
  final String trackClickTag;

  const SafeTapWidget({Key? key, this.onTap, this.milliseconds = 300, required this.child, this.trackClickTag = ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SafeTapState();
}

class _SafeTapState extends State<SafeTapWidget> {
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
          Future.delayed(Duration(milliseconds: widget.milliseconds), () {
            _isCan = true;
          });
        }
      },
    );
  }
}

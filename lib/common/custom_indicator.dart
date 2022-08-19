import 'package:flutter/material.dart';

class CustomIndicator extends Decoration {
  const CustomIndicator(
      {this.width = 14.35,
      this.height = 3.35,
      this.color = const Color(0xFF5A94FD),
      this.strokeCap = StrokeCap.round});

  BorderSide get borderSide =>
      BorderSide(width: this.height, color: this.color);
  final double width;
  final double height;
  final Color color;
  final StrokeCap strokeCap;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, EdgeInsets.zero, t) ??
            EdgeInsets.zero,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(EdgeInsets.zero, b.insets, t) ??
            EdgeInsets.zero,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged, this.strokeCap);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator =
        EdgeInsets.zero.resolve(textDirection).deflateRect(rect);

    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - this.width / 2,
        indicator.bottom - borderSide.width, this.width, borderSide.width);
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback? onChanged, this.strokeCap)
      : super(onChanged);

  final CustomIndicator decoration;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & (configuration.size ?? Size.zero);
    final TextDirection textDirection =
        configuration.textDirection ?? TextDirection.ltr;
    final Rect indicator = decoration
        ._indicatorRectFor(rect, textDirection)
        .deflate(decoration.borderSide.width / 2.0);
    final Paint paint = decoration.borderSide.toPaint()
      ..strokeCap = this.strokeCap;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}

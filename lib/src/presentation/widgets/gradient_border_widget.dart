import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

final class GradientBorderWidget extends StatelessWidget {
  final double strokeWidth;
  final double radius;
  final Gradient gradient;
  final Widget ?child;

  const GradientBorderWidget({
    this.strokeWidth = BorderSize.border01,
    this.radius = BorderRadiusSize.borderRadius05,
    required this.gradient,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GradientBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
        gradient: gradient,
      ),
      child: child,
    );
  }
}

final class _GradientBorderPainter extends CustomPainter {
  final double radius;
  final double strokeWidth;
  final Gradient gradient;

  const _GradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    // create outer rectangle equals size
    Rect outerRect = Offset.zero & size;
    var outerRRect =
        RRect.fromRectAndRadius(outerRect, Radius.circular(radius));

    // create inner rectangle smaller by strokeWidth
    Rect innerRect = Rect.fromLTWH(strokeWidth, strokeWidth,
        size.width - strokeWidth * 2, size.height - strokeWidth * 2);
    var innerRRect = RRect.fromRectAndRadius(
        innerRect, Radius.circular(radius - strokeWidth));

    // apply gradient shader
    paint.shader = gradient.createShader(outerRect);

    // create difference between outer and inner paths and draw it
    Path path1 = Path()..addRRect(outerRRect);
    Path path2 = Path()..addRRect(innerRRect);
    var path = Path.combine(PathOperation.difference, path1, path2);
    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

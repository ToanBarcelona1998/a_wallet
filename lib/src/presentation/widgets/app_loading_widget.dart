import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

const double _kMinCircularProgressIndicatorSize = BoxSize.boxSize04;
const int _kIndeterminateCircularDuration = 1333 * 2222;

class AppLoadingWidget extends StatefulWidget {
  final AppTheme appTheme;

  const AppLoadingWidget({
    required this.appTheme,
    super.key,
  });

  @override
  State<AppLoadingWidget> createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
      reverseDuration: const Duration(
        milliseconds: 1200,
      ),
    );
    _animation = ColorTween(
      begin: widget.appTheme.utilityBrand300,
      end: widget.appTheme.utilityIndigo500,
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomCircularProgressIndicator(
      valueColor: _animation,
      strokeAlign: BoxSize.boxSize02,
      strokeWidth: BoxSize.boxSizeIndicator,
    );
  }
}

/// region clone material circular progress indicator
final class CustomCircularProgressIndicator extends ProgressIndicator {
  /// Creates a circular progress indicator.
  ///
  /// {@macro flutter.material.ProgressIndicator.ProgressIndicator}
  const CustomCircularProgressIndicator({
    super.key,
    super.value,
    super.backgroundColor,
    super.color,
    super.valueColor,
    this.strokeWidth = 4.0,
    this.strokeAlign = strokeAlignCenter,
    super.semanticsLabel,
    super.semanticsValue,
    this.strokeCap,
  });

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The relative position of the stroke on a [CustomCircularProgressIndicator].
  ///
  /// Values typically range from -1.0 ([strokeAlignInside], inside stroke)
  /// to 1.0 ([strokeAlignOutside], outside stroke),
  /// without any bound constraints (e.g., a value of -2.0 is not typical, but allowed).
  /// A value of 0 ([strokeAlignCenter], default) will center the border
  /// on the edge of the widget.
  final double strokeAlign;

  /// The progress indicator's line ending.
  ///
  /// This determines the shape of the stroke ends of the progress indicator.
  /// By default, [strokeCap] is null.
  /// When [value] is null (indeterminate), the stroke ends are set to
  /// [StrokeCap.square]. When [value] is not null, the stroke
  /// ends are set to [StrokeCap.butt].
  ///
  /// Setting [strokeCap] to [StrokeCap.round] will result in a rounded end.
  /// Setting [strokeCap] to [StrokeCap.butt] with [value] == null will result
  /// in a slightly different indeterminate animation; the indicator completely
  /// disappears and reappears on its minimum value.
  /// Setting [strokeCap] to [StrokeCap.square] with [value] != null will
  /// result in a different display of [value]. The indicator will start
  /// drawing from slightly less than the start, and end slightly after
  /// the end. This will produce an alternative result, as the
  /// default behavior, for example, that a [value] of 0.5 starts at 90 degrees
  /// and ends at 270 degrees. With [StrokeCap.square], it could start 85
  /// degrees and end at 275 degrees.
  final StrokeCap? strokeCap;

  /// The indicator stroke is drawn fully inside of the indicator path.
  ///
  /// This is a constant for use with [strokeAlign].
  static const double strokeAlignInside = -1.0;

  /// The indicator stroke is drawn on the center of the indicator path,
  /// with half of the [strokeWidth] on the inside, and the other half
  /// on the outside of the path.
  ///
  /// This is a constant for use with [strokeAlign].
  ///
  /// This is the default value for [strokeAlign].
  static const double strokeAlignCenter = 0.0;

  /// The indicator stroke is drawn on the outside of the indicator path.
  ///
  /// This is a constant for use with [strokeAlign].
  static const double strokeAlignOutside = 1.0;

  Color _getValueColor(BuildContext context, {Color? defaultColor}) {
    return valueColor?.value ??
        color ??
        ProgressIndicatorTheme.of(context).color ??
        defaultColor ??
        Theme.of(context).colorScheme.primary;
  }

  Widget _buildSemanticsWrapper({
    required BuildContext context,
    required Widget child,
  }) {
    String? expandedSemanticsValue = semanticsValue;
    if (value != null) {
      expandedSemanticsValue ??= '${(value! * 100).round()}%';
    }
    return Semantics(
      label: semanticsLabel,
      value: expandedSemanticsValue,
      child: child,
    );
  }

  @override
  State<CustomCircularProgressIndicator> createState() =>
      _CustomCircularProgressIndicatorState();
}

final class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  static const int _pathCount = _kIndeterminateCircularDuration ~/ 1333;
  static const int _rotationCount = _kIndeterminateCircularDuration ~/ 2222;

  static final Animatable<double> _strokeHeadTween = CurveTween(
    curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _strokeTailTween = CurveTween(
    curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
  ).chain(CurveTween(
    curve: const SawTooth(_pathCount),
  ));
  static final Animatable<double> _offsetTween =
      CurveTween(curve: const SawTooth(_pathCount));
  static final Animatable<double> _rotationTween =
      CurveTween(curve: const SawTooth(_rotationCount));

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );
    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CustomCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating) {
      _controller.repeat();
    } else if (widget.value != null && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildMaterialIndicator(BuildContext context, double headValue,
      double tailValue, double offsetValue, double rotationValue) {
    final ProgressIndicatorThemeData defaults = Theme.of(context).useMaterial3
        ? _CircularProgressIndicatorDefaultsM3(context)
        : _CircularProgressIndicatorDefaultsM2(context);
    final Color? trackColor = widget.backgroundColor ??
        ProgressIndicatorTheme.of(context).circularTrackColor;

    return widget._buildSemanticsWrapper(
      context: context,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: _kMinCircularProgressIndicatorSize,
          minHeight: _kMinCircularProgressIndicatorSize,
        ),
        child: CustomPaint(
          painter: _CircularProgressIndicatorPainter(
            backgroundColor: trackColor,
            valueColor:
                widget._getValueColor(context, defaultColor: defaults.color),
            value: widget.value,
            // may be null
            headValue: headValue,
            // remaining arguments are ignored if widget.value is not null
            tailValue: tailValue,
            offsetValue: offsetValue,
            rotationValue: rotationValue,
            strokeWidth: widget.strokeWidth,
            strokeAlign: widget.strokeAlign,
            strokeCap: widget.strokeCap,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimation() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return _buildMaterialIndicator(
          context,
          _strokeHeadTween.evaluate(_controller),
          _strokeTailTween.evaluate(_controller),
          _offsetTween.evaluate(_controller),
          _rotationTween.evaluate(_controller),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimation();
  }
}

final class _CircularProgressIndicatorPainter extends CustomPainter {
  _CircularProgressIndicatorPainter({
    this.backgroundColor,
    required this.valueColor,
    required this.value,
    required this.headValue,
    required this.tailValue,
    required this.offsetValue,
    required this.rotationValue,
    required this.strokeWidth,
    required this.strokeAlign,
    this.strokeCap,
  })  : arcStart = value != null
            ? _startAngle
            : _startAngle +
                tailValue * 3 / 2 * math.pi +
                rotationValue * math.pi * 2.0 +
                offsetValue * 0.5 * math.pi,
        arcSweep = value != null
            ? clampDouble(value, 0.0, 1.0) * _sweep
            : math.max(
                headValue * 3 / 2 * math.pi - tailValue * 3 / 2 * math.pi,
                _epsilon);

  final Color? backgroundColor;
  final Color valueColor;
  final double? value;
  final double headValue;
  final double tailValue;
  final double offsetValue;
  final double rotationValue;
  final double strokeWidth;
  final double strokeAlign;
  final double arcStart;
  final double arcSweep;
  final StrokeCap? strokeCap;

  static const double _twoPi = math.pi * 2.0;
  static const double _epsilon = .001;

  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _sweep = _twoPi - _epsilon;
  static const double _startAngle = -math.pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Use the negative operator as intended to keep the exposed constant value
    // as users are already familiar with.
    final double strokeOffset = strokeWidth / 2 * -strokeAlign;
    final Offset arcBaseOffset = Offset(strokeOffset, strokeOffset);
    final Size arcActualSize = Size(
      size.width - strokeOffset * 2,
      size.height - strokeOffset * 2,
    );

    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
        arcBaseOffset & arcActualSize,
        0,
        _sweep,
        false,
        backgroundPaint,
      );
    }

    if (value == null && strokeCap == null) {
      // Indeterminate
      paint.strokeCap = StrokeCap.square;
    } else {
      // Butt when determinate (value != null) && strokeCap == null;
      paint.strokeCap = strokeCap ?? StrokeCap.butt;
    }

    canvas.drawArc(
      arcBaseOffset & arcActualSize,
      -arcStart,
      -arcSweep,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressIndicatorPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.valueColor != valueColor ||
        oldPainter.value != value ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.offsetValue != offsetValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth ||
        oldPainter.strokeAlign != strokeAlign ||
        oldPainter.strokeCap != strokeCap;
  }
}

final class _CircularProgressIndicatorDefaultsM3 extends ProgressIndicatorThemeData {
  _CircularProgressIndicatorDefaultsM3(this.context);

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color get color => _colors.primary;
}

class _CircularProgressIndicatorDefaultsM2 extends ProgressIndicatorThemeData {
  _CircularProgressIndicatorDefaultsM2(this.context);

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color get color => _colors.primary;
}

///endregion

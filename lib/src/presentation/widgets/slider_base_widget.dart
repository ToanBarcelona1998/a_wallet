import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';

typedef OnSliderChange<T> = void Function(T value);

abstract class SliderBaseWidget<T> extends StatefulWidget {
  final double maxValue;
  final double minValue;
  final OnSliderChange? onChange;
  final T? value;
  final AppTheme appTheme;

  const SliderBaseWidget({
    required this.maxValue,
    required this.minValue,
    required this.appTheme,
    this.onChange,
    this.value,
    super.key,
  });

  @override
  State<StatefulWidget> createState() =>
      SliderBaseWidgetState<SliderBaseWidget, T>();
}

class SliderBaseWidgetState<R extends SliderBaseWidget, T> extends State<R> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, widget.appTheme);
  }

  late T startValue;

  T get getCurrent => startValue;

  OnSliderChange<T> get sliderChange => (value) {
    widget.onChange?.call(value);
    startValue = value;
    set();
  };

  OnSliderChange<T> get sliderChangeStart => (value) {
    startValue = value;
    widget.onChange?.call(getCurrent);
  };

  OnSliderChange<T> get sliderChangeEnd => (value) {
    startValue = value;
    widget.onChange?.call(getCurrent);
  };

  Widget builder(
      BuildContext context,
      AppTheme appTheme,
      ) =>
      throw UnimplementedError();

  void set() => setState(() {});
}

class CustomSingleSlider extends SliderBaseWidget<double> {
  const CustomSingleSlider({
    double max = 100,
    double min = 0,
    double? current,
    super.onChange,
    super.key,
    required super.appTheme,
  }) : super(
    maxValue: max,
    minValue: min,
    value: current,
  );

  @override
  State<StatefulWidget> createState() => _CustomSingleSliderState();
}

class _CustomSingleSliderState
    extends SliderBaseWidgetState<CustomSingleSlider, double> {

  @override
  void initState() {
    super.initState();
    startValue = widget.value ?? 0.0;
  }

  @override
  Widget builder(BuildContext context, AppTheme appTheme) {
    return SliderTheme(
      data: SliderThemeData(
        inactiveTrackColor: appTheme.utilityBrand50,
        activeTrackColor: appTheme.fgBrandPrimary,
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: _CustomTrackShape(),
      ),
      child: Slider(
        value: getCurrent,
        onChanged: sliderChange,
        onChangeEnd: sliderChangeEnd,
        onChangeStart: sliderChangeStart,
        activeColor: appTheme.bgBrandSolid,
        max: widget.maxValue,
        min: widget.minValue,
        inactiveColor: appTheme.utilityBrand50.withOpacity(
          0.16,
        ),
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

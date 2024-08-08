import 'dart:math';

import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get query => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);

  double get w => size.width;

  double get h => size.height;

  double get bodyHeight => h - kToolbarHeight - kBottomNavigationBarHeight;

  double get statusBar => query.padding.top;

  double get ratio => query.devicePixelRatio;

  bool get isTablet => w >= 600;

  double get cacheImageTarget => max(450, w);

  double get cacheIconTarget => min(80, w / 4);
}

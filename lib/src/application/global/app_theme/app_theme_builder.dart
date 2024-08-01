import 'cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeBuilder extends StatelessWidget {
  final Widget Function(AppTheme) builder;

  const AppThemeBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppThemeCubit, AppTheme , AppTheme>(
      selector: (state) => state,
      builder: (context, state) {
        return builder(state);
      },
    );
  }
}

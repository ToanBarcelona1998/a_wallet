import 'localization_manager.dart';
import 'package:flutter/material.dart';

class AppLocalizationProvider extends StatelessWidget {
  final Widget Function(AppLocalizationManager localization) builder;

  const AppLocalizationProvider({required this.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return builder(AppLocalizationManager.of(context));
  }
}

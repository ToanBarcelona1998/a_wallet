import 'setting_cubit.dart';
import 'setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class SettingCurrentLanguageSelector
    extends BlocSelector<SettingCubit, SettingState, String> {
  SettingCurrentLanguageSelector({
    super.key,
    required Widget Function(String) builder,
  }) : super(
          selector: (state) => state.currentLanguage,
          builder: (context, currentLanguage) => builder(currentLanguage),
        );
}

final class SettingLanguagesSelector
    extends BlocSelector<SettingCubit, SettingState, List<String>> {
  SettingLanguagesSelector({
    super.key,
    required Widget Function(List<String>) builder,
  }) : super(
          selector: (state) => state.languages,
          builder: (context, languages) => builder(languages),
        );
}

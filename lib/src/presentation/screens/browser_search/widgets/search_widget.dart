import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:flutter/material.dart';

class BrowserSearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final void Function(String) onChanged;
  final void Function() onClear;

  const BrowserSearchWidget({
    required this.controller,
    required this.appTheme,
    required this.localization,
    required this.onChanged,
    required this.onClear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing04,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadiusRound,
        ),
        border: Border.all(
          color: appTheme.borderPrimary,
        ),
      ),
      child: TextInputOnlyTextFieldWidget(
        appTheme: appTheme,
        enableClear: true,
        controller: controller,
        onChanged: (value, _) {
          onChanged(value);
        },
        onClear: onClear,
        hintText: localization.translate(
          LanguageKey.browserSearchScreenSearchHint,
        ),
      ),
    );
  }
}

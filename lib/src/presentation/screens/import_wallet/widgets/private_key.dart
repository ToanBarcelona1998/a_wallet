import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';

class ImportWalletPrivateKeyWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final TextEditingController controller;
  final bool Function(String) isValid;
  final void Function(String,bool) onChanged;

  const ImportWalletPrivateKeyWidget({
    required this.appTheme,
    required this.localization,
    required this.controller,
    required this.isValid,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundBorderTextInputWidget(
      appTheme: appTheme,
      hintText: localization.translate(
        LanguageKey.importWalletScreenPrivateKeyHint,
      ),
      controller: controller,
      onChanged: onChanged,
      boxConstraints: const BoxConstraints(
        minHeight: BoxSize.boxSize14,
        maxHeight: BoxSize.boxSize14,
      ),
      constraintManager: ConstraintManager()
        ..custom(
          errorMessage: localization
              .translate(LanguageKey.importWalletScreenInValidPrivateKey),
          customValid: isValid,
        ),
    );
  }
}

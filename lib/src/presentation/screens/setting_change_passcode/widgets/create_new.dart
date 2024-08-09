import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/input_password_widget.dart';
import 'package:flutter/material.dart';

class SettingChangePasscodeScreenCreateNewWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final int fillIndex;

  const SettingChangePasscodeScreenCreateNewWidget({
    required this.appTheme,
    required this.localization,
    required this.fillIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          localization.translate(
            LanguageKey
                .settingChangePasscodeScreenCreateNewPasscode,
          ),
          style: AppTypoGraPhy.textXlBold.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize02,
        ),
        Text(
          localization.translate(
            LanguageKey
                .settingChangePasscodeScreenCreateNewPasscodeContent,
          ),
          style: AppTypoGraPhy.textSmRegular.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        const SizedBox(
          height: Spacing.spacing10,
        ),
        InputPasswordWidget(
          length: 6,
          appTheme: appTheme,
          fillIndex: fillIndex,
        ),
      ],
    );
  }
}

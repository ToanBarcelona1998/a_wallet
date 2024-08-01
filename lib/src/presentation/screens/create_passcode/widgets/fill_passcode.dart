import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/input_password_widget.dart';

final class CreatePasscodeCreateFormWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final int fillIndex;

  const CreatePasscodeCreateFormWidget({
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
            LanguageKey.createPasscodeScreenCreatePasscode,
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
                .createPasscodeScreenCreatePasscodeContent,
          ),
          style: AppTypoGraPhy.textSmRegular.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize10,
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

final class CreatePasscodeConfirmFormWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final int fillIndex;
  final bool isWrongPasscode;

  const CreatePasscodeConfirmFormWidget({
    required this.appTheme,
    required this.localization,
    required this.fillIndex,
    required this.isWrongPasscode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          localization.translate(
            LanguageKey.createPasscodeScreenConfirmPasscode,
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
                .createPasscodeScreenConfirmPasscodeContent,
          ),
          style: AppTypoGraPhy.textSmRegular.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize10,
        ),
        InputPasswordWidget(
          length: 6,
          appTheme: appTheme,
          fillIndex: fillIndex,
        ),
        if (isWrongPasscode) ...[
          const SizedBox(
            height: BoxSize.boxSize04,
          ),
          Text(
            localization.translate(
              LanguageKey
                  .createPasscodeScreenConfirmPasscodeNotMatch,
            ),
            style:
            AppTypoGraPhy.textXsRegular.copyWith(
              color: appTheme.textErrorPrimary,
            ),
            textAlign: TextAlign.center,
          )
        ] else
          const SizedBox()
      ],
    );
  }
}

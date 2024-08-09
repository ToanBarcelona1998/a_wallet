import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/setting_change_passcode/setting_change_passcode_selector.dart';
import 'package:a_wallet/src/presentation/screens/setting_change_passcode/setting_change_passcode_state.dart';
import 'package:a_wallet/src/presentation/widgets/input_password_widget.dart';
import 'package:flutter/material.dart';

class SettingChangePasscodeScreenConfirmWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final int fillIndex;

  const SettingChangePasscodeScreenConfirmWidget({
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
            LanguageKey.settingChangePasscodeScreenConfirmPasscode,
          ),
          style: AppTypoGraPhy.textXlBold.copyWith(
            color: appTheme.textPrimary,
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
        SettingChangePasscodeStatusSelector(
          builder: (status) {
            if (status == SettingChangePassCodeStatus.confirmPasscodeWrong) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: Spacing.spacing04,
                  ),
                  Text(
                    localization.translate(
                      LanguageKey
                          .settingChangePasscodeScreenConfirmPasscodeInvalid,
                    ),
                    style : AppTypoGraPhy.textXsRegular.copyWith(
                      color: appTheme.textErrorPrimary,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

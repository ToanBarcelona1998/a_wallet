import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/get_started/widgets/box_icon.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';

class GetStartedButtonFormWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final VoidCallback onCreateNewWallet;
  final VoidCallback onImportExistingWallet;
  final VoidCallback onTermClick;
  final VoidCallback onGoogleTap;
  final VoidCallback onTwitterTap;
  final VoidCallback onAppleTap;

  const GetStartedButtonFormWidget({
    required this.localization,
    required this.appTheme,
    required this.onCreateNewWallet,
    required this.onImportExistingWallet,
    required this.onTermClick,
    required this.onGoogleTap,
    required this.onTwitterTap,
    required this.onAppleTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryAppButton(
          text: localization.translate(
            LanguageKey.getStartedScreenCreateNewWallet,
          ),
          onPress: onCreateNewWallet,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        BorderAppButton(
          text: localization.translate(
            LanguageKey.getStartedScreenAddWallet,
          ),
          onPress: onImportExistingWallet,
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        Text(
          localization.translate(
            LanguageKey.getStartedScreenOrContinueWith,
          ),
          style: AppTypoGraPhy.textXsRegular.copyWith(
            color: appTheme.textTertiary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetStartedBoxIconWidget(
              onTap: onGoogleTap,
              icPath: AssetIconPath.icCommonGoogle,
              appTheme: appTheme,
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            GetStartedBoxIconWidget(
              onTap: onTwitterTap,
              icPath: AssetIconPath.icCommonTwitter,
              appTheme: appTheme,
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            GetStartedBoxIconWidget(
              onTap: onAppleTap,
              icPath: AssetIconPath.icCommonApple,
              appTheme: appTheme,
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        RichText(
          text: TextSpan(
            style: AppTypoGraPhy.textXsRegular.copyWith(
              color: appTheme.textTertiary,
            ),
            children: [
              TextSpan(
                text: '${localization.translate(
                  LanguageKey.getStartedScreenTermRegionOne,
                )} ',
              ),
              TextSpan(
                  text: localization.translate(
                    LanguageKey.getStartedScreenTermRegionTwo,
                  ),
                  style: AppTypoGraPhy.textXsRegular.copyWith(
                    color: appTheme.textBrandPrimary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermClick),
            ],
          ),
        ),
      ],
    );
  }
}

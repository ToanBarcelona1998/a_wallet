import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/fill_words_widget.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';

class ImportWalletSeedPhraseWidget extends StatelessWidget {
  final AppTheme appTheme;
  final int wordCount;
  final AppLocalizationManager localization;
  final VoidCallback onPaste;
  final VoidCallback onChangeWordClick;
  final GlobalKey<FillWordsWidgetState> fillWordKey;
  final void Function(String, bool)? onWordChanged;
  final bool Function(String) isValid;

  const ImportWalletSeedPhraseWidget({
    this.wordCount = 12,
    required this.appTheme,
    required this.localization,
    required this.onPaste,
    required this.onChangeWordClick,
    required this.fillWordKey,
    required this.isValid,
    this.onWordChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: AppTypoGraPhy.textSmSemiBold.copyWith(
                    color: appTheme.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: '${localization.translate(
                        LanguageKey.importWalletScreenSeedPhraseTitle,
                      )}   ',
                    ),
                    TextSpan(
                      style: AppTypoGraPhy.textSmSemiBold.copyWith(
                        color: appTheme.textBrandPrimary,
                      ),
                      text: localization.translateWithParam(
                        LanguageKey.importWalletScreenSeedPhraseWords,
                        {
                          'words': wordCount,
                        },
                      ),
                        recognizer: TapGestureRecognizer()..onTap = onChangeWordClick
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onPaste,
              behavior: HitTestBehavior.opaque,
              child: TextWithIconWidget(
                titlePath: localization.translate(
                  LanguageKey.importWalletScreenPaste,
                ),
                svgIconPath: AssetIconPath.icCommonPaste,
                appTheme: appTheme,
                style: AppTypoGraPhy.textSmSemiBold.copyWith(
                  color: appTheme.textBrandPrimary,
                ),
                localization: localization,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        FillWordsWidget(
          appTheme: appTheme,
          wordCount: wordCount,
          key: fillWordKey,
          onWordChanged: onWordChanged,
          crossSpacing: Spacing.spacing03,
          mainSpacing: Spacing.spacing03,
          constraintManager: ConstraintManager()
            ..custom(
              errorMessage: localization.translate(
                LanguageKey.importWalletScreenInvalidPassPhrase,
              ),
              customValid: isValid,
            ),
        ),
      ],
    );
  }
}

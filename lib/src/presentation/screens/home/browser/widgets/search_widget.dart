import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/home/browser/browser_page_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserPageSearchWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onViewTap;
  final VoidCallback onSearchTap;

  const BrowserPageSearchWidget({
    required this.appTheme,
    required this.localization,
    required this.onViewTap,
    required this.onSearchTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSearchTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.spacing05,
                vertical: Spacing.spacing03,
              ),
              decoration: BoxDecoration(
                color: appTheme.bgSecondary,
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadiusRound,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    localization.translate(
                      LanguageKey.browserPagePlaceHolder,
                    ),
                    style: AppTypoGraPhy.textSmMedium.copyWith(
                      color: appTheme.textTertiary,
                    ),
                  ),
                  SvgPicture.asset(
                    AssetIconPath.icCommonSearch,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        GestureDetector(
          onTap: onViewTap,
          behavior: HitTestBehavior.opaque,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: appTheme.borderPrimary,
                width: BoxSize.boxSize01,
              ),
              borderRadius: BorderRadius.circular(
                BorderRadiusSize.borderRadius02,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.spacing02,
            ),
            child: BrowserPageTabCountSelector(
              builder: (tabCount) {
                return Text(
                  tabCount.toString(),
                  style: AppTypoGraPhy.textLgBold.copyWith(
                    color: appTheme.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                );
              }
            ),
          ),
        ),
      ],
    );
  }
}

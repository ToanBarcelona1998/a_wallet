import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyxis_mobile/src/application/global/app_theme/app_theme.dart';
import 'package:pyxis_mobile/src/application/global/localization/app_localization_provider.dart';
import 'package:pyxis_mobile/src/core/constants/asset_path.dart';
import 'package:pyxis_mobile/src/core/constants/language_key.dart';
import 'package:pyxis_mobile/src/core/constants/size_constant.dart';
import 'package:pyxis_mobile/src/core/constants/typography.dart';
import 'package:pyxis_mobile/src/presentation/screens/home/browser/browser_page_selector.dart';

class SearchWidget extends StatelessWidget {
  final AppTheme appTheme;
  final VoidCallback onViewTap;
  final VoidCallback onSearchTap;

  const SearchWidget({
    required this.appTheme,
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
                color: appTheme.surfaceColorGrayDefault,
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadiusRound,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLocalizationProvider(
                    builder: (localization, _) {
                      return Text(
                        localization.translate(
                          LanguageKey.inAppBrowserPagePlaceHolder,
                        ),
                        style: AppTypoGraPhy.body03.copyWith(
                          color: appTheme.contentColor300,
                        ),
                      );
                    },
                  ),
                  SvgPicture.asset(
                    AssetIconPath.commonSearch,
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
                color: appTheme.borderColorUnKnow,
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
                  style: AppTypoGraPhy.heading01.copyWith(
                    color: appTheme.contentColor700,
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

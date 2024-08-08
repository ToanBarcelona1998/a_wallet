import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/presentation/screens/browser/browser_selector.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserHeaderWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onViewTap;
  final VoidCallback onSearchTap;
  final String url;
  final VoidCallback onShareTap;
  final VoidCallback onAddNewTab;
  final VoidCallback onRefresh;

  const BrowserHeaderWidget({
    required this.appTheme,
    required this.localization,
    required this.onViewTap,
    required this.onSearchTap,
    required this.url,
    required this.onShareTap,
    required this.onAddNewTab,
    required this.onRefresh,
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
                children: [
                  SvgPicture.asset(
                    AssetIconPath.icCommonLock,
                  ),
                  const SizedBox(
                    width: BoxSize.boxSize03,
                  ),
                  Expanded(
                    child: Text(
                      url,
                      style: AppTypoGraPhy.textSmMedium.copyWith(
                        color: appTheme.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
            child: BrowserTabCountSelector(builder: (tabCount) {
              return Text(
                tabCount.toString(),
                style: AppTypoGraPhy.textLgBold.copyWith(
                  color: appTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              );
            }),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Spacing.spacing04,
            ),
            child: PopupMenuButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadius04,
                ),
              ),
              color: appTheme.bgPrimary,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    onTap: onAddNewTab,
                    child: _BrowserPopupMenuItemWidget(
                      titlePath: LanguageKey.browserScreenNewTab,
                      svgIconPath: AssetIconPath.icCommonAdd,
                      appTheme: appTheme,
                      localization: localization,
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    onTap: onShareTap,
                    child: _BrowserPopupMenuItemWidget(
                      titlePath: LanguageKey.browserScreenShare,
                      svgIconPath: AssetIconPath.icCommonShare,
                      appTheme: appTheme,
                      localization: localization,
                    ),
                  ),
                  PopupMenuItem(
                    padding: EdgeInsets.zero,
                    onTap: onRefresh,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HoLiZonTalDividerWidget(
                          appTheme: appTheme,
                        ),
                        const SizedBox(
                          height: BoxSize.boxSize05,
                        ),
                        _BrowserPopupMenuItemWidget(
                          titlePath: LanguageKey.browserScreenRefresh,
                          svgIconPath: AssetIconPath.icCommonRefresh,
                          appTheme: appTheme,
                          localization: localization,
                        ),
                      ],
                    ),
                  ),
                ];
              },
              child: SvgPicture.asset(
                AssetIconPath.icCommonMore,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class _BrowserPopupMenuItemWidget extends StatelessWidget {
  final String titlePath;
  final String svgIconPath;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const _BrowserPopupMenuItemWidget({
    required this.titlePath,
    required this.svgIconPath,
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.w * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing04,
        ),
        child: IconWithTextWidget(
          titlePath: titlePath,
          svgIconPath: svgIconPath,
          appTheme: appTheme,
          localization: localization,
        ),
      ),
    );
  }
}

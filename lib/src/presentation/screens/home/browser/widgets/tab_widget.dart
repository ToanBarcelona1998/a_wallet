import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserPageTabWidget extends StatefulWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final int selectedTab;
  final void Function(int) onSelect;

  const BrowserPageTabWidget({
    required this.appTheme,
    required this.localization,
    this.selectedTab = 0,
    required this.onSelect,
    super.key,
  });

  @override
  State<BrowserPageTabWidget> createState() => _BrowserPageTabWidgetState();
}

class _BrowserPageTabWidgetState extends State<BrowserPageTabWidget> {
  int _indexSelected = 0;

  @override
  void initState() {
    _indexSelected = widget.selectedTab;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BrowserPageTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _indexSelected = widget.selectedTab;
  }

  void _onSelect(int index) {
    setState(() {
      _indexSelected = index;
    });

    widget.onSelect(_indexSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TabItemWidget(
            titleKey: LanguageKey.browserPageEcosystemTab,
            appTheme: widget.appTheme,
            isSelected: _indexSelected == 0,
            onSelect: () {
              _onSelect(0);
            },
            leading: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _indexSelected == 0
                    ? SvgPicture.asset(
                        AssetIconPath.icBrowserEcosystemWhite,
                      )
                    : SvgPicture.asset(
                        AssetIconPath.icBrowserEcosystem,
                      ),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
              ],
            ),
            localization: widget.localization,
          ),
        ),
        Expanded(
          child: _TabItemWidget(
            titleKey: LanguageKey.browserPageBookMarkTab,
            appTheme: widget.appTheme,
            isSelected: _indexSelected == 1,
            onSelect: () {
              _onSelect(1);
            },
            localization: widget.localization,
          ),
        ),
      ],
    );
  }
}

final class _TabItemWidget extends StatelessWidget {
  final String titleKey;
  final bool isSelected;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final Widget? leading;
  final VoidCallback onSelect;

  const _TabItemWidget({
    required this.titleKey,
    this.isSelected = false,
    required this.appTheme,
    required this.localization,
    super.key,
    this.leading,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing05,
          vertical: Spacing.spacing03,
        ),
        decoration: BoxDecoration(
          color: isSelected ? appTheme.bgBrandPrimary : null,
          borderRadius: isSelected
              ? BorderRadius.circular(
                  BorderRadiusSize.borderRadiusRound,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leading ?? const SizedBox.shrink(),
            Text(
              localization.translate(
                titleKey,
              ),
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: isSelected ? appTheme.textWhite : appTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

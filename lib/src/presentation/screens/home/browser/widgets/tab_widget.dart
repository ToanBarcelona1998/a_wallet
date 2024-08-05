import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabWidget extends StatefulWidget {
  final AppTheme appTheme;
  final int selectedTab;
  final void Function(int) onSelect;

  const TabWidget({
    required this.appTheme,
    this.selectedTab = 0,
    required this.onSelect,
    super.key,
  });

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  int _indexSelected = 0;

  @override
  void initState() {
    _indexSelected = widget.selectedTab;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TabWidget oldWidget) {
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
            titleKey: LanguageKey.inAppBrowserPageEcosystemTab,
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
                        AssetIconPath.browserEcosystemWhite,
                      )
                    : SvgPicture.asset(
                        AssetIconPath.browserEcosystem,
                      ),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _TabItemWidget(
            titleKey: LanguageKey.inAppBrowserPageBookMarkTab,
            appTheme: widget.appTheme,
            isSelected: _indexSelected == 1,
            onSelect: () {
              _onSelect(1);
            },
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
  final Widget? leading;
  final VoidCallback onSelect;

  const _TabItemWidget({
    required this.titleKey,
    this.isSelected = false,
    required this.appTheme,
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
          color: isSelected ? appTheme.primaryColor600 : null,
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
            AppLocalizationProvider(
              builder: (localization, _) {
                return Text(
                  localization.translate(
                    titleKey,
                  ),
                  style: AppTypoGraPhy.bodyMedium02.copyWith(
                    color: isSelected
                        ? appTheme.contentColorWhite
                        : appTheme.contentColor500,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

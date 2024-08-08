import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

final class HomePageTabWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final TabController controller;
  final void Function(int) onSelected;

  const HomePageTabWidget({
    required this.appTheme,
    required this.localization,
    required this.controller,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelStyle: AppTypoGraPhy.textMdBold.copyWith(
        color: appTheme.textPrimary
      ),
      indicatorPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      dividerHeight: 0,
      indicatorColor: appTheme.fgBrandSecondary,
      isScrollable: true,
      indicatorWeight: DividerSize.divider02,
      unselectedLabelColor: appTheme.textQuaternary,
      controller: controller,
      onTap: onSelected,
      tabs: [
        Tab(
          text: localization.translate(
            LanguageKey.homePageTokensTab,
          ),
        ),
        Tab(
          text: localization.translate(
            LanguageKey.homePageNFTsTab,
          ),
        ),
      ],
    );
  }
}

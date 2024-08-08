import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/box_widget.dart';

final class HomePageActionWidget extends StatelessWidget {
  final AppTheme appTheme;
  final String title;
  final String svg;
  final Color? bgColor;
  final VoidCallback onTap;

  const HomePageActionWidget({
    required this.appTheme,
    required this.title,
    required this.svg,
    required this.onTap,
    this.bgColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BoxIconWidget(
            svg: svg,
            height: BoxSize.boxSize10,
            width: BoxSize.boxSize10,
            color: bgColor,
            padding: const EdgeInsets.all(
              Spacing.spacing04,
            ),
            appTheme: appTheme,
          ),
          const SizedBox(
            height: BoxSize.boxSize03,
          ),
          Text(
            title,
            style: AppTypoGraPhy.textXsSemiBold.copyWith(
              color: appTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

final class HomePageActionsWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onSendTap;
  final VoidCallback onReceiveTap;
  final VoidCallback onSwapTap;
  final VoidCallback onStakingTap;

  const HomePageActionsWidget({
    required this.appTheme,
    required this.localization,
    required this.onSendTap,
    required this.onReceiveTap,
    required this.onSwapTap,
    required this.onStakingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HomePageActionWidget(
            appTheme: appTheme,
            title: localization.translate(
              LanguageKey.homePageSend,
            ),
            svg: AssetIconPath.icCommonSend,
            bgColor: appTheme.utilityBlue100,
            onTap: onSendTap,
          ),
          HomePageActionWidget(
            appTheme: appTheme,
            title: localization.translate(
              LanguageKey.homePageReceive,
            ),
            svg: AssetIconPath.icCommonReceive,
            bgColor: appTheme.utilityGreen100,
            onTap: onReceiveTap,
          ),
          HomePageActionWidget(
            appTheme: appTheme,
            title: localization.translate(
              LanguageKey.homePageSwap,
            ),
            svg: AssetIconPath.icCommonSwap,
            bgColor: appTheme.utilityPink100,
            onTap: onSwapTap,
          ),
          HomePageActionWidget(
            appTheme: appTheme,
            title: localization.translate(
              LanguageKey.homePageStake,
            ),
            svg: AssetIconPath.icCommonStake,
            bgColor: appTheme.utilityOrange100,
            onTap: onStakingTap,
          ),
        ],
      ),
    );
  }
}

final class HomePageActionsSmallWidget extends StatelessWidget {
  final AppTheme appTheme;
  final VoidCallback onSendTap;
  final VoidCallback onReceiveTap;
  final VoidCallback onSwapTap;
  final VoidCallback onStakingTap;

  const HomePageActionsSmallWidget({
    required this.appTheme,
    required this.onSendTap,
    required this.onReceiveTap,
    required this.onSwapTap,
    required this.onStakingTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BoxIconWidget(
          appTheme: appTheme,
          svg: AssetIconPath.icCommonSend,
          color: appTheme.utilityBlue100,
          padding: const EdgeInsets.all(
            Spacing.spacing04,
          ),
          icWidth: BoxSize.boxSize05,
          onTap: onSendTap,
        ),
        BoxIconWidget(
          appTheme: appTheme,
          svg: AssetIconPath.icCommonReceive,
          color: appTheme.utilityGreen100,
          padding: const EdgeInsets.all(
            Spacing.spacing04,
          ),
          icWidth: BoxSize.boxSize05,
          onTap: onReceiveTap,
        ),
        BoxIconWidget(
          appTheme: appTheme,
          svg: AssetIconPath.icCommonSwap,
          color: appTheme.utilityPink100,
          padding: const EdgeInsets.all(
            Spacing.spacing04,
          ),
          icWidth: BoxSize.boxSize05,
          onTap: onSwapTap,
        ),
        BoxIconWidget(
          appTheme: appTheme,
          svg: AssetIconPath.icCommonStake,
          color: appTheme.utilityOrange100,
          padding: const EdgeInsets.all(
            Spacing.spacing04,
          ),
          icWidth: BoxSize.boxSize05,
          onTap: onStakingTap,
        ),
      ],
    );
  }
}

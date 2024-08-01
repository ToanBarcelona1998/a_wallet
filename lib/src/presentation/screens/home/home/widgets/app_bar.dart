import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/home/home/widgets/action.dart';
import 'package:a_wallet/src/presentation/widgets/circle_avatar_widget.dart';

final class HomeAppBar extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final bool showActions;
  final bool showWallet;
  final VoidCallback onActionClick;
  final String avatarAsset;
  final VoidCallback onSendTap;
  final VoidCallback onReceiveTap;
  final VoidCallback onSwapTap;
  final VoidCallback onStakingTap;

  const HomeAppBar({
    required this.appTheme,
    required this.localization,
    this.showActions = false,
    this.showWallet = false,
    required this.onActionClick,
    required this.avatarAsset,
    required this.onSendTap,
    required this.onReceiveTap,
    required this.onSwapTap,
    required this.onStakingTap,
    super.key,
  });

  bool get showTitleAndWallet => showWallet && !showActions;

  bool get showAppBarSmall => showWallet && showActions;

  @override
  Widget build(BuildContext context) {
    if (showAppBarSmall) {
      return _appBarSmall();
    } else if (showTitleAndWallet) {
      return _appBarWithWalletCardSmall();
    }
    return _defaultAppBar();
  }

  Widget _buildSmallTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing03,
        vertical: Spacing.spacing02,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgTertiary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: SvgPicture.asset(
        AssetIconPath.icCommonAWallet,
      ),
    );
  }

  Widget _defaultAppBar() {
    return _titleDefault();
  }

  Widget _titleDefault() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetIconPath.icCommonAWallet,
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        Text(
          localization.translate(
            LanguageKey.homePageAllNetwork,
          ),
          style: AppTypoGraPhy.textSmSemiBold.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _appBarSmall() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _buildSmallTitle(),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onActionClick,
                  child: Row(
                    children: [
                      CircleAvatarWidget(
                        image: AssetImage(
                          avatarAsset,
                        ),
                        radius: BorderRadiusSize.borderRadius04,
                      ),
                      const SizedBox(
                        width: BoxSize.boxSize04,
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: appTheme.borderSecondary,
                  thickness: DividerSize.divider01,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: HomePageActionsSmallWidget(
              appTheme: appTheme,
              onSwapTap: onSwapTap,
              onStakingTap: onStakingTap,
              onSendTap: onSendTap,
              onReceiveTap: onReceiveTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarWithWalletCardSmall() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _titleDefault(),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onActionClick,
          child: Row(
            children: [
              CircleAvatarWidget(
                image: AssetImage(
                  avatarAsset,
                ),
                radius: BorderRadiusSize.borderRadius04,
              ),
              const SizedBox(
                width: BoxSize.boxSize04,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

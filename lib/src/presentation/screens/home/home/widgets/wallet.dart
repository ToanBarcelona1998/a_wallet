import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/presentation/screens/home/home/home_page_selector.dart';
import 'package:a_wallet/src/presentation/widgets/wallet_info_widget.dart';

class HomePageWalletCardWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onEnableTokenTap;
  final String avatarAsset;

  const HomePageWalletCardWidget({
    required this.appTheme,
    required this.localization,
    required this.onEnableTokenTap,
    required this.avatarAsset,
    super.key,
  });

  Color valueChangeColor(double percent24hChange) {
    if (percent24hChange.isIncrease) {
      return appTheme.utilityGreen500;
    } else if (percent24hChange == 0) {
      return appTheme.textSecondary;
    }

    return appTheme.utilityRed500;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing05,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgBrandPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius05,
        ),
      ),
      child: Column(
        children: [
          HomePageActiveAccountSelector(
            builder: (account) {
              final cosmosAddress = account?.aCosmosInfo.displayAddress  ?? '';
              final evmAddress = account?.aEvmInfo.displayAddress  ?? '';
              return WalletMultiAddressInfoWidget(
                appTheme: appTheme,
                title: account?.name ?? '',
                address: evmAddress,
                avatarAsset: avatarAsset,
                cosmosAddress: cosmosAddress,
              );
            },
          ),
          const SizedBox(
            height: BoxSize.boxSize05,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: Spacing.spacing04,
              horizontal: Spacing.spacing05,
            ),
            decoration: BoxDecoration(
              color: appTheme.bgPrimary,
              borderRadius: BorderRadius.circular(
                BorderRadiusSize.borderRadius04,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: HomePageEnableTokenSelector(
                          builder: (enableTokenValue) {
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: onEnableTokenTap,
                          child: Row(
                            children: [
                              Text(
                                localization.translate(
                                  LanguageKey.homePageTotalValue,
                                ),
                                style: AppTypoGraPhy.textSmMedium.copyWith(
                                  color: appTheme.textTertiary,
                                ),
                              ),
                              const SizedBox(
                                width: BoxSize.boxSize04,
                              ),
                              SvgPicture.asset(
                                enableTokenValue
                                    ? AssetIconPath.icCommonEye
                                    : AssetIconPath.icCommonEyeClose,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      width: BoxSize.boxSize04,
                    ),
                    SvgPicture.asset(
                      AssetIconPath.icCommonScan,
                    ),
                  ],
                ),
                const SizedBox(
                  height: BoxSize.boxSize03,
                ),
                HomePageTotalValueSelector(builder: (totalValue) {
                  return HomePageEnableTokenSelector(
                      builder: (enableTotalValue) {
                    if (!enableTotalValue) {
                      return Text(
                        '********',
                        style: AppTypoGraPhy.displayXsSemiBold.copyWith(
                          color: appTheme.textPrimary,
                        ),
                      );
                    }
                    return Text(
                      '${localization.translate(LanguageKey.commonBalancePrefix)}${totalValue.formatPrice}',
                      style: AppTypoGraPhy.displayXsSemiBold.copyWith(
                        color: appTheme.textPrimary,
                      ),
                    );
                  });
                }),
                const SizedBox(
                  height: BoxSize.boxSize03,
                ),
                HomePageTotalValueSelector(
                  builder: (totalValue) {
                    return HomePageTotalValueYesterdaySelector(
                      builder: (totalValueYesterday) {
                        double changed = totalValue - totalValueYesterday;
                        double percentChanged = 0;

                        if(totalValue != 0){
                          percentChanged = (changed / totalValue) * 100;
                        }
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: AppTypoGraPhy.textXsMedium.copyWith(
                                  color: appTheme.textSecondary,
                                ),
                                text: '${localization.translate(
                                  LanguageKey.homePage24hPNL,
                                )}  ',
                              ),
                              TextSpan(
                                style: AppTypoGraPhy.textXsMedium.copyWith(
                                  color: valueChangeColor(changed),
                                ),
                                text:
                                    '${changed.prefixValueChange}${localization.translate(LanguageKey.commonBalancePrefix)}${changed.formatPnl24}(${changed.prefixValueChange}${(percentChanged).formatPercent}%)',
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

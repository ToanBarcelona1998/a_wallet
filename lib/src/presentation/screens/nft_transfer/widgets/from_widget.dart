import 'package:a_wallet/src/presentation/screens/nft_transfer/nft_transfer_selector.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:a_wallet/src/presentation/widgets/wallet_info_widget.dart';

final class NftTransferScreenFromWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final EdgeInsetsGeometry padding;

  const NftTransferScreenFromWidget({
    required this.appTheme,
    required this.localization,
    required this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.translate(
                  LanguageKey.nftTransferScreenFrom,
                ),
                style: AppTypoGraPhy.textSmSemiBold.copyWith(
                  color: appTheme.textPrimary,
                ),
              ),
              const SizedBox(
                height: BoxSize.boxSize05,
              ),
              NftTransferAccountSelector(
                  builder: (account) {
                    String sender = account?.evmAddress ?? '';
                    return DefaultWalletInfoWidget(
                      avatarAsset: randomAvatar(),
                      appTheme: appTheme,
                      title: account?.name ?? '',
                      address: sender,
                    );
                  }
              ),
            ],
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        HoLiZonTalDividerWidget(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }
}

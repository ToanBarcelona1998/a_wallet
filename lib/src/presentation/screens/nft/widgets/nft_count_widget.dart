import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_bloc.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_event.dart';
import 'package:a_wallet/src/presentation/screens/nft/nft_selector.dart';

class NFTScreenCountWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const NFTScreenCountWidget({
    super.key,
    required this.appTheme,
    required this.localization,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.translate(
                LanguageKey.nftScreenTotal,
              ),
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: appTheme.textSecondary,
              ),
            ),
            const SizedBox(
              height: BoxSize.boxSize02,
            ),
            NFTTotalCountSelector(
              builder: (total) {
                return Text(
                  total.toString(),
                  style: AppTypoGraPhy.textLgBold.copyWith(
                    color: appTheme.textSecondary,
                  ),
                );
              },
            ),
          ],
        ),
        NFTLayoutViewTypeSelector(
          builder: (viewType) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                NFTLayoutType type = NFTLayoutType.grid;

                if (viewType == NFTLayoutType.grid) {
                  type = NFTLayoutType.list;
                }
                NFTBloc.of(context).add(
                  NFTEventOnSwitchViewType(
                    type: type,
                  ),
                );
              },
              child: _buildIcon(viewType),
            );
          },
        ),
      ],
    );
  }

  Widget _buildIcon(
    NFTLayoutType viewType,
  ) {
    switch (viewType) {
      case NFTLayoutType.grid:
        return SvgPicture.asset(
          AssetIconPath.icNftScreenGrid,
        );
      case NFTLayoutType.list:
        return SvgPicture.asset(
          AssetIconPath.icNftScreenList,
        );
    }
  }
}

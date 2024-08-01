import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';

final class SelectNetworkWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppNetwork appNetwork;
  final void Function(AppNetwork) onSelect;

  const SelectNetworkWidget({
    required this.appTheme,
    required this.appNetwork,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(appNetwork),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing05,
          vertical: Spacing.spacing06,
        ),
        decoration: BoxDecoration(
          color: appTheme.bgSecondary,
          borderRadius: BorderRadius.circular(
            BorderRadiusSize.borderRadius04,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              appNetwork.logo,
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            Expanded(
              child: Text(
                appNetwork.name,
                style: AppTypoGraPhy.textMdMedium.copyWith(
                  color: appTheme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            SvgPicture.asset(
              AssetIconPath.icCommonArrowNext,
            ),
          ],
        ),
      ),
    );
  }
}

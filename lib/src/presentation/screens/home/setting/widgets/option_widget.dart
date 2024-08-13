import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingPageOptionWidget extends StatelessWidget {
  final String iconPath;
  final String labelPath;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onTap;
  final String? value;

  const SettingPageOptionWidget({
    required this.iconPath,
    required this.labelPath,
    required this.appTheme,
    required this.localization,
    required this.onTap,
    this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: Spacing.spacing04,
          top: Spacing.spacing04,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: BoxSize.boxSize05,
            ),
            Expanded(
              child: Text(
                localization.translate(
                  labelPath,
                ),
                style: AppTypoGraPhy.textSmMedium.copyWith(
                  color: appTheme.textSecondary,
                ),
              ),
            ),
            if (value != null)
              Text(
                value ?? '',
                style: AppTypoGraPhy.textSmMedium.copyWith(
                  color: appTheme.textPrimary,
                ),
              ),
            const SizedBox(
              width: BoxSize.boxSize05,
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

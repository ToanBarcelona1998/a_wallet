import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/utils/app_date_format.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

final class NFTScreenVerticalCard extends StatelessWidget {
  final String name;
  final String createTime;
  final String url;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final String idToken;

  const NFTScreenVerticalCard({
    super.key,
    required this.name,
    required this.createTime,
    required this.url,
    required this.appTheme,
    required this.localization,
    required this.idToken,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              BorderRadiusSize.borderRadius03,
            ),
            child: Stack(
              children: [
                NetworkImageWidget(
                  url: url,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  appTheme: appTheme,
                ),
                Positioned(
                  top: Spacing.spacing03,
                  right: Spacing.spacing03,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Spacing.spacing01,
                      horizontal: Spacing.spacing03,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.alphaBlack50,
                      borderRadius: BorderRadius.circular(
                        BorderRadiusSize.borderRadiusRound,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      idToken,
                      style: AppTypoGraPhy.textSmMedium.copyWith(
                        color: appTheme.textPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize02,
        ),
        Text(
          name,
          style: AppTypoGraPhy.textMdBold.copyWith(
            color: appTheme.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(
          height: BoxSize.boxSize01,
        ),
        Text(
          AppDateTime.formatDateHHMMDMMMYYY(
            createTime,
          ),
          style: AppTypoGraPhy.textXsRegular.copyWith(
            color: appTheme.textTertiary,
          ),
        ),
      ],
    );
  }

}

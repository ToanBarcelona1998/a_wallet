import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/utils/app_date_format.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

final class NFTScreenHorizontalCard extends StatelessWidget {
  final String name;
  final String createTime;
  final String url;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final String idToken;

  const NFTScreenHorizontalCard({
    super.key,
    required this.name,
    required this.createTime,
    required this.url,
    required this.appTheme,
    required this.localization,
    required this.idToken,
  });

  static const double _width = 100;
  static const double _height = 90;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            BorderRadiusSize.borderRadius03,
          ),
          child: NetworkImageWidget(
            url: url,
            width: _width,
            height: _height,
            appTheme: appTheme,
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTypoGraPhy.textMdBold.copyWith(
                  color: appTheme.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: BoxSize.boxSize02,
              ),
              Text(
                localization.translate(
                  LanguageKey.nftScreenTokenStandard,
                ),
                style: AppTypoGraPhy.textXsSemiBold.copyWith(
                  color: appTheme.textSecondary,
                ),
              ),
              const SizedBox(
                height: BoxSize.boxSize02,
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
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        Text(
          idToken,
          style: AppTypoGraPhy.textSmMedium.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

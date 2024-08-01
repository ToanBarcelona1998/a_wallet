import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';

class TransactionResultLogoWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final String amount;

  const TransactionResultLogoWidget({
    required this.appTheme,
    required this.localization,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w,
      padding: EdgeInsets.only(
        top: Spacing.spacing07 + context.statusBar,
        bottom: Spacing.spacing05,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appTheme.utilityBrand100,
            appTheme.bgPrimary,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetLogoPath.logo2,
          ),
          const SizedBox(
            height: BoxSize.boxSize07,
          ),
          Text(
            localization.translate(
              LanguageKey.transactionResultScreenTitle,
            ),
            style: AppTypoGraPhy.textLgBold.copyWith(
              color: appTheme.textPrimary,
            ),
          ),
          const SizedBox(
            height: BoxSize.boxSize03,
          ),
          Text(
            '$amount ${localization.translate(LanguageKey.commonAura,)}',
            style: AppTypoGraPhy.displayXsBold.copyWith(
              color: appTheme.textBrandPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

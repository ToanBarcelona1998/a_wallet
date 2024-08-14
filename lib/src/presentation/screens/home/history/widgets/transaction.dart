import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_date_format.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:flutter/material.dart';

final class HistoryTransactionWidget extends StatelessWidget {
  final String hash;
  final String createTime;
  final String from;
  final String to;
  final String amount;
  final String functionName;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const HistoryTransactionWidget({
    super.key,
    required this.hash,
    required this.createTime,
    required this.to,
    required this.from,
    required this.amount,
    required this.functionName,
    required this.localization,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: BoxSize.boxSize05,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing04,
        vertical: Spacing.spacing03,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
        border: Border.all(
          color: appTheme.borderTertiary,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                functionName,
                style: AppTypoGraPhy.textSmSemiBold.copyWith(
                  color: appTheme.textBrandPrimary,
                ),
              ),
              Text(
                AppDateTime.formatDateHHMMDMMMYYY(
                  createTime,
                ),
                style: AppTypoGraPhy.textXsMedium.copyWith(
                  color: appTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: BoxSize.boxSize02,
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Spacing.spacing02,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    localization.translate(LanguageKey.historyPageHash),
                    style: AppTypoGraPhy.textXsSemiBold.copyWith(
                      color: appTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    hash.addressView,
                    style: AppTypoGraPhy.textXsMedium.copyWith(
                      color: appTheme.textBrandPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          _buildTransactionDetail(
            LanguageKey.historyPageTo,
            to.addressView,
          ),
          _buildTransactionDetail(
            LanguageKey.historyPageAmount,
            '$amount ${localization.translate(
              LanguageKey.commonAura,
            )}',
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionDetail(String label, String value,) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Spacing.spacing02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              localization.translate(label),
              style: AppTypoGraPhy.textXsSemiBold.copyWith(
                color: appTheme.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: AppTypoGraPhy.textXsMedium.copyWith(
                color: appTheme.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

class NFTDetailInformationFormWidget extends StatelessWidget {
  final String name;
  final String blockChain;
  final String contractAddress;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onCopy;

  const NFTDetailInformationFormWidget({
    required this.name,
    required this.blockChain,
    required this.contractAddress,
    required this.appTheme,
    required this.localization,
    required this.onCopy,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _NFTDetailInformationWidget(
          appTheme: appTheme,
          title: localization.translate(
            LanguageKey.nftDetailScreenName,
          ),
          value: name,
        ),
        _NFTDetailInformationWidget(
          appTheme: appTheme,
          title: localization.translate(
            LanguageKey.nftDetailScreenBlockChain,
          ),
          value: blockChain,
        ),
        _NFTDetailInformationWidget(
          appTheme: appTheme,
          title: localization.translate(
            LanguageKey.nftDetailScreenTokenStandardTitle,
          ),
          value: '',
          valueBuilder: Text(
            localization.translate(
              LanguageKey.nftDetailScreenTokenStandard,
            ),
            style: AppTypoGraPhy.textSmMedium.copyWith(
              color: appTheme.textSecondary,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _NFTDetailInformationWidget(
          appTheme: appTheme,
          title: localization.translate(
            LanguageKey.nftDetailScreenContractAddress,
          ),
          value: '',
          valueBuilder: GestureDetector(
            onTap: onCopy,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    contractAddress.addressView,
                    style: AppTypoGraPhy.textSmMedium.copyWith(
                      color: appTheme.textSecondary,
                    ),
                    textAlign: TextAlign.end,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
                SvgPicture.asset(
                  AssetIconPath.icCommonCopy,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NFTDetailInformationWidget extends StatelessWidget {
  final AppTheme appTheme;
  final String title;
  final String value;
  final Widget? valueBuilder;

  const _NFTDetailInformationWidget({
    required this.appTheme,
    super.key,
    required this.title,
    required this.value,
    this.valueBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Spacing.spacing06,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: appTheme.textPrimary,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: valueBuilder ??
                Text(
                  value,
                  style: AppTypoGraPhy.textSmMedium.copyWith(
                    color: appTheme.textSecondary,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/aura_scan.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/helpers/app_launcher.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';

abstract class _TransactionInformationBaseWidget extends StatelessWidget {
  final String title;
  final String information;
  final AppTheme appTheme;

  const _TransactionInformationBaseWidget({
    super.key,
    required this.title,
    required this.information,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Spacing.spacing06,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleBuilder(context),
          informationBuilder(
            context,
          ),
        ],
      ),
    );
  }

  Widget titleBuilder(
    BuildContext context,
  ) {
    return Text(
      title,
      style: AppTypoGraPhy.textSmRegular.copyWith(
        color: appTheme.textSecondary,
      ),
    );
  }

  Widget informationBuilder(
    BuildContext context,
  ) {
    return Text(
      information,
      style: AppTypoGraPhy.textSmSemiBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }
}

final class _TransactionInformationHashWidget
    extends _TransactionInformationBaseWidget {
  final void Function(String) onHashClick;

  const _TransactionInformationHashWidget({
    required this.onHashClick,
    required super.title,
    required super.information,
    required super.appTheme,
  });

  @override
  Widget informationBuilder(BuildContext context) {
    return GestureDetector(
      onTap: () => onHashClick(information),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Text(
            information.addressView,
            style: AppTypoGraPhy.textSmSemiBold.copyWith(
              color: appTheme.textBrandPrimary,
            ),
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          SvgPicture.asset(
            AssetIconPath.icCommonViewHash,
          ),
        ],
      ),
    );
  }
}

final class _TransactionInformationWidget
    extends _TransactionInformationBaseWidget {
  const _TransactionInformationWidget({
    required super.title,
    required super.information,
    required super.appTheme,
  });
}

final class TransactionResultInformationWidget extends StatelessWidget {
  final String from;
  final String recipient;
  final String time;
  final String hash;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const TransactionResultInformationWidget({
    required this.from,
    required this.recipient,
    required this.appTheme,
    required this.localization,
    required this.hash,
    super.key,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _TransactionInformationWidget(
          title: localization.translate(
            LanguageKey.transactionResultScreenFrom,
          ),
          information: from.addressView,
          appTheme: appTheme,
        ),
        _TransactionInformationWidget(
          title: localization.translate(
            LanguageKey.transactionResultScreenTo,
          ),
          information: recipient.addressView,
          appTheme: appTheme,
        ),
        _TransactionInformationWidget(
          title: localization.translate(
            LanguageKey.transactionResultScreenTime,
          ),
          information: time,
          appTheme: appTheme,
        ),
        _TransactionInformationHashWidget(
          title: localization.translate(
            LanguageKey.transactionResultScreenHash,
          ),
          information: hash,
          appTheme: appTheme,
          onHashClick: (hash) {
            AppLauncher.launch(
              AuraScan.transaction(hash),
            );
          },
        ),
      ],
    );
  }
}

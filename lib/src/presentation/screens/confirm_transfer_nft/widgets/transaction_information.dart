import 'package:a_wallet/src/presentation/screens/confirm_transfer_nft/confirm_transfer_nft_selector.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';

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

final class _TransactionInformationFeeWidget
    extends _TransactionInformationBaseWidget {
  final VoidCallback onEditFee;
  final AppLocalizationManager localization;

  const _TransactionInformationFeeWidget({
    required this.onEditFee,
    required this.localization,
    required super.title,
    required super.information,
    required super.appTheme,
  });

  @override
  Widget informationBuilder(BuildContext context) {
    return Row(
      children: [
        Text(
          information,
          style: AppTypoGraPhy.textSmSemiBold.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onEditFee,
          child: Row(
            children: [
              SvgPicture.asset(
                AssetIconPath.icCommonFeeEdit,
              ),
              const SizedBox(
                width: BoxSize.boxSize03,
              ),
              Text(
                localization.translate(
                  LanguageKey.confirmTransferNftScreenSendEdit,
                ),
                style: AppTypoGraPhy.textSmSemiBold.copyWith(
                  color: appTheme.textBrandPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

final class _ConfirmTransferNftInformationWidget
    extends _TransactionInformationBaseWidget {
  const _ConfirmTransferNftInformationWidget({
    required super.title,
    required super.information,
    required super.appTheme,
  });
}

final class ConfirmTransferNftInformationWidget extends StatelessWidget {
  final String from;
  final String accountName;
  final String recipient;
  final AppTheme appTheme;
  final void Function(BigInt, BigInt) onEditFee;
  final AppLocalizationManager localization;

  const ConfirmTransferNftInformationWidget({
    required this.accountName,
    required this.from,
    required this.recipient,
    required this.appTheme,
    required this.onEditFee,
    required this.localization,
    super.key,
  });

  TokenType get type => TokenType.native;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DividerSeparator(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize06,
        ),
        DividerSeparator(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize06,
        ),
        _ConfirmTransferNftInformationWidget(
          title: localization.translate(
            LanguageKey.confirmTransferNftScreenFrom,
          ),
          information: '${from.addressView} ($accountName)',
          appTheme: appTheme,
        ),
        _ConfirmTransferNftInformationWidget(
          title: localization.translate(
            LanguageKey.confirmTransferNftScreenRecipient,
          ),
          information: recipient.addressView,
          appTheme: appTheme,
        ),
        ConfirmTransferNftGasEstimationSelector(
          builder: (gasEstimation) {
            return ConfirmTransferNftGasPriceSelector(
              builder: (gasPrice) {
                return ConfirmTransferNftGasPriceToSendSelector(
                    builder: (gasPriceToSend) {
                  final BigInt fee = gasEstimation * gasPriceToSend;
                  return _TransactionInformationFeeWidget(
                    onEditFee: () {
                      onEditFee(gasPrice, gasEstimation);
                    },
                    localization: localization,
                    title: localization.translate(
                      LanguageKey.confirmTransferNftScreenFee,
                    ),
                    information: '${type.formatBalance(
                      fee.toString(),
                    )} ${localization.translate(
                      LanguageKey.commonAura,
                    )}',
                    appTheme: appTheme,
                  );
                });
              },
            );
          },
        )
      ],
    );
  }
}

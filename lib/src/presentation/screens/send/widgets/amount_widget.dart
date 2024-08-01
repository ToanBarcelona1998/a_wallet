import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/app_local_constant.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/presentation/screens/send/send_selector.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';

class SendScreenAmountToSendWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final AppTheme appTheme;
  final void Function(String) onMaxTap;
  final void Function(String, bool) onChanged;
  final void Function(List<Balance>, Balance, List<TokenMarket>, List<Token>)
      onSelectToken;
  final TextEditingController amountController;

  const SendScreenAmountToSendWidget({
    required this.appTheme,
    required this.localization,
    required this.onChanged,
    required this.onSelectToken,
    required this.onMaxTap,
    required this.amountController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SendTokenTokensSelector(
      builder: (tokens) {
        return SendSelectedBalanceSelector(
          builder: (balance) {
            final token = tokens.firstWhereOrNull(
              (t) => t.id == balance?.tokenId,
            );

            double total = double.tryParse(token?.type.formatBalance(
                        balance?.balance ?? '',
                        customDecimal: token.decimal) ??
                    '') ??
                0.0;
            return _TextInputAmountWidget(
              appTheme: appTheme,
              localization: localization,
              hintText: '0.00',
              keyBoardType: TextInputType.number,
              onChanged: onChanged,
              onSelectToken: onSelectToken,
              constraintManager: ConstraintManager()
                ..custom(
                  errorMessage: localization.translate(
                    LanguageKey.sendScreenAmountInvalid,
                  ),
                  customValid: (amount) {
                    return _checkValidAmount(amount, total);
                  },
                ),
              controller: amountController,
              onMaxTap: onMaxTap,
            );
          },
        );
      },
    );
  }

  // Check if the provided amount is valid
  bool _checkValidAmount(String amount, double total) {
    try {
      // Parse the amount as a double
      double am = double.parse(amount);

      // Return true if amount is greater than 0 and less than or equal to the total balance
      return am > 0 && am <= total;
    } catch (e) {
      // Return false if there's an exception (e.g., amount cannot be parsed as a double)
      return false;
    }
  }
}

final class _TextInputAmountWidget extends TextInputWidgetBase {
  final AppLocalizationManager localization;
  final void Function(List<Balance>, Balance, List<TokenMarket>, List<Token>)
      onSelectToken;
  final void Function(String) onMaxTap;

  const _TextInputAmountWidget({
    super.obscureText,
    super.autoFocus,
    super.constraintManager,
    super.scrollController,
    super.enable,
    super.inputFormatter,
    super.focusNode,
    super.controller,
    super.hintText,
    super.scrollPadding,
    super.keyBoardType,
    super.maxLength,
    super.onSubmit,
    super.maxLine,
    super.minLine,
    super.onChanged,
    super.physics,
    super.key,
    super.enableClear,
    super.onClear,
    super.boxConstraints,
    required super.appTheme,
    required this.localization,
    required this.onSelectToken,
    required this.onMaxTap,
  });

  @override
  State<StatefulWidget> createState() => _TextInputAmountWidgetState();
}

class _TextInputAmountWidgetState
    extends TextInputWidgetBaseState<_TextInputAmountWidget> {
  AppLocalizationManager get localization => widget.localization;

  @override
  Widget? buildLabel(AppTheme theme) {
    return Text(
      localization.translate(
        LanguageKey.sendScreenAmount,
      ),
      style: AppTypoGraPhy.textSmSemiBold.copyWith(
        color: theme.textPrimary,
      ),
    );
  }

  @override
  Widget inputFormBuilder(BuildContext context, Widget child, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(theme) != null
            ? Column(
                children: [
                  buildLabel(theme)!,
                  const SizedBox(
                    height: BoxSize.boxSize03,
                  ),
                ],
              )
            : const SizedBox(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColorBuilder(theme),
              width: BorderSize.border01,
            ),
            color: theme.bgPrimary,
            borderRadius: BorderRadius.circular(
              BorderRadiusSize.borderRadius03M,
            ),
            boxShadow: buildShadows(
              theme,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.spacing04,
                  vertical: Spacing.spacing02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: child,
                        ),
                        SendTokenMarketsSelector(
                          builder: (tokenMarkets) {
                            return SendSelectedNetworkSelector(
                              builder: (network) {
                                return SendAccountBalanceSelector(
                                  builder: (accountBalance) {
                                    return SendTokenTokensSelector(
                                      builder: (tokens) {
                                        return SendSelectedBalanceSelector(
                                          builder: (balance) {
                                            final token =
                                                tokens.firstWhereOrNull(
                                              (t) => t.id == balance?.tokenId,
                                            );
                                            return GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                widget.onSelectToken(
                                                  network.tokenWithType(
                                                    accountBalance?.balances ??
                                                        [],
                                                    tokens,
                                                  ),
                                                  balance!,
                                                  tokenMarkets,
                                                  tokens,
                                                );
                                              },
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: BoxSize.boxSize03,
                                                  ),
                                                  NetworkImageWidget(
                                                    url: token?.logo ??
                                                        AppLocalConstant
                                                            .auraLogo,
                                                    appTheme: theme,
                                                    width: BoxSize.boxSize05,
                                                    height: BoxSize.boxSize05,
                                                  ),
                                                  const SizedBox(
                                                    width: BoxSize.boxSize03,
                                                  ),
                                                  Text(
                                                    token?.symbol ?? '',
                                                    style: AppTypoGraPhy
                                                        .textSmSemiBold
                                                        .copyWith(
                                                      color: theme.textPrimary,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: BoxSize.boxSize03,
                                                  ),
                                                  SvgPicture.asset(
                                                    AssetIconPath
                                                        .icCommonArrowDown,
                                                    width: BoxSize.boxSize05,
                                                    height: BoxSize.boxSize05,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: BoxSize.boxSize05,
                    ),
                    Text(
                      '~${localization.translate(
                        LanguageKey.commonBalancePrefix,
                      )}0',
                      style: AppTypoGraPhy.textXsRegular.copyWith(
                        color: theme.textTertiary,
                      ),
                    ),
                    const SizedBox(
                      height: BoxSize.boxSize05,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: Spacing.spacing04,
                  horizontal: Spacing.spacing05,
                ),
                decoration: BoxDecoration(
                  color: theme.bgSecondary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(
                      BorderRadiusSize.borderRadius03M,
                    ),
                    bottomLeft: Radius.circular(
                      BorderRadiusSize.borderRadius03M,
                    ),
                  ),
                ),
                child: SendTokenTokensSelector(builder: (tokens) {
                  return SendSelectedBalanceSelector(
                    builder: (balance) {
                      final token = tokens.firstWhereOrNull(
                        (t) => t.id == balance?.tokenId,
                      );
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => widget.onMaxTap(
                              token?.type.formatBalance(
                                    balance?.balance ?? '',
                                    customDecimal: token.decimal,
                                  ) ??
                                  '0',
                            ),
                            child: Text(
                              localization.translate(
                                LanguageKey.sendScreenMax,
                              ),
                              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                                color: theme.textBrandPrimary,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${localization.translate(
                                    LanguageKey.sendScreenBalance,
                                  )}: ',
                                  style: AppTypoGraPhy.textXsRegular.copyWith(
                                    color: theme.textSecondary,
                                  ),
                                ),
                                TextSpan(
                                  text: token?.type.formatBalance(
                                      balance?.balance ?? '',
                                      customDecimal: token.decimal),
                                  style: AppTypoGraPhy.textXsSemiBold.copyWith(
                                    color: theme.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        errorMessage.isNotNullOrEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: BoxSize.boxSize03,
                  ),
                  Text(
                    errorMessage!,
                    style: AppTypoGraPhy.textSmRegular.copyWith(
                      color: theme.textErrorPrimary,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

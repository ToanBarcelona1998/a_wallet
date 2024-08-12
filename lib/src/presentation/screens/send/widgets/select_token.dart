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
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/combine_list_view.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_search_widget.dart';

class _SendSelectTokenWidget extends StatelessWidget {
  final bool isSelected;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final String avatar;
  final String amount;
  final double value;
  final String symbol;
  final String tokenName;

  const _SendSelectTokenWidget({
    required this.isSelected,
    required this.appTheme,
    required this.localization,
    required this.amount,
    required this.avatar,
    required this.value,
    required this.tokenName,
    required this.symbol,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing04,
      ),
      decoration: BoxDecoration(
        color: isSelected ? appTheme.bgBrandPrimary : appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: Row(
        children: [
          NetworkImageWidget(
            url: avatar,
            appTheme: appTheme,
            cacheTarget: BoxSize.boxSize07,
            height: BoxSize.boxSize07,
            width: BoxSize.boxSize07,
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
                  symbol,
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
                  tokenName,
                  style: AppTypoGraPhy.textXsMedium.copyWith(
                    color: appTheme.textTertiary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount.toString(),
                style: AppTypoGraPhy.textMdBold.copyWith(
                  color: appTheme.textPrimary,
                ),
              ),
              const SizedBox(
                height: BoxSize.boxSize02,
              ),
              Text(
                '${localization.translate(LanguageKey.commonBalancePrefix)}${value.formatPrice}',
                style: AppTypoGraPhy.textXsMedium.copyWith(
                  color: appTheme.textTertiary,
                ),
              ),
            ],
          ),
          if (isSelected) ...[
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            SvgPicture.asset(
              AssetIconPath.icCommonYetiHand,
            ),
          ],
        ],
      ),
    );
  }
}

final class SendSelectTokensWidget extends AppBottomSheetBase {
  // List token. It can provide token info.
  final List<Token> tokens;

  // List token market. Display price
  final List<TokenMarket> tokenMarkets;

  // Selected balance
  final Balance currentToken;

  // Display balance with account type
  final List<Balance> balances;

  const SendSelectTokensWidget({
    required super.appTheme,
    required super.localization,
    required this.tokens,
    required this.tokenMarkets,
    required this.currentToken,
    required this.balances,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SendSelectTokensWidgetState();
}

final class _SendSelectTokensWidgetState
    extends AppBottomSheetBaseState<SendSelectTokensWidget> {
  List<Balance> displayTokens = List.empty(growable: true);

  Token? _selectedToken;

  @override
  void initState() {
    _selectedToken = widget.tokens.firstWhereOrNull(
      (e) => e.id == widget.currentToken.tokenId,
    );
    displayTokens.addAll(
      widget.balances,
    );
    super.initState();
  }

  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.sendScreenSelectTokenTitle,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: BoxSize.boxSize14,
        maxHeight: BoxSize.boxSize18,
      ),
      child: CombinedListView(
        onRefresh: () {},
        onLoadMore: () {},
        data: displayTokens,
        builder: (balance, _) {
          final token = widget.tokens
              .firstWhereOrNull((token) => token.id == balance.tokenId);

          final tokenMarket = widget.tokenMarkets.firstWhereOrNull(
            (m) => m.name == token?.tokenName,
          );

          final amount = double.tryParse(
                token?.type.formatBalance(
                      balance.balance,
                      customDecimal: token.decimal,
                    ) ??
                    '0',
              ) ??
              0;

          double currentPrice =
              double.tryParse(tokenMarket?.currentPrice ?? '0') ?? 0;

          double value = 0;
          if (amount == 0 && currentPrice == 0) {
            value = 0;
          } else {
            value = amount * currentPrice;
          }

          bool isSelected = _selectedToken?.id == token?.id;

          return GestureDetector(
            onTap: () {
              if (!isSelected) {
                AppNavigator.pop(balance);
              }
            },
            child: _SendSelectTokenWidget(
              isSelected: isSelected,
              appTheme: appTheme,
              localization: localization,
              amount: amount.toString(),
              avatar: token?.logo ?? '',
              value: value,
              tokenName: token?.tokenName ?? '',
              symbol: token?.symbol ?? '',
            ),
          );
        },
        canLoadMore: false,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.spacing07,
      ),
      child: TextInputSearchWidget(
        appTheme: appTheme,
        hintText: localization.translate(
          LanguageKey.sendScreenSelectTokenHint,
        ),
        onChanged: (name, _) {
          _onFilter(name);
        },
      ),
    );
  }

  void _onFilter(String name) {
    displayTokens.clear();

    if (name.isEmpty) {
      displayTokens.addAll(widget.balances);
    } else {
      // final List<Balance> filterList = widget.tokens
      //     .where(
      //       (e) => e.name?.contains(name) ?? false,
      //     )
      //     .toList();
      //
      // displayTokens.addAll(filterList);
    }

    setState(() {});
  }
}

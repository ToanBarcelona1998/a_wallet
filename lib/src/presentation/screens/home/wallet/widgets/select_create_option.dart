import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

final class WalletSelectCreateOptionWidget extends AppBottomSheetBase {
  const WalletSelectCreateOptionWidget({
    super.key,
    required super.appTheme,
    required super.localization,
  });

  @override
  State<StatefulWidget> createState() =>
      _WalletSelectCreateOptionWidgetState();
}

final class _WalletSelectCreateOptionWidgetState
    extends AppBottomSheetBaseState<WalletSelectCreateOptionWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.walletPageAddTitle,
      ),
      style: AppTypoGraPhy.textMdSemiBold.copyWith(
        color: appTheme.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _option(
          localization.translate(
            LanguageKey.walletPageAdd,
          ),
          AccountCreateType.normal,
        ),
        _option(
          localization.translate(
            LanguageKey.walletPageImport,
          ),
          AccountCreateType.import,
        ),
        _option(
          localization.translate(
            LanguageKey.walletPageSocial,
          ),
          AccountCreateType.social,
        ),
      ],
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _option(String option,AccountCreateType type) {
    return GestureDetector(
      onTap: (){
        AppNavigator.pop(type);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(
          Spacing.spacing04,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            option,
            style: AppTypoGraPhy.textMdSemiBold.copyWith(
              color: appTheme.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

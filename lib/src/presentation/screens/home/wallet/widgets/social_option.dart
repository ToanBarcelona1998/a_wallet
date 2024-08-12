import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

final class WalletSelectSocialOptionWidget extends AppBottomSheetBase {
  const WalletSelectSocialOptionWidget({
    super.key,
    required super.appTheme,
    required super.localization,
  });

  @override
  State<StatefulWidget> createState() => _WalletSelectSocialOptionWidgetState();
}

final class _WalletSelectSocialOptionWidgetState
    extends AppBottomSheetBaseState<WalletSelectSocialOptionWidget> {
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
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        IconWithTextWidget(
          titlePath: LanguageKey.walletPageWalletGoogle,
          svgIconPath: AssetIconPath.icCommonGoogle,
          appTheme: appTheme,
          localization: localization,
          onTap: () {
            AppNavigator.pop(
              Web3AuthLoginProvider.google,
            );
          },
        ),
        const SizedBox(
          height: BoxSize.boxSize06,
        ),
        IconWithTextWidget(
          titlePath: LanguageKey.walletPageWalletTwitter,
          svgIconPath: AssetIconPath.icCommonTwitter,
          appTheme: appTheme,
          localization: localization,
          onTap: () {
            AppNavigator.pop(
              Web3AuthLoginProvider.twitter,
            );
          },
        ),
        const SizedBox(
          height: BoxSize.boxSize06,
        ),
        IconWithTextWidget(
          titlePath: LanguageKey.walletPageWalletApple,
          svgIconPath: AssetIconPath.icCommonApple,
          appTheme: appTheme,
          localization: localization,
          onTap: () {
            AppNavigator.pop(
              Web3AuthLoginProvider.apple,
            );
          },
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
      ],
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }
}

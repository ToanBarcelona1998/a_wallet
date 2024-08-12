import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class WalletAddNewWidget extends AppBottomSheetBase {
  final String address;
  final void Function(String) onAdd;
  final bool Function(String) validator;

  const WalletAddNewWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.address,
    required this.onAdd,
    required this.validator,
  });

  @override
  State<StatefulWidget> createState() => _WalletAddNewWidgetState();
}

final class _WalletAddNewWidgetState
    extends AppBottomSheetBaseState<WalletAddNewWidget> {
  bool _isValid = false;

  String name = '';

  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.walletPageAddTitle,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        RoundBorderTextInputWidget(
          appTheme: appTheme,
          label: localization.translate(
            LanguageKey.walletPageWalletName,
          ),
          hintText: localization.translate(
            LanguageKey.walletPageWalletNameHint,
          ),
          onChanged: (name, isValid) {
            this.name = name;

            _isValid = isValid;

            setState(() {

            });
          },
          constraintManager: ConstraintManager()
            ..custom(
              errorMessage: localization.translate(
                LanguageKey.walletPageWalletAlready,
              ),
              customValid: widget.validator,
            ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        RoundBorderTextInputWidget(
          appTheme: appTheme,
          label: localization.translate(
            LanguageKey.walletPageWalletAddress,
          ),
          enable: false,
          initText: widget.address.addressView,
        ),
        const SizedBox(
          height: BoxSize.boxSize08,
        ),
      ],
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return Column(
      children: [
        PrimaryAppButton(
          text: localization.translate(
            LanguageKey.walletPageAdd,
          ),
          onPress: () {
            AppNavigator.pop();
            widget.onAdd(
              name,
            );
          },
          isDisable: !_isValid,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing06,
        vertical: Spacing.spacing05,
      ),
      constraints: const BoxConstraints(
        minHeight: BoxSize.boxSize14,
        maxHeight: BoxSize.boxSize18 * 1.7,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius06,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: titleBuilder(
                      context,
                    ),
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (widget.onClose != null) {
                      widget.onClose!();
                    } else {
                      AppNavigator.pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(
                      Spacing.spacing03,
                    ),
                    child: SvgPicture.asset(
                      AssetIconPath.icCommonClose,
                    ),
                  ),
                ),
              ],
            ),
            subTitleBuilder(
              context,
            ),
            contentBuilder(
              context,
            ),
            bottomBuilder(
              context,
            ),
          ],
        ),
      ),
    );
  }
}

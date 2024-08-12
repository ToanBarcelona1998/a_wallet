import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/helpers/address_validator.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/presentation/screens/send/send_selector.dart';
import 'package:a_wallet/src/presentation/widgets/switch_widget.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';

final class SendScreenToWidget extends StatelessWidget {
  final AppLocalizationManager localization;
  final void Function(List<AddressBook>) onContactTap;
  final VoidCallback onScanTap;
  final AppTheme appTheme;
  final void Function(bool) onChangeSaved;
  final void Function(String,bool) onAddressChanged;
  final TextEditingController recipientController;
  final AppNetwork appNetwork;

  const SendScreenToWidget({
    required this.appTheme,
    required this.localization,
    required this.onContactTap,
    required this.onChangeSaved,
    required this.onScanTap,
    required this.onAddressChanged,
    required this.recipientController,
    required this.appNetwork,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TextInputSendToWidget(
          appTheme: appTheme,
          localization: localization,
          hintText: localization.translate(
            LanguageKey.sendScreenToHint,
          ),
          onContactTap: onContactTap,
          onScanTap: onScanTap,
          onChanged: onAddressChanged,
          controller: recipientController,
          constraintManager: ConstraintManager()
            ..custom(
              errorMessage: localization.translate(
                LanguageKey.sendScreenInvalidAddress,
              ),
              customValid: (address) {
                // Change later
                return addressInValid(
                  address: address,
                  coinType: appNetwork.coinType,
                );
              },
            ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        Row(
          children: [
            SendIsSavedSelector(
              builder: (isSaved) {
                return SwitchWidget(
                  onChanged: onChangeSaved,
                  isSelected: isSaved,
                  appTheme: appTheme,
                );
              },
            ),
            const SizedBox(
              width: BoxSize.boxSize04,
            ),
            Text(
              localization.translate(
                LanguageKey.sendScreenSaveAddress,
              ),
              style: AppTypoGraPhy.textSmRegular.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
          ],
        ),
        SendIsSavedSelector(
          builder: (isSaved) {
            if (isSaved) {
              return Column(
                children: [
                  const SizedBox(
                    height: BoxSize.boxSize05,
                  ),
                  RoundBorderTextInputWidget(
                    appTheme: appTheme,
                    hintText: localization.translate(
                      LanguageKey.sendScreenSaveAddressNameHint,
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

final class _TextInputSendToWidget extends TextInputWidgetBase {
  final AppLocalizationManager localization;
  final void Function(List<AddressBook>) onContactTap;
  final VoidCallback onScanTap;

  const _TextInputSendToWidget({
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
    required this.onContactTap,
    required this.onScanTap,
  });

  @override
  State<StatefulWidget> createState() => _TextInputSendToState();
}

class _TextInputSendToState
    extends TextInputWidgetBaseState<_TextInputSendToWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    return Text(
      widget.localization.translate(
        LanguageKey.sendScreenTo,
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
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.spacing04,
                    vertical: Spacing.spacing02,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColorBuilder(theme),
                      width: BorderSize.border01,
                    ),
                    color: theme.bgPrimary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        BorderRadiusSize.borderRadius03M,
                      ),
                      bottomLeft: Radius.circular(
                        BorderRadiusSize.borderRadius03M,
                      ),
                    ),
                    boxShadow: buildShadows(
                      theme,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onScanTap,
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetIconPath.icCommonScan,
                            ),
                            const SizedBox(
                              width: BoxSize.boxSize04,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ),
              SendTokenAddressBooksSelector(
                builder: (addressBook) {
                  return GestureDetector(
                    onTap: () {
                      widget.onContactTap(addressBook);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.spacing04,
                        vertical: Spacing.spacing02,
                      ),
                      decoration: BoxDecoration(
                        color: theme.bgSecondary,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(
                            BorderRadiusSize.borderRadius03M,
                          ),
                          bottomRight: Radius.circular(
                            BorderRadiusSize.borderRadius03M,
                          ),
                        ),
                        border: Border.all(
                          color: theme.borderPrimary,
                          width: BorderSize.border01,
                        ),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AssetIconPath.icCommonContact,
                        ),
                      ),
                    ),
                  );
                }
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

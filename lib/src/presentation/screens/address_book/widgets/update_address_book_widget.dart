import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/helpers/address_validator.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressBookUpdateWidget extends AppBottomSheetBase {
  final void Function(String address, String name) onConfirm;
  final String name;
  final String address;

  const AddressBookUpdateWidget({
    required this.onConfirm,
    required this.name,
    required this.address,
    super.key,
    required super.appTheme,
    required super.localization,
  });

  @override
  State<StatefulWidget> createState() => _AddressBookUpdateWidgetState();
}

class _AddressBookUpdateWidgetState
    extends AppBottomSheetBaseState<AddressBookUpdateWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.name;
    _addressController.text = widget.address;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool isValidName = true;
  bool isValidAddress = true;

  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.addressBookScreenEditContactTitle,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    bool isValid = isValidAddress && isValidName;
    return PrimaryAppButton(
      text: localization.translate(
        LanguageKey.addressBookScreenEditContactConfirm,
      ),
      isDisable: !isValid,
      onPress: () {
        AppNavigator.pop();
        widget.onConfirm(
          _addressController.text.trim(),
          _nameController.text.trim(),
        );
      },
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      children: [
        RoundBorderTextInputWidget(
          label: localization.translate(
            LanguageKey.addressBookScreenEditContactName,
          ),
          appTheme: appTheme,
          isRequired: true,
          onChanged: (_, isValid) {
            setState(() {
              isValidName = isValid;
            });
          },
          controller: _nameController,
          maxLength: 255,
          constraintManager: ConstraintManager()
            ..notEmpty(
              errorMessage: localization.translate(
                LanguageKey.addressBookScreenInvalidName,
              ),
            ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        RoundBorderTextInputWidget(
          label: localization.translate(
            LanguageKey.addressBookScreenEditContactAddress,
          ),
          onChanged: (_, isValid) {
            setState(() {
              isValidAddress = isValid;
            });
          },
          controller: _addressController,
          isRequired: true,
          constraintManager: ConstraintManager()
            ..custom(
              customValid: (value) {
                return addressInValid(
                  address: value,
                );
              },
              errorMessage: localization.translate(
                LanguageKey.addressBookScreenInvalidAddress,
              ),
            ),
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
      ],
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
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
        maxHeight: BoxSize.boxSize18 * 1.5,
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

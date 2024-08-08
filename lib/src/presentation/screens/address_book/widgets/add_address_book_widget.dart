import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/helpers/address_validator.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_base.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_base/text_input_manager.dart';
import 'package:flutter/material.dart';

class AddressBookAddWidget extends AppBottomSheetBase {
  final void Function(String address, String name) onConfirm;

  const AddressBookAddWidget({
    required this.onConfirm,
    super.key,
    required super.appTheme,
    required super.localization,
  });

  @override
  State<StatefulWidget> createState() => _AddressBookAddWidgetState();
}

class _AddressBookAddWidgetState
    extends AppBottomSheetBaseState<AddressBookAddWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  bool isValidName = false;
  bool isValidAddress = false;

  @override
  Widget titleBuilder(BuildContext context,) {
    return Text(
      localization.translate(
        LanguageKey.addressBookScreenAddContactTitle,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context,) {
    bool isValid = isValidAddress && isValidName;
    return PrimaryAppButton(
      text: localization.translate(
        LanguageKey.addressBookScreenAddContactConfirm,
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
            LanguageKey.addressBookScreenAddContactName,
          ),
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
            ), appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        RoundBorderTextInputWidget(
          label: localization.translate(
            LanguageKey.addressBookScreenAddContactAddress,
          ),
          appTheme: appTheme,
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
}

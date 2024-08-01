import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:a_wallet/src/navigator.dart';

import 'app_button.dart';
import 'bottom_sheet_base/app_bottom_sheet_base.dart';
import 'slider_base_widget.dart';

class ChangeFeeFormWidget extends AppBottomSheetBase {
  final double currentValue;
  final double max;
  final double min;
  final String Function(double value) convertFee;

  const ChangeFeeFormWidget({
    super.key,
    super.onClose,
    required this.max,
    required this.min,
    required this.currentValue,
    required this.convertFee,
    required super.appTheme,
    required super.localization,
  });

  @override
  State<StatefulWidget> createState() => _ChangeFeeFormWidgetState();
}

class _ChangeFeeFormWidgetState
    extends AppBottomSheetBaseState<ChangeFeeFormWidget> {
  double _value = 0.0;

  @override
  void initState() {
    _value = widget.currentValue;
    super.initState();
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return Column(
      children: [
        PrimaryAppButton(
          text: localization.translate(
            LanguageKey.commonChangeFeeTransactionConfirm,
          ),
          onPress: () {
            AppNavigator.pop(_value);
          },
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      children: [
        CustomSingleSlider(
          max: widget.max,
          min: widget.min,
          onChange: (value) {
            String valueString = (value as double).toStringAsFixed(6);
            setState(() {
              _value = double.parse(valueString);
            });
          },
          current: widget.currentValue,
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.translate(
                LanguageKey.commonChangeFeeTransactionSlower,
              ),
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
            Text(
              localization.translate(
                LanguageKey.commonChangeFeeTransactionFaster,
              ),
              style: AppTypoGraPhy.textSmMedium.copyWith(
                color: appTheme.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize08,
        ),
      ],
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: localization.translate(
                LanguageKey.commonChangeFeeTransactionContent,
              ),
              style: AppTypoGraPhy.textSmRegular.copyWith(
                color: appTheme.textSecondary,
              ),
            ),
            TextSpan(
                text:
                    ' ${widget.convertFee(_value)} ${localization.translate(
                  LanguageKey.commonAura,
                )}',
                style: AppTypoGraPhy.textSmMedium.copyWith(
                  color: appTheme.textPrimary,
                )),
          ]),
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
      ],
    );
  }

  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.commonChangeFeeTransactionTitle,
      ),
      style: AppTypoGraPhy.textLgBold.copyWith(
        color: appTheme.textPrimary,
      ),
    );
  }
}

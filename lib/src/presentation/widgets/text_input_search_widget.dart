import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';

import 'text_input_base/text_input_base.dart';

///region round border text input
final class TextInputSearchWidget extends TextInputWidgetBase {
  final double borderRadius;

  const TextInputSearchWidget({
    this.borderRadius = BorderRadiusSize.borderRadius03M,
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
  });

  @override
  State<StatefulWidget> createState() => TextInputSearchWidgetState();
}

final class TextInputSearchWidgetState
    extends TextInputWidgetBaseState<TextInputSearchWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    return null;
  }

  @override
  Widget inputFormBuilder(BuildContext context, Widget child, AppTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
            borderRadius: BorderRadius.circular(
              widget.borderRadius,
            ),
            boxShadow: buildShadows(
              theme,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              SvgPicture.asset(
                AssetIconPath.icCommonSearch,
              ),
              const SizedBox(
                width: BoxSize.boxSize04,
              ),
              Expanded(
                child: child,
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

///endregion

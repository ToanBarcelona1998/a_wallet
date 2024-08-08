import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';

import 'text_input_manager.dart';

///region text input base
class TextInputWidgetBase extends StatefulWidget {
  final TextEditingController? controller;
  final ConstraintManager? constraintManager;
  final String? hintText;
  final VoidCallback? onClear;
  final void Function(String, bool)? onChanged;
  final void Function(String, bool)? onSubmit;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final bool enable;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final EdgeInsets scrollPadding;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyBoardType;
  final bool enableClear;
  final BoxConstraints? boxConstraints;
  final AppTheme appTheme;

  const TextInputWidgetBase({
    super.key,
    this.constraintManager,
    this.onClear,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmit,
    this.maxLength,
    this.minLine,
    this.maxLine,
    this.enable = true,
    this.autoFocus = false,
    this.obscureText = false,
    this.enableClear = false,
    this.focusNode,
    this.scrollPadding = const EdgeInsets.symmetric(),
    this.scrollController,
    this.physics,
    this.inputFormatter,
    this.keyBoardType,
    this.boxConstraints,
    required this.appTheme,
  });

  @override
  State<StatefulWidget> createState() {
    return TextInputWidgetBaseState<TextInputWidgetBase>();
  }
}

class TextInputWidgetBaseState<T extends TextInputWidgetBase> extends State<T> {
  late TextEditingController _controller;

  String? errorMessage;

  late FocusNode _focusNode;

  bool enableClear = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget? buildLabel(AppTheme theme) {
    return null;
  }

  ///region build input form builder
  Widget inputFormBuilder(
    BuildContext context,
    Widget child,
    AppTheme theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(theme) != null
            ? Column(
                children: [
                  buildLabel(theme)!,
                  const SizedBox(
                    height: BoxSize.boxSize01,
                  ),
                ],
              )
            : const SizedBox(),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.spacing0,
            vertical: Spacing.spacing01,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: borderColorBuilder(theme),
                width: BorderSize.border01,
              ),
            ),
            boxShadow: buildShadows(
              theme,
            ),
          ),
          alignment: Alignment.center,
          child: child,
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

  ///endregion

  ///region build text input base
  Widget buildTextInput(AppTheme theme) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: AppTypoGraPhy.textSmRegular.copyWith(
              color: theme.textPrimary,
            ),
            enabled: widget.enable,
            autofocus: widget.autoFocus,
            maxLines: widget.maxLine,
            maxLength: widget.maxLength,
            minLines: widget.minLine,
            obscureText: widget.obscureText,
            onSubmitted: (value) {
              if (widget.onSubmit != null) {
                widget.onSubmit!(value, errorMessage.isEmptyOrNull);
              }
            },
            focusNode: _focusNode,
            showCursor: true,
            scrollPadding: widget.scrollPadding,
            scrollController: widget.scrollController,
            scrollPhysics: widget.physics,
            inputFormatters: widget.inputFormatter,
            keyboardType: widget.keyBoardType,
            onChanged: (value) {
              if (widget.constraintManager != null) {
                if (widget.constraintManager!.isValidOnChanged) {
                  validate();
                }
              }

              widget.onChanged?.call(value, errorMessage.isEmptyOrNull);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintStyle: AppTypoGraPhy.textSmRegular.copyWith(
                color: theme.textPlaceholder,
              ),
              constraints: widget.boxConstraints,

              /// This line may be fix in the future.
              counterText: '',
            ),
          ),
        ),
        if (errorMessage.isNotNullOrEmpty) ...[
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          SvgPicture.asset(
            AssetIconPath.icCommonInputError,
          ),
        ],
        if (enableClear && widget.enableClear) ...[
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          GestureDetector(
            onTap: widget.onClear,
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(
              AssetIconPath.icCommonClose,
            ),
          ),
        ]
      ],
    );
  }

  ///endregion

  @override
  Widget build(BuildContext context) {
    return inputFormBuilder(
      context,
      buildTextInput(widget.appTheme),
      widget.appTheme,
    );
  }

  String value() => _controller.text;

  void setValue(String value) {
    _controller.text = value;

    validate();

    widget.onChanged?.call(value, errorMessage.isEmptyOrNull);
  }

  late bool isFocus;

  Color borderColorBuilder(AppTheme theme) {
    Color color = theme.borderPrimary;
    if (isFocus) {
      color = theme.borderBrand;
    }

    if (errorMessage.isEmptyOrNull) {
      if (isFocus) return color;

      color = theme.borderPrimary;
    } else {
      color = theme.borderErrorSolid;
    }

    return color;
  }

  List<BoxShadow>? buildShadows(AppTheme appTheme) {
    List<BoxShadow>? boxShadows;

    BoxShadow? boxShadow;

    if (isFocus) {
      boxShadows = List.empty(growable: true);

      boxShadow = BoxShadow(
        blurRadius: 0,
        spreadRadius: 3,
        offset: const Offset(0, 0),
        blurStyle: BlurStyle.solid,
        color: appTheme.borderBrand.withOpacity(0.14),
      );
    }

    if (errorMessage.isEmptyOrNull) {
      if (isFocus) return boxShadows?..add(boxShadow!);

      boxShadow = null;
    } else {
      boxShadow = BoxShadow(
        blurRadius: 0,
        spreadRadius: 3,
        offset: const Offset(0, 0),
        blurStyle: BlurStyle.solid,
        color: appTheme.borderErrorSolid.withOpacity(0.24),
      );

      boxShadows?.add(boxShadow);
    }

    return boxShadows;
  }

  void _addFocusListener() {
    if (_focusNode.hasFocus) {
      isFocus = true;
    } else {
      isFocus = false;
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onTextInputChange() {
    if (!widget.enableClear) return;
    if (_controller.text.trim().isEmpty) {
      enableClear = false;
    } else {
      enableClear = true;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();

    _controller.addListener(_onTextInputChange);

    _focusNode = widget.focusNode ?? FocusNode(canRequestFocus: true);

    isFocus = widget.autoFocus;

    _focusNode.addListener(_addFocusListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextInputChange);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_addFocusListener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != null &&
        oldWidget.controller?.text != _controller.text) {
      _controller = widget.controller!;
      _controller.addListener(_onTextInputChange);
    }
  }

  bool validate() {
    ConstraintManager? constraintManager = widget.constraintManager;
    errorMessage = null;
    if (constraintManager != null) {
      final CheckResult result = constraintManager.checkAll(
        _controller.text,
      );
      if (!result.isSuccess) {
        errorMessage = result.message;
      } else {
        errorMessage = null;
      }
      setState(() {});
      return result.isSuccess;
    }
    setState(() {});
    return true;
  }
}

///endregion

///region text input normal
final class TextInputNormalWidget extends TextInputWidgetBase {
  final String? label;
  final bool isRequired;

  const TextInputNormalWidget({
    this.label,
    this.isRequired = false,
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
    super.boxConstraints,
    super.enableClear,
    super.key,
    required super.appTheme,
  });

  @override
  State<StatefulWidget> createState() => TextInputNormalState();
}

final class TextInputNormalState
    extends TextInputWidgetBaseState<TextInputNormalWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    if (widget.label.isEmptyOrNull) {
      return null;
    }

    if (widget.isRequired) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.label,
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textPrimary,
              ),
            ),
            TextSpan(
              text: ' *',
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textErrorPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      widget.label!,
      style: AppTypoGraPhy.textSmSemiBold.copyWith(
        color: theme.textPrimary,
      ),
    );
  }
}

///endregion

///region text input suffix widget
final class TextInputNormalSuffixWidget extends TextInputWidgetBase {
  final String? label;
  final bool isRequired;
  final Widget suffix;
  final VoidCallback? onSuffixTap;

  const TextInputNormalSuffixWidget({
    this.label,
    this.isRequired = false,
    required this.suffix,
    this.onSuffixTap,
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
    super.boxConstraints,
    super.enableClear,
    super.key,
    required super.appTheme,
  });

  @override
  State<StatefulWidget> createState() => TextInputNormalSuffixState();
}

final class TextInputNormalSuffixState
    extends TextInputWidgetBaseState<TextInputNormalSuffixWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    if (widget.label.isEmptyOrNull) {
      return null;
    }

    if (widget.isRequired) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.label,
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textPrimary,
              ),
            ),
            TextSpan(
              text: ' *',
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textErrorPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      widget.label!,
      style: AppTypoGraPhy.textSmSemiBold.copyWith(
        color: theme.textPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return inputFormBuilder(
      context,
      Row(
        children: [
          Expanded(
            child: buildTextInput(widget.appTheme),
          ),
          const SizedBox(
            width: BoxSize.boxSize04,
          ),
          GestureDetector(
            onTap: widget.onSuffixTap,
            behavior: HitTestBehavior.opaque,
            child: widget.suffix,
          ),
        ],
      ),
      widget.appTheme,
    );
  }
}

///endregion

///region text input with only text field widget
final class TextInputOnlyTextFieldWidget extends TextInputWidgetBase {
  const TextInputOnlyTextFieldWidget({
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
  State<StatefulWidget> createState() => TextInputOnlyTextFieldWidgetState();
}

final class TextInputOnlyTextFieldWidgetState
    extends TextInputWidgetBaseState<TextInputOnlyTextFieldWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return buildTextInput(
      widget.appTheme,
    );
  }
}

///endregion

///region round border text input
final class RoundBorderTextInputWidget extends TextInputWidgetBase {
  final String? label;
  final bool isRequired;
  final double borderRadius;

  const RoundBorderTextInputWidget({
    this.isRequired = false,
    this.label,
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
  State<StatefulWidget> createState() => RoundBorderTextInputWidgetState();
}

final class RoundBorderTextInputWidgetState
    extends TextInputWidgetBaseState<RoundBorderTextInputWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    if (widget.label.isEmptyOrNull) {
      return null;
    }

    if (widget.isRequired) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.label,
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textPrimary,
              ),
            ),
            TextSpan(
              text: ' *',
              style: AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textErrorPrimary,
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      widget.label!,
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
          child: child,
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

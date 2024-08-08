import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';

import 'text_input_base/text_input_base.dart';
import 'text_input_base/text_input_manager.dart';

/// Extends input base
final class _FillWordInputWidget extends TextInputWidgetBase {
  final EdgeInsets? padding;

  const _FillWordInputWidget({
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
    this.padding,
    required super.appTheme,
  });

  @override
  State<StatefulWidget> createState() => _FillWordInputWidgetState();
}

final class _FillWordInputWidgetState
    extends TextInputWidgetBaseState<_FillWordInputWidget> {
  @override
  Widget? buildLabel(AppTheme theme) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: Spacing.spacing03,
          ),
      decoration: BoxDecoration(
        color: widget.appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius03M,
        ),
        border: Border.all(
          color: borderColorBuilder(
            widget.appTheme,
          ),
        ),
        boxShadow: buildShadows(
          widget.appTheme,
        ),
      ),
      child: buildTextInput(
        widget.appTheme,
      ),
    );
  }
}

final class _FillWordItemWidget extends StatelessWidget {
  final int position;
  final AppTheme appTheme;
  final GlobalKey<_FillWordInputWidgetState> textFiledKey;
  final void Function(String) onChanged;
  final EdgeInsets? padding;

  const _FillWordItemWidget({
    required this.appTheme,
    required this.position,
    required this.textFiledKey,
    required this.onChanged,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: BoxSize.boxSize07,
            minWidth: BoxSize.boxSize07,
          ),
          child: Text(
            '${position.toString()}.',
            style: AppTypoGraPhy.textSmSemiBold.copyWith(
              color: appTheme.textTertiary,
            ),
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize01,
        ),
        Expanded(
          child: _FillWordInputWidget(
            key: textFiledKey,
            onChanged: (value, _) {
              onChanged(value);
            },
            maxLine: 1,
            appTheme: appTheme,
          ),
        ),
      ],
    );
  }
}

class FillWordsWidget extends StatefulWidget {
  final int wordCount;
  final int crossAxisCount;
  final AppTheme appTheme;
  final double? crossSpacing;
  final double? mainSpacing;
  final void Function(String, bool)? onWordChanged;
  final EdgeInsets? contentPadding;
  final ConstraintManager? constraintManager;

  const FillWordsWidget({
    this.wordCount = 12,
    this.crossAxisCount = 3,
    required this.appTheme,
    this.crossSpacing,
    this.mainSpacing,
    this.onWordChanged,
    this.contentPadding,
    this.constraintManager,
    super.key,
  }) : assert(wordCount % crossAxisCount == 0);

  @override
  State<FillWordsWidget> createState() => FillWordsWidgetState();
}

class FillWordsWidgetState extends State<FillWordsWidget> {
  final List<GlobalKey<_FillWordInputWidgetState>> _keys =
      List.empty(growable: true);

  final List<String> _words = List.empty(growable: true);

  String? errorMessage;

  void _initKey() {
    _keys.clear();
    _words.clear();
    for (int i = 0; i < widget.wordCount; i++) {
      _words.add('');
      _keys.add(
        GlobalKey<_FillWordInputWidgetState>(),
      );
    }
  }

  @override
  void initState() {
    _initKey();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FillWordsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.wordCount != oldWidget.wordCount) {
      _initKey();
    }
  }

  void _onChange(String value, int index) {
    _words[index] = value;
  }

  void fillWord(String text) {
    final List<String> words = text.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (_keys.constantIndex(i)) {
        final GlobalKey<_FillWordInputWidgetState> key = _keys[i];

        key.currentState?.setValue(
          words[i],
        );
      }
    }
  }

  String getValue() {
    return _words.join(' ');
  }

  bool validate() {
    ConstraintManager? constraintManager = widget.constraintManager;

    errorMessage = null;
    if (constraintManager != null) {
      final CheckResult result = constraintManager.checkAll(
        _words.join(' '),
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

  @override
  void dispose() {
    _words.clear();
    errorMessage = null;
    _keys.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: List.generate(
            widget.wordCount ~/ widget.crossAxisCount,
            (cIndex) {
              return Row(
                children: List.generate(
                  widget.crossAxisCount,
                  (rIndex) {
                    final index = cIndex * widget.crossAxisCount + rIndex;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.crossSpacing ?? Spacing.spacing02,
                          vertical: widget.mainSpacing ?? Spacing.spacing03,
                        ),
                        child: _FillWordItemWidget(
                          appTheme: widget.appTheme,
                          position: index + 1,
                          textFiledKey: _keys[index],
                          onChanged: (value) {
                            _onChange(value, index);

                            if (widget.constraintManager?.isValidOnChanged ??
                                false) {
                              final bool isValid = validate();

                              widget.onWordChanged?.call(
                                _words.join(' '),
                                isValid,
                              );
                            }
                          },
                          padding: widget.contentPadding,
                          key: ValueKey(
                            index,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
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
                      color: widget.appTheme.textErrorPrimary,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

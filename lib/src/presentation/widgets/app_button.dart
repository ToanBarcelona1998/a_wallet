import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme_builder.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

class _AppButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final Widget? suffix;
  final TextStyle textStyle;

  final Color? color;
  final Color? disableColor;
  final Gradient? gradient;

  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final double? minWidth;

  final bool disabled;
  final bool loading;

  final void Function()? onPress;

  final AppTheme theme;

  final Color? borderColor;

  _AppButton({
    super.key,
    required this.text,
    this.onPress,
    this.color,
    this.borderColor,
    this.disableColor,
    this.gradient,
    this.minWidth,
    this.leading,
    this.suffix,
    bool? loading,
    bool? disabled,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
    required this.theme,
    required this.textStyle,
  })  : assert(color == null || gradient == null),
        loading = loading ?? false,
        disabled = (disabled ?? false) || (loading ?? false),
        padding = padding ?? const EdgeInsets.all(Spacing.spacing05),
        borderRadius = borderRadius ??
            BorderRadius.circular(BorderRadiusSize.borderRadiusRound);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.bgPrimary,
      borderRadius: borderRadius,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          color: disabled ? disableColor : color,
          gradient: disabled ? null : gradient,
          borderRadius: borderRadius,
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                )
              : null,
        ),
        child: InkWell(
          splashColor: theme.bgBrandPrimary,
          highlightColor: theme.bgBrandSolidHover,
          onTap: disabled ? null : onPress,
          child: Container(
            constraints:
                minWidth != null ? BoxConstraints(minWidth: minWidth!) : null,
            padding: padding,
            alignment: Alignment.center,
            child: loading
                ? SizedBox.square(
                    dimension: 19.2,
                    child: CircularProgressIndicator(
                      color: theme.utilityBrand500,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      leading ?? const SizedBox.shrink(),
                      if (leading != null)
                        const SizedBox(
                          width: BoxSize.boxSize03,
                        ),
                      Text(
                        text,
                        style: textStyle,
                      ),
                      if (suffix != null)
                        const SizedBox(
                          width: BoxSize.boxSize03,
                        ),
                      suffix ?? const SizedBox.shrink(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

final class PrimaryAppButton extends StatelessWidget {
  final String text;
  final Widget? leading;
  final Widget? suffix;
  final bool? isDisable;
  final VoidCallback? onPress;
  final double? minWidth;
  final Color? backGroundColor;
  final TextStyle? textStyle;
  final bool loading;

  const PrimaryAppButton({
    super.key,
    required this.text,
    this.isDisable,
    this.leading,
    this.suffix,
    this.onPress,
    this.minWidth,
    this.backGroundColor,
    this.textStyle,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return _AppButton(
          text: text,
          disabled: isDisable,
          onPress: onPress,
          color: backGroundColor ?? theme.bgBrandSolid,
          disableColor: theme.bgDisabled,
          minWidth: minWidth,
          textStyle: textStyle ??
              (isDisable == true
                  ? AppTypoGraPhy.textMdSemiBold.copyWith(
                      color: theme.textDisabled,
                    )
                  : AppTypoGraPhy.textMdSemiBold.copyWith(
                      color: theme.textPrimaryOnBrand,
                    )),
          theme: theme,
          leading: leading,
          suffix: suffix,
          loading: loading,
        );
      },
    );
  }
}

final class BorderAppButton extends StatelessWidget {
  final String text;
  final bool? isDisable;
  final VoidCallback? onPress;
  final double? minWidth;
  final Color? borderColor;
  final Color? textColor;
  final Widget? leading;
  final Widget? suffix;

  const BorderAppButton({
    super.key,
    required this.text,
    this.isDisable,
    this.onPress,
    this.minWidth,
    this.borderColor,
    this.textColor,
    this.leading,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return _AppButton(
          text: text,
          disabled: isDisable,
          onPress: onPress,
          minWidth: minWidth,
          textStyle: AppTypoGraPhy.textSmSemiBold.copyWith(
            color: textColor ?? theme.textSecondary,
          ),
          theme: theme,
          borderColor: borderColor ?? theme.borderPrimary,
          suffix: suffix,
          leading: leading,
        );
      },
    );
  }
}

final class TextAppButton extends StatelessWidget {
  final String text;
  final bool? isDisable;
  final VoidCallback? onPress;
  final double? minWidth;
  final Widget? leading;
  final Widget? suffix;
  final TextStyle? style;

  const TextAppButton({
    super.key,
    required this.text,
    this.style,
    this.isDisable,
    this.onPress,
    this.minWidth,
    this.leading,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return _AppButton(
          text: text,
          disabled: isDisable,
          onPress: onPress,
          color: theme.bgPrimary,
          minWidth: minWidth,
          textStyle: style ??
              AppTypoGraPhy.textSmSemiBold.copyWith(
                color: theme.textSecondary,
              ),
          theme: theme,
          suffix: suffix,
          leading: leading,
        );
      },
    );
  }
}

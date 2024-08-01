import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

class BoxWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double radius;
  final AppTheme appTheme;
  final VoidCallback ?onTap;

  const BoxWidget({
    this.child,
    this.color,
    this.height,
    this.width,
    this.padding,
    required this.appTheme,
    this.radius = BorderRadiusSize.borderRadius03M,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding ??
            const EdgeInsets.all(
              Spacing.spacing02,
            ),
        decoration: BoxDecoration(
          color: color ?? appTheme.bgPrimary,
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        child: child,
      ),
    );
  }
}

class BoxBorderWidget extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final double radius;
  final double borderWidth;
  final AppTheme appTheme;
  final VoidCallback ?onTap;

  const BoxBorderWidget({
    this.child,
    this.color,
    this.height,
    this.width,
    this.padding,
    this.radius = BorderRadiusSize.borderRadius03M,
    this.borderWidth = BorderSize.border01,
    this.borderColor,
    required this.appTheme,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: width,
        padding: padding ??
            const EdgeInsets.all(
              Spacing.spacing02,
            ),
        decoration: BoxDecoration(
          color: color ?? appTheme.bgPrimary,
          borderRadius: BorderRadius.circular(
            radius,
          ),
          border: Border.all(
            color: borderColor ?? appTheme.borderPrimary,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}

final class BoxIconWidget extends StatelessWidget {
  final String svg;
  final Color? color;
  final Color? svgColor;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double? height;
  final double? width;
  final double? icHeight;
  final double? icWidth;
  final AppTheme appTheme;
  final VoidCallback ?onTap;

  const BoxIconWidget({
    required this.svg,
    this.color,
    this.svgColor,
    this.padding,
    this.height,
    this.icHeight,
    this.width,
    this.icWidth,
    required this.appTheme,
    this.radius = BorderRadiusSize.borderRadius03M,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      height: height,
      width: width,
      padding: padding,
      color: color,
      radius: radius,
      appTheme: appTheme,
      onTap: onTap,
      child: SvgPicture.asset(
        svg,
        colorFilter: svgColor != null
            ? ColorFilter.mode(
                svgColor!,
                BlendMode.srcIn,
              )
            : null,
        width: icWidth,
        height: icHeight,
      ),
    );
  }
}

final class BoxBorderTextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final double? height;
  final double? width;
  final TextStyle? style;
  final AppTheme appTheme;
  final double borderWidth;
  final Color? borderColor;
  final VoidCallback ?onTap;

  const BoxBorderTextWidget({
    required this.text,
    this.color,
    this.padding,
    this.height,
    this.width,
    this.style,
    required this.appTheme,
    this.radius = BorderRadiusSize.borderRadius03M,
    this.borderWidth = BorderSize.border01,
    this.borderColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BoxBorderWidget(
      height: height,
      width: width,
      padding: padding,
      color: color,
      radius: radius,
      appTheme: appTheme,
      borderWidth: borderWidth,
      borderColor: borderColor,
      onTap: onTap,
      child: Text(
        text,
        style: style ??
            AppTypoGraPhy.textSmSemiBold.copyWith(
              color: appTheme.textSecondary,
            ),
      ),
    );
  }
}

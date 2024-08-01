import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';

class HoLiZonTalDividerWidget extends StatelessWidget {
  final Color? dividerColor;
  final double? width;
  final double? height;
  final AppTheme appTheme;

  const HoLiZonTalDividerWidget({
    this.dividerColor,
    this.width,
    this.height,
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing03,
        vertical: Spacing.spacing02,
      ),
      color: dividerColor ?? appTheme.borderTertiary,
      height: height ?? BoxSize.boxSize0,
      width: width,
    );
  }
}

class HoLiZonTalDividerWithTextWidget extends StatelessWidget {
  final String text;
  final Color? dividerColor;
  final AppTheme appTheme;

  const HoLiZonTalDividerWithTextWidget({
    super.key,
    required this.text,
    required this.appTheme,
    this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing03,
        vertical: Spacing.spacing02,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: dividerColor ?? appTheme.borderTertiary,
              height: BoxSize.boxSize0,
              margin: const EdgeInsets.only(
                right: Spacing.spacing04,
              ),
            ),
          ),
          Text(
            text,
            style: AppTypoGraPhy.textSmSemiBold.copyWith(
              color: appTheme.textTertiary,
            ),
          ),
          Expanded(
            child: Container(
              color: dividerColor ?? appTheme.borderTertiary,
              height: BoxSize.boxSize0,
              margin: const EdgeInsets.only(
                left: Spacing.spacing04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerSeparator extends StatelessWidget {
  const DividerSeparator({
    super.key,
    this.height = 1,
    this.color,
    required this.appTheme,
  });
  final double height;
  final Color? color;
  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color ?? appTheme.borderTertiary,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

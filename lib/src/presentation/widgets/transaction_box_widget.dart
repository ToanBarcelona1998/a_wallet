import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

class TransactionBoxWidget extends StatelessWidget {
  final AppTheme appTheme;
  final Widget child;
  final EdgeInsets? padding;

  const TransactionBoxWidget({
    required this.appTheme,
    required this.child,
    this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: Spacing.spacing03,
            vertical: Spacing.spacing04,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
        color: appTheme.bgDisabled,
      ),
      child: child,
    );
  }
}

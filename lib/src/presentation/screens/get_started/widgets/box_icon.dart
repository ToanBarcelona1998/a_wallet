import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

class GetStartedBoxIconWidget extends StatelessWidget {
  final String icPath;
  final VoidCallback onTap;
  final AppTheme appTheme;

  const GetStartedBoxIconWidget({
    required this.onTap,
    required this.icPath,
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(
          Spacing.spacing04,
        ),
        decoration: BoxDecoration(
          color: appTheme.bgPrimary,
          borderRadius: BorderRadius.circular(
            BorderRadiusSize.borderRadiusRound,
          ),
          border: Border.all(
            color: appTheme.borderSecondary,
          ),
        ),
        child: SvgPicture.asset(
          icPath,
        ),
      ),
    );
  }
}

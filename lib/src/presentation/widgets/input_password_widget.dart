import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

class InputPasswordWidget extends StatelessWidget {
  final int length;
  final int fillIndex;
  final AppTheme appTheme;

  const InputPasswordWidget({
    required this.length,
    required this.appTheme,
    required this.fillIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          length,
              (index) {
            bool isFill = fillIndex >= 0 && index <= fillIndex;
            return Container(
              height: BoxSize.boxSize04,
              width: BoxSize.boxSize04,
              margin: const EdgeInsets.only(
                right: Spacing.spacing06,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFill ? appTheme.utilityBrand300 : appTheme.bgSecondary,
                border: isFill
                    ? null
                    : Border.all(
                  color: appTheme.borderSecondary,
                  width: BorderSize.border01,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

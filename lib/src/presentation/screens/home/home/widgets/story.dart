import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/circle_avatar_widget.dart';
import 'package:a_wallet/src/presentation/widgets/gradient_border_widget.dart';

class HomePageStoryWidget extends StatelessWidget {
  final String thumbnail;
  final String title;
  final AppTheme appTheme;

  const HomePageStoryWidget({
    required this.thumbnail,
    required this.title,
    required this.appTheme,
    super.key,
  });

  Gradient get storyGradient => LinearGradient(
        colors: [
          appTheme.utilityCyan300,
          appTheme.utilityBlue300,
          appTheme.utilityPink300,
          appTheme.utilityYellow300,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientBorderWidget(
          gradient: storyGradient,
          strokeWidth: BorderSize.border02,
          child: Padding(
            padding: const EdgeInsets.all(
              Spacing.spacing02,
            ),
            child: CircleAvatarWidget(
              image: NetworkImage(
                thumbnail,
              ),
              radius: BorderRadiusSize.borderRadius04M,
            ),
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize03,
        ),
        Text(
          title,
          style: AppTypoGraPhy.text2xsRegular.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserSuggestionWidget extends StatelessWidget {
  final String logo;
  final String name;
  final String description;
  final AppTheme appTheme;
  final Widget suffix;

  const BrowserSuggestionWidget({
    super.key,
    required this.name,
    required this.description,
    required this.logo,
    required this.appTheme,
    required this.suffix,
  });

  static const double _size = 50;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            BorderRadiusSize.borderRadiusRound,
          ),
          child: NetworkImageWidget(
            url: logo,
            width: _size,
            height: _size,
            appTheme: appTheme,
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize04,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: AppTypoGraPhy.displayMdBold.copyWith(
                  color: appTheme.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: BoxSize.boxSize01,
              ),
              Text(
                description,
                style: AppTypoGraPhy.textSmMedium.copyWith(
                  color: appTheme.textSecondary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: BoxSize.boxSize05,
        ),
        suffix,
      ],
    );
  }
}

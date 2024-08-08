import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

abstract class BrowserSearchSuggestionWidget extends StatelessWidget {
  final String name;
  final String description;
  final AppTheme appTheme;
  final VoidCallback? onTap;

  const BrowserSearchSuggestionWidget({
    required this.name,
    required this.description,
    required this.appTheme,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          logoBuilder(context, appTheme),
          const SizedBox(
            width: BoxSize.boxSize05,
          ),
          Expanded(
            child: contentBuilder(context, appTheme),
          ),
          const SizedBox(
            width: BoxSize.boxSize05,
          ),
          suffixBuilder(context, appTheme),
        ],
      ),
    );
  }

  Widget logoBuilder(BuildContext context, AppTheme appTheme);

  Widget suffixBuilder(
    BuildContext context,
    AppTheme appTheme,
  ){
    return SvgPicture.asset(
      AssetIconPath.icCommonArrowNext,
    );
  }

  Widget contentBuilder(
    BuildContext context,
    AppTheme appTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: AppTypoGraPhy.textLgBold.copyWith(
            color: appTheme.textPrimary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize01,
        ),
        Text(
          description,
          style: AppTypoGraPhy.textSmMedium.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class BrowserSearchEcosystemSuggestionWidget extends BrowserSearchSuggestionWidget {
  final String logo;
  const BrowserSearchEcosystemSuggestionWidget({
    super.key,
    required super.name,
    required super.description,
    required this.logo,
    required super.appTheme,
    super.onTap,
  });

  static const double _size = 50;

  @override
  Widget logoBuilder(BuildContext context, AppTheme appTheme) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        BorderRadiusSize.borderRadiusRound,
      ),
      child: NetworkImageWidget(
        url: logo,
        cacheTarget: _size * 4,
        height: _size,
        width: _size,
        appTheme: appTheme,
      ),
    );
  }
}

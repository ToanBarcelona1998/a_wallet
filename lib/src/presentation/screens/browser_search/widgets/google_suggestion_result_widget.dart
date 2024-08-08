import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'browser_suggestion_widget.dart';

class BrowserSearchGoogleSuggestionResultWidget
    extends BrowserSearchSuggestionWidget {
  const BrowserSearchGoogleSuggestionResultWidget({
    super.key,
    required super.description,
    required super.appTheme,
    required super.name,
    super.onTap,
  });

  @override
  Widget logoBuilder(
    BuildContext context,
    AppTheme appTheme,
  ) {
    return SvgPicture.asset(
      AssetIconPath.icCommonGoogle,
    );
  }
}

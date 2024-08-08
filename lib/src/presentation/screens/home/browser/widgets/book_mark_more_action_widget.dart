import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserPageBookMarkMoreActionWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final VoidCallback onDelete;

  const BrowserPageBookMarkMoreActionWidget({
    required this.appTheme,
    required this.localization,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      color: appTheme.bgPrimary,
      child: SvgPicture.asset(
        AssetIconPath.icCommonAdd,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: EdgeInsets.zero,
            onTap: onDelete,
            child: _BookMarkPopupItemWidget(
              titlePath: LanguageKey.browserPageDelete,
              svgIconPath: AssetIconPath.icCommonDelete,
              appTheme: appTheme,
              localization: localization,
            ),
          ),
        ];
      },
    );
  }
}

final class _BookMarkPopupItemWidget extends StatelessWidget {
  final String titlePath;
  final String svgIconPath;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const _BookMarkPopupItemWidget({
    required this.titlePath,
    required this.svgIconPath,
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.w * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing04,
        ),
        child: IconWithTextWidget(
          titlePath: titlePath,
          svgIconPath: svgIconPath,
          appTheme: appTheme,
          localization: localization,
        ),
      ),
    );
  }
}

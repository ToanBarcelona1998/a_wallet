import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';
import 'package:flutter/material.dart';

class BrowserTabManagementBottomWidget extends StatelessWidget {
  final VoidCallback onCloseAll;
  final VoidCallback onAddNewTab;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const BrowserTabManagementBottomWidget({
    required this.onAddNewTab,
    required this.onCloseAll,
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing06,
        vertical: Spacing.spacing05,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgPrimary,
        border: Border(
          top: BorderSide(
            color: appTheme.borderPrimary,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onCloseAll,
            child: IconWithTextWidget(
              titlePath: LanguageKey.browserTabManagementScreenCloseAll,
              svgIconPath: AssetIconPath.icCommonClose,
              appTheme: appTheme,
              localization: localization,
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onAddNewTab,
            child: IconWithTextWidget(
              titlePath: LanguageKey.browserTabManagementScreenNewTab,
              svgIconPath: AssetIconPath.icCommonAdd,
              appTheme: appTheme,
              localization: localization,
            ),
          ),
        ],
      ),
    );
  }
}

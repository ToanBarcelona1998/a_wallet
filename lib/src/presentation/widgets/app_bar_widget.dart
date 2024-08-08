import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:a_wallet/src/navigator.dart';

abstract class _AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final double? leadingWidth;
  final Widget? title;
  final String? titleKey;
  final bool isLeftActionActive;

  const _AppBarBase({
    this.leadingWidth,
    this.onBack,
    required this.appTheme,
    required this.localization,
    this.titleKey,
    this.title,
    required this.isLeftActionActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leadingBuilder(context, appTheme, localization) ??
          (isLeftActionActive
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (onBack == null) {
                      AppNavigator.pop();
                    } else {
                      onBack!.call();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.spacing04,
                    ),
                    child: SvgPicture.asset(
                      AssetIconPath.icCommonArrowBack,
                      height: BoxSize.boxSize07,
                      width: BoxSize.boxSize07,
                    ),
                  ),
                )
              : null),
      leadingWidth: leadingWidth,
      title: titleBuilder(context, appTheme, localization),
      centerTitle: true,
      bottom: bottomBuilder(appTheme, localization),
      actions: actionBuilders(context, appTheme, localization),
      bottomOpacity: 0,
      backgroundColor: appTheme.bgPrimary,
      elevation: 0,
    );
  }

  Widget? leadingBuilder(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return null;
  }

  List<Widget>? actionBuilders(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return null;
  }

  PreferredSizeWidget? bottomBuilder(
      AppTheme appTheme, AppLocalizationManager localization) {
    return null;
  }

  Widget? titleBuilder(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    if (title != null) {
      return title;
    }

    if (titleKey.isNotNullOrEmpty) {
      return Text(
        localization.translate(titleKey!),
        style: AppTypoGraPhy.textMdBold.copyWith(
          color: appTheme.textPrimary,
        ),
      );
    }

    return null;
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight +
            (bottomBuilder(appTheme, localization)?.preferredSize.height ??
                BoxSize.boxSizeNone),
      );
}

/// region app bar with title non leading
class AppBarDefault extends _AppBarBase {
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const AppBarDefault({
    required super.appTheme,
    super.key,
    super.onBack,
    super.title,
    this.leading,
    super.titleKey,
    this.actions,
    this.bottom,
    required super.localization,
    super.leadingWidth,
    super.isLeftActionActive = true,
  });

  @override
  List<Widget>? actionBuilders(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return actions;
  }

  @override
  PreferredSizeWidget? bottomBuilder(
      AppTheme appTheme, AppLocalizationManager localization) {
    return bottom;
  }

  @override
  Widget? leadingBuilder(BuildContext context, AppTheme appTheme,
      AppLocalizationManager localization) {
    return leading;
  }
}

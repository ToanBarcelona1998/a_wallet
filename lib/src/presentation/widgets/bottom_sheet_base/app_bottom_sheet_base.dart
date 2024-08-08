import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/navigator.dart';

abstract class AppBottomSheetBase extends StatefulWidget {
  final VoidCallback? onClose;
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const AppBottomSheetBase({
    super.key,
    this.onClose,
    required this.appTheme,
    required this.localization,
  });

  @override
  State<StatefulWidget> createState() =>
      AppBottomSheetBaseState<AppBottomSheetBase>();
}

class AppBottomSheetBaseState<R extends AppBottomSheetBase> extends State<R> {
  AppTheme get appTheme => widget.appTheme;
  AppLocalizationManager get localization => widget.localization;

  Widget titleBuilder(
    BuildContext context,
  ) {
    throw UnimplementedError();
  }

  Widget subTitleBuilder(
    BuildContext context,
  ) {
    throw UnimplementedError();
  }

  Widget contentBuilder(
    BuildContext context,
  ) {
    throw UnimplementedError();
  }

  Widget bottomBuilder(
    BuildContext context,
  ) {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing06,
        vertical: Spacing.spacing05,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgPrimary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius06,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Center(
                  child: titleBuilder(
                    context,
                  ),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (widget.onClose != null) {
                    widget.onClose!();
                  } else {
                    AppNavigator.pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(
                    Spacing.spacing03,
                  ),
                  child: SvgPicture.asset(
                    AssetIconPath.icCommonClose,
                  ),
                ),
              ),
            ],
          ),
          subTitleBuilder(
            context,
          ),
          contentBuilder(
            context,
          ),
          bottomBuilder(
            context,
          ),
        ],
      ),
    );
  }
}

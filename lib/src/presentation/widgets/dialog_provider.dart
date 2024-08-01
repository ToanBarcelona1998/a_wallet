import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

import 'app_loading_widget.dart';

abstract interface class _DialogProviderWidget extends StatelessWidget {
  final AppTheme appTheme;

  const _DialogProviderWidget({
    required this.appTheme,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.spacing06,
        vertical: Spacing.spacing05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (headerBuilder(context, appTheme) != null) ...[
            headerBuilder(context, appTheme)!,
            const SizedBox(
              height: BoxSize.boxSize06,
            ),
          ],
          SingleChildScrollView(
            child: contentBuilder(context, appTheme),
          ),
          if (bottomBuilder(context, appTheme) != null) ...[
            const SizedBox(
              height: BoxSize.boxSize06,
            ),
            bottomBuilder(context, appTheme)!,
          ]
        ],
      ),
    );
  }

  Widget contentBuilder(BuildContext context, AppTheme appTheme);

  Widget? bottomBuilder(BuildContext content, AppTheme appTheme);

  Widget? headerBuilder(BuildContext context, AppTheme appTheme);
}

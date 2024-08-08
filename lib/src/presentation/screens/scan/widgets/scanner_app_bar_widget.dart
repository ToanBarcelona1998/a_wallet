import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScannerAppBarWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;

  const ScannerAppBarWidget({
    required this.appTheme,
    required this.localization,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.spacing04,
        ),
        child: SizedBox(
          width: context.w,
          child: Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  AppNavigator.pop();
                },
                child: SvgPicture.asset(
                  AssetIconPath.icScannerBack,
                ),
              ),
              Expanded(
                child: Text(
                  localization.translate(
                    LanguageKey.scanScreenAppBarTitle,
                  ),
                  style: AppTypoGraPhy.textMdBold.copyWith(
                    color: appTheme.textWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

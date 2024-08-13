import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class SettingSelectLanguageWidget extends AppBottomSheetBase {
  final List<String> languages;
  final String currentLanguage;

  const SettingSelectLanguageWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.languages,
    required this.currentLanguage,
  });

  @override
  State<StatefulWidget> createState() => _SettingSelectLanguageWidgetState();
}

final class _SettingSelectLanguageWidgetState
    extends AppBottomSheetBaseState<SettingSelectLanguageWidget> {
  @override
  Widget titleBuilder(BuildContext context) {
    return Text(
      localization.translate(
        LanguageKey.settingsPageSelectLanguage,
      ),
      style: AppTypoGraPhy.textMdSemiBold.copyWith(
        color: appTheme.textPrimary,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.languages.length,
        (index) => _option(
          widget.languages[index],
        ),
      ),
    );
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _option(String option) {
    bool isSelected = widget.currentLanguage == option;
    return GestureDetector(
      onTap: () {
        AppNavigator.pop(option);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(
          Spacing.spacing04,
        ),
        decoration: BoxDecoration(
          color: isSelected ? appTheme.bgBrandPrimary : appTheme.bgPrimary,
          borderRadius: BorderRadius.circular(
            BorderRadiusSize.borderRadius04,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option.toUpperCase(),
                style: AppTypoGraPhy.textMdSemiBold.copyWith(
                  color: appTheme.textPrimary,
                ),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(
                width: BoxSize.boxSize04,
              ),
              SvgPicture.asset(
                AssetIconPath.icCommonYetiHand,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

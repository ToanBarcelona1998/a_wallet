import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/divider_widget.dart';
import 'package:a_wallet/src/presentation/widgets/switch_widget.dart';
import 'package:a_wallet/src/presentation/widgets/text_input_search_widget.dart';

final class ManageTokenScreenHideSmallBalanceWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final TextEditingController searchController;

  const ManageTokenScreenHideSmallBalanceWidget({
    required this.appTheme,
    required this.localization,
    required this.searchController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    localization.translate(
                      LanguageKey.manageTokenScreenHideSmallBalance,
                    ),
                    style: AppTypoGraPhy.textMdMedium.copyWith(
                      color: appTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: BoxSize.boxSize04,
                  ),
                  SvgPicture.asset(
                    AssetIconPath.icCommonInformation,
                  ),
                ],
              ),
            ),
            SwitchWidget(
              onChanged: (p0) {},
              isSelected: false,
              appTheme: appTheme,
            ),
          ],
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        HoLiZonTalDividerWidget(
          appTheme: appTheme,
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
        TextInputSearchWidget(
          appTheme: appTheme,
          controller: searchController,
          hintText: localization.translate(
            LanguageKey.manageTokenScreenSearchHint,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize05,
        ),
      ],
    );
  }
}

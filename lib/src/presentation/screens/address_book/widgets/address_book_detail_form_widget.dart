import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/utils/aura_util.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';

class AddressBookDetailFormWidget extends StatelessWidget {
  final AppTheme appTheme;
  final AppLocalizationManager localization;
  final String name;
  final String address;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const AddressBookDetailFormWidget({
    super.key,
    required this.appTheme,
    required this.localization,
    required this.name,
    required this.address,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Spacing.spacing07,
        horizontal: Spacing.spacing05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.spacing07,
              vertical: Spacing.spacing05,
            ),
            width: double.maxFinite,
            margin: const EdgeInsets.only(
              top: Spacing.spacing06,
            ),
            decoration: BoxDecoration(
              color: appTheme.bgPrimary,
              borderRadius: BorderRadius.circular(
                BorderRadiusSize.borderRadius05,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypoGraPhy.textLgBold.copyWith(
                    color: appTheme.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: BoxSize.boxSize02,
                ),
                Text(
                  address.addressView,
                  style: AppTypoGraPhy.textSmMedium.copyWith(
                    color: appTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: BoxSize.boxSize07,
          ),
          IconWithTextWidget(
            titlePath: LanguageKey.addressBookScreenEdit,
            svgIconPath: AssetIconPath.icCommonEdit,
            appTheme: appTheme,
            onTap: onEdit,
            spacing: Spacing.spacing05,
            localization: localization,
          ),
          const SizedBox(
            height: BoxSize.boxSize05,
          ),
          IconWithTextWidget(
            titlePath: LanguageKey.addressBookScreenRemove,
            svgIconPath: AssetIconPath.icCommonDelete,
            appTheme: appTheme,
            onTap: onRemove,
            spacing: Spacing.spacing05,
            localization: localization,
          ),
        ],
      ),
    );
  }
}

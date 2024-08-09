import 'package:a_wallet/src/presentation/widgets/bottom_sheet_base/app_bottom_sheet_base.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/icon_with_text_widget.dart';

final class AddressBookDetailFormWidget extends AppBottomSheetBase {
  final String name;
  final String address;
  final VoidCallback onEdit;
  final VoidCallback onRemove;

  const AddressBookDetailFormWidget({
    super.key,
    required super.appTheme,
    required super.localization,
    required this.name,
    required this.address,
    required this.onEdit,
    required this.onRemove,
  });
  @override
  State<StatefulWidget> createState() => _AddressBookDetailFormWidgetState();
}

final class _AddressBookDetailFormWidgetState extends AppBottomSheetBaseState<AddressBookDetailFormWidget>{

  @override
  Widget titleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget subTitleBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget bottomBuilder(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget contentBuilder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.name,
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
          widget.address,
          style: AppTypoGraPhy.textSmMedium.copyWith(
            color: appTheme.textSecondary,
          ),
        ),
        const SizedBox(
          height: BoxSize.boxSize07,
        ),
        IconWithTextWidget(
          titlePath: LanguageKey.addressBookScreenEdit,
          svgIconPath: AssetIconPath.icCommonEdit,
          appTheme: appTheme,
          onTap: widget.onEdit,
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
          onTap: widget.onRemove,
          spacing: Spacing.spacing05,
          localization: localization,
        ),
      ],
    );
  }
}


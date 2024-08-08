import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddressBookWidget extends StatelessWidget {
  final String name;
  final String address;
  final AppTheme appTheme;
  final VoidCallback onTap;

  const AddressBookWidget({
    required this.name,
    required this.address,
    required this.appTheme,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
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
                  address,
                  style: AppTypoGraPhy.textSmMedium.copyWith(
                    color: appTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: BoxSize.boxSize05,
          ),
          SvgPicture.asset(
            AssetIconPath.icCommonMore,
          ),
        ],
      ),
    );
  }
}

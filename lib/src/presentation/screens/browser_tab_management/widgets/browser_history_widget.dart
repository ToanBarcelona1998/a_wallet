import 'dart:io';

import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrowserTabManagementHistoryWidget extends StatelessWidget {
  final String logo;
  final String siteName;
  final String imageUri;
  final AppTheme appTheme;
  final VoidCallback onClose;

  const BrowserTabManagementHistoryWidget({
    required this.logo,
    required this.siteName,
    required this.imageUri,
    required this.appTheme,
    required this.onClose,
    super.key,
  });

  static const double _size = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Spacing.spacing02,
      ),
      decoration: BoxDecoration(
        color: appTheme.bgSecondary,
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.spacing02,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    BorderRadiusSize.borderRadius04,
                  ),
                  child: NetworkImageWidget(
                    url: logo,
                    width: _size,
                    height: _size,
                    appTheme: appTheme,
                  ),
                ),
                const SizedBox(
                  width: BoxSize.boxSize04,
                ),
                Expanded(
                  child: Text(
                    siteName,
                    style: AppTypoGraPhy.textSmMedium.copyWith(
                      color: appTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: BoxSize.boxSize05,
                ),
                GestureDetector(
                  onTap: onClose,
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(
                    AssetIconPath.icCommonClose,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: BoxSize.boxSize05,
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                BorderRadiusSize.borderRadius04,
              ),
              child: Image(
                fit: BoxFit.cover,
                image: FileImage(
                  File(imageUri),
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    color: appTheme.bgPrimary,
                  );
                },
                width: double.maxFinite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/localization/localization_manager.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/utils/app_util.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/presentation/widgets/app_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'account_receive.dart';

class ReceiveTokenWidget extends StatelessWidget {
  final AppNetwork network;
  final Account ?account;
  final AppTheme theme;
  final VoidCallback onSwipeUp;
  final void Function(String) onShareAddress;
  final void Function(String) onCopyAddress;
  final AppLocalizationManager localization;
  final void Function() onDownload;

  const ReceiveTokenWidget({
    required this.network,
    required this.account,
    required this.theme,
    required this.onSwipeUp,
    required this.onShareAddress,
    required this.onCopyAddress,
    required this.localization,
    required this.onDownload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Triggered when a vertical drag gesture ends
      onVerticalDragEnd: (dragDetail) {
        if (dragDetail.velocity.pixelsPerSecond.dy < -50) {
          onSwipeUp.call();
        }
      },
      // Triggered when the widget is tapped
      onTap: () {
        onSwipeUp.call();
      },
      child: Material(
        color: Colors.transparent,
        child: Container(
          // Overlay color with opacity
          color: theme.alphaBlack70.withOpacity(0.7),
          width: context.w,
          height: context.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.spacing05,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(
                left: Spacing.spacing05,
                right: Spacing.spacing05,
                bottom: Spacing.spacing07,
                top: Spacing.spacing04,
              ),
              decoration: BoxDecoration(
                color: theme.bgPrimary,
                borderRadius: BorderRadius.circular(
                  BorderRadiusSize.borderRadius06,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Scrollable view widget
                  Text(
                    localization.translate(
                      LanguageKey.homeScreenReceiveAddress,
                    ),
                    style: AppTypoGraPhy.textLgBold.copyWith(
                      color: theme.textPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: BoxSize.boxSize08,
                  ),
                  // QR code image view
                  QrImageView(
                    data: account != null ? network.getAddress(account!) : '',
                    version: QrVersions.auto,
                    padding: EdgeInsets.zero,
                    backgroundColor: theme.bgPrimary,
                    size: context.w / 2,
                  ),
                  const SizedBox(
                    height: BoxSize.boxSize06,
                  ),
                  // Account card receive widget
                  HomeWalletReceiveWidget(
                    address: account != null ? network.getAddress(account!) : '',
                    type: network.name,
                    appTheme: theme,
                    logo: network.logo,
                    onCopy: onCopyAddress,
                    onShare: onShareAddress,
                  ),
                  const SizedBox(
                    height: BoxSize.boxSize07,
                  ),
                  // App localization provider
                  BorderAppButton(
                    leading: SvgPicture.asset(
                      AssetIconPath.icCommonDownloadImage,
                    ),
                    text: localization.translate(
                      LanguageKey.homeScreenSaveImageToDevice,
                    ),
                    onPress: onDownload,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

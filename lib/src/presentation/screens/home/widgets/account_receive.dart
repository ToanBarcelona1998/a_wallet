import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/wallet_info_widget.dart';

final class HomeWalletReceiveWidget extends StatelessWidget {
  final String logo;
  final String type;
  final String address;
  final AppTheme appTheme;
  final void Function(String) onCopy;
  final void Function(String) onShare;

  const HomeWalletReceiveWidget({
    required this.appTheme,
    required this.type,
    required this.address,
    required this.logo,
    required this.onCopy,
    required this.onShare,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WalletInfoWithCustomActionsWidget(
      avatarAsset: logo,
      appTheme: appTheme,
      title: type,
      address: address,
      action: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onShare(address),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.spacing04,
              ),
              child: SvgPicture.asset(
                AssetIconPath.icCommonShare,
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onCopy(address),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.spacing04,
              ),
              child: SvgPicture.asset(
                AssetIconPath.icCommonCopy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
